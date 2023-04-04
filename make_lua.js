const EXCLUDE_FLAGS = [ "WHITELIST" ];
const META_COMMANDS = [ "pipe", "alias" ];
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


function stringToLua(str) {
    return `"${str.replace(/"/, `\\"`)}"`;
}


/**
 * @param fname {String}
 */
function renameFlag(fname) {
    return fname.replace("-", "_").toUpperCase();
}

(async () => {
    const fs = require("fs");

    const cmds = await (require('./supibot/commands').loadCommands({
        skipArchivedCommands: true
    }));
    const {definitions} = cmds;

    const knownFlags = new Set();

    function definitionToLua(def) {
        let params = [];
        if (def.Params !== null && def.Params !== undefined) {
            params = def.Params.map(p => 
                `{ name=${stringToLua(p.name)}, type=${stringToLua(p.type)} }`
            );
        }

        let aliases = [];
        if (def.Aliases !== null && def.Aliases !== undefined) {
            aliases = def.Aliases.map(stringToLua);
        }

        let flags = [];
        if (def.Flags !== null && def.Flags !== undefined) {
            flags = def.Flags.map(renameFlag).map(stringToLua);
        }
        if (META_COMMANDS.includes(def.Name)) {
            flags.push(stringToLua("META"));
        }
        if (SUPINICS_CHANNEL_WHITELIST.includes(def.Name)) {
            flags.push(stringToLua("SUPINICS_ONLY"));
            flags.splice(flags.findIndex(f => f === stringToLua("WHITELIST")), 1);
        }
        flags.forEach(f => knownFlags.add(f));
        let eatBeforeSub = 0;
        let subcommands = [];
        if (def.Name === "set") {
            const sd = def.Static_Data();
            subcommands = sd.variables.filter(v=>!v.adminOnly || ADMIN_MODE).map(v => {
                let innersubs = [];
                if (v.name === "twitchlotto") {
                    innersubs = require("./supibot/commands/twitchlotto/definitions.js").flags.map(
                        it => `
                        { name=${stringToLua(it.name)}, aliases={}, pipe=true, eat_before_sub_command=0 }`
                    );
                }
                const innersubsTxt = innersubs.length !== 0 ? `
                    subcommands={ ${innersubs.join(", ")} },
                ` : `
                    subcommands=nil,
                `;
                const subName = stringToLua(v.name);
                return `
                {
                    name=${subName},
                    aliases={ ${v.aliases.map(stringToLua).join(", ")} },
                    parameter=${stringToLua(v.parameter)},
                    pipe=${v.pipe || false},
                    ${innersubsTxt}
                    eat_before_sub_command=${v.name === "twitchlotto" ? 1 : 0}
                }`
            }
            );
        } else if (def.Name == "texttransform") {
            const transforms = require("./supibot/commands/texttransform/transforms.js");
            subcommands = transforms.types.map(t => 
                `
                {
                    name=${stringToLua(t.name)},
                    aliases={ ${t.aliases.map(stringToLua).join(", ")} },
                    pipe=true,
                    subcommands=nil
                }`
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
            subcommands = subs.map(t => 
                `
                {
                    name=${stringToLua(t.name)},
                    aliases={ ${t.aliases.map(stringToLua).join(", ")} },
                    pipe=true,
                    eat_before_sub_command=0
                }`
            );
        }

        const name = stringToLua(def.Name);
        const subcommandsTxt = subcommands.length !== 0 ? `
            subcommands={ ${subcommands.join(", ")} },
        ` : `
            subcommands=nil,
        `;
        return `
        {
            name=${name},
            aliases={ ${aliases.join(", ")} },
            params={ ${params.join(", ")} },
            flags={ ${flags.join(", ")} },
            ${subcommandsTxt}
            eat_before_sub_command=${eatBeforeSub}
        }`;
    }

    const defs = definitions.map(definitionToLua).join(",");
    const fileData = (`-- This file was autogenerated with make_lua.js from data within the supinic/supibot repo
-- If you run the script your changes will be lost
return {
    -- all flags: ${[...knownFlags].sort().join(", ")}
    -- unwhitelisted #supinic special commands are: ${SUPINICS_CHANNEL_WHITELIST.join(", ")}
    excluded_flags={ ${EXCLUDE_FLAGS.map(renameFlag).map(stringToLua).join(", ")} },
    definitions={${defs}
    },
}
`);
    fs.writeFileSync("completions_generated.lua", fileData);
})();
