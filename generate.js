const EXCLUDE_FLAGS = ["WHITELIST"];
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

(async () => {
    const supicore = await import("./supibot/node_modules/supi-core/index.js");

    globalThis.sb = {
        Date: supicore.Date,
        Error: supicore.Error,
        Promise: supicore.Promise,
        Got: supicore.Got,
        Metrics: new supicore.Metrics(),
        Utils: new supicore.Utils()
    };

    const cmds = await (require('./supibot/commands').loadCommands({
        skipArchivedCommands: true
    }));
    const {definitions, failed, skipped} = cmds;
    console.log("Skipped commands: ", skipped);
    console.log("Failed commands: ", failed);
    console.log(`Loaded ${definitions.length} commands successfully.`);

    const knownFlags = new Set();

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
            const sd = def.Static_Data();
            subcommands = sd.variables.filter(v => !v.adminOnly || ADMIN_MODE).map(v => {
                let innersubs = null;
                if (v.name === "twitchlotto") {
                    innersubs = require("./supibot/commands/twitchlotto/definitions.js").flags.map(
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
            }
            );
        } else if (def.Name == "texttransform") {
            const transforms = require("./supibot/commands/texttransform/transforms.js");
            subcommands = transforms.types.map(t => {
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
                {name: "add", aliases: ["create"]},
                {name: "upsert", aliases: ["addedit"]},
                {name: "check", aliases: ["list", "code", "spy"]},
                {name: "publish", aliases: []},
                {name: "unpublish", aliases: []},
                {name: "copy", aliases: ["copyplace"]},
                {name: "describe", aliases: []},
                {name: "link", aliases: []},
                {name: "delete", aliases: ["remove"]},
                {name: "rename", aliases: []},
                {name: "restrict", aliases: []},
                {name: "unrestrict", aliases: []},
                {name: "run", aliases: ["try"]},
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
            }
            );
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

    let aliases = [];
    const config = require('./config.json');
    if (!config.myUsername) {
        console.log("Skipping generation of user-specific data, no username given in config.");
    } else {
        const r = await fetch(`https://supinic.com/api/bot/user/${config.myUsername}/alias/list`);
        if (r.status !== 200) {
            console.log(`supinic.com api unexpectidly returned ${r.status}, abort`);
            return;
        }
        const data = await r.json();
        console.log(`Downloaded ${data.data.length} aliases from supinic.com`);
        aliases = data.data.map(inp => {
            return {
                name: inp.name,
                created: inp.created,
                edited: inp.edited,
                link_author: inp.linkAuthor,
                link_name: inp.linkName,

                invocation: inp.invocation,
            }
        });
    }
    fs.writeFileSync("completions_generated.json", JSON.stringify({
        definitions: defs,
        excluded_flags: EXCLUDE_FLAGS,

        // user specific
        config,
        aliases,
    }));
})();
