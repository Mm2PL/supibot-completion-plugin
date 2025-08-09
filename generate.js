'use strict';
const META_COMMANDS = ["pipe", "alias"];
const SUPINICS_CHANNEL_WHITELIST = [
    "current",
    "necrodancer",
    "playsound",
    "songrequest",
    "songrequestqueue",
    "streamgames",
    "texttospeech",
    "when",
    "wrongsong",
];
const ADMIN_MODE = false;
// specials:
// srrg


/**
 * @param fname {String}
 */
function renameFlag(fname) {
    return fname.replace("-", "_").toUpperCase();
}
const fs = require("fs");
const child_process = require('node:child_process');

(async () => {
    const {User} = (await import('./supibot/build/classes/user.js'));
    const {Command} = (await import('./supibot/build/classes/command.js'));
    const CMDPATH = './supibot/build/commands';
    const definitions = (await import(`${CMDPATH}/index.js`)).default;
    console.log(`Loaded ${definitions.length} commands successfully.`);

    const knownFlags = new Set();

    const COMMAND_SET_SUBCOMMANDS = (await import(`${CMDPATH}/set/subcommands/index.js`)).default;
    const TL_DEFINITIONS = (await import(`${CMDPATH}/twitchlotto/definitions.js`));
    const TT_DEFINITIONS = (await import(`${CMDPATH}/texttransform/transforms.js`)).default;
    const FISH_SUBCOMMANDS = (await import(`${CMDPATH}/fish/subcommands/index.js`)).default;

    function definitionToJson(def) {
        let flags = [];
        if (def.Flags !== null && def.Flags !== undefined) {
            flags = def.Flags.map(renameFlag);
        }
        if (META_COMMANDS.includes(def.Name)) {
            flags.push("META");
        }
        if (SUPINICS_CHANNEL_WHITELIST.includes(def.Name)) {
            flags.push("SUPINICS_ONLY");
            flags.splice(flags.findIndex(f => f === "WHITELIST"), 1);
        }
        flags.forEach(f => knownFlags.add(f));
        let eat_before_sub = 0;
        let subcommands = null;
        if (def.Name === "set") {
            subcommands = COMMAND_SET_SUBCOMMANDS.filter(v => !v.adminOnly || ADMIN_MODE).map(v => {
                let innersubs = null;
                if (v.name === "twitchlotto") {
                    innersubs = TL_DEFINITIONS.flags.map(
                        it => {
                            return {
                                name: it.name,
                                aliases: [],
                                pipe: true,
                                eat_before_sub_command: 0,

                                params: [],
                                flags: [],
                                subcommands: [],
                            };
                        }
                    );
                }
                return {
                    name: v.name,
                    aliases: v.aliases,
                    pipe: v.pipe || false,
                    subcommands: innersubs,
                    eat_before_sub_command: v.name === "twitchlotto" ? 1 : 0,

                    flags: [],
                    params: [],
                }
            });
        } else if (def.Name == "texttransform") {
            subcommands = TT_DEFINITIONS.types.map(t => {
                return {
                    name: t.name,
                    aliases: t.aliases,
                    pipe: true,

                    params: [],
                    flags: [],
                    subcommands: null,
                    eat_before_sub_command: 0
                }
            }
            );
        } else if (def.Name == "alias") {
            const subs = [
                { name: "add", aliases: ["create"] },
                { name: "upsert", aliases: ["addedit"] },
                { name: "check", aliases: ["list", "code", "spy"] },
                { name: "publish", aliases: [] },
                { name: "unpublish", aliases: [] },
                { name: "copy", aliases: ["copyplace"] },
                { name: "describe", aliases: [] },
                { name: "link", aliases: [] },
                { name: "delete", aliases: ["remove"] },
                { name: "rename", aliases: [] },
                { name: "restrict", aliases: [] },
                { name: "unrestrict", aliases: [] },
                { name: "run", aliases: ["try"] },
                { name: "duplicate", aliases: [] },
            ];
            subcommands = subs.map(t => {
                return {
                    ...t,
                    pipe: true,
                    eat_before_sub_command: 0,

                    params: [],
                    flags: [],
                    subcommands: null,
                }
            });
        }
        else if (def.Name === 'cookie') {
            const subs = [
                { name: "eat", aliases: [] },
                { name: "donate", aliases: ["give", "gift"] },
                { name: "stats", aliases: ["statistics"] },
                { name: "top", aliases: ["leaders", "leaderboard"] },
            ];
            subcommands = subs.map(t => {
                return {
                    ...t,
                    pipe: true,
                    eat_before_sub_command: 0,

                    params: [],
                    flags: [],
                    subcommands: null,
                }
            });
        } else if (def.Name === 'gift') {
            subcommands = [
                {
                    name: 'cookie',
                    aliases: [],
                    pipe: false,
                    eat_before_sub_command: 0,
                    params: [],
                    flags: [],
                    subcommands: null,
                }
            ];
        } else if (def.Name === 'fish') {
            subcommands = FISH_SUBCOMMANDS.map(it => ({
                name: it.name,
                aliases: it.aliases,
                pipe: true,
                eat_before_sub_command: 0,
                params: [],
                flags: [],
                subcommands: [],
            }));
        }

        return {
            name: def.Name,
            aliases: def.Aliases,
            params: def.Params,
            flags,
            subcommands: subcommands,
            eat_before_sub_command: eat_before_sub,
            pipe: def.Flags.includes("pipe")
        }
    }

    const defs = definitions.map(definitionToJson);

    const git = {
        commit: "<No data>",

        // last v
        version: "<Unknown>",
    };
    try {
        git.version = child_process.execSync('git describe --abbrev=0').toString().trim();
    } catch (e) {
        // no git
    }
    console.log(`Git version: ${git.version}`);
    try {
        git.commit = child_process.execSync('git rev-parse HEAD').toString().trim();
    } catch (e) {
        // no git
    }
    console.log(`Git version: ${git.commit}`);

    fs.writeFileSync("data/completions_generated.json", JSON.stringify({
        definitions: defs,
        git,
    }, null, 2));
    console.log('Done writing.');
    User.destroy();
    clearTimeout(User.highLoadUserInterval);
    // I HATE THIS
    Command.prototype.destroy = function() {
        this['#cooldownManager'].destroy();
    }
    Command.destroy();
})();
