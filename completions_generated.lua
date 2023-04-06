--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
return {definitions = {
    {
        name = "%",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "PIPE", "SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "8ball",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "9gag",
        aliases = {"gag"},
        params = nil,
        flags = {"EXTERNAL_INPUT", "MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "about",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "accountage",
        aliases = {"accage"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "addbetween",
        aliases = {"ab"},
        params = nil,
        flags = {"EXTERNAL_INPUT", "MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "afk",
        aliases = {
            "gn",
            "brb",
            "shower",
            "food",
            "lurk",
            "poop",
            "💩",
            "work",
            "study",
            "nap"
        },
        params = nil,
        flags = {"PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "alias",
        aliases = {"$"},
        params = nil,
        flags = {"EXTERNAL_INPUT", "MENTION", "PIPE", "META"},
        subcommands = {
            {
                name = "add",
                aliases = {"create"},
                pipe = true,
                eat_before_sub_command = 0,
                params = {},
                flags = {},
                subcommands = {}
            },
            {
                name = "upsert",
                aliases = {"addedit"},
                pipe = true,
                eat_before_sub_command = 0,
                params = {},
                flags = {},
                subcommands = {}
            },
            {
                name = "check",
                aliases = {"list", "code", "spy"},
                pipe = true,
                eat_before_sub_command = 0,
                params = {},
                flags = {},
                subcommands = {}
            },
            {
                name = "publish",
                aliases = {},
                pipe = true,
                eat_before_sub_command = 0,
                params = {},
                flags = {},
                subcommands = {}
            },
            {
                name = "unpublish",
                aliases = {},
                pipe = true,
                eat_before_sub_command = 0,
                params = {},
                flags = {},
                subcommands = {}
            },
            {
                name = "copy",
                aliases = {"copyplace"},
                pipe = true,
                eat_before_sub_command = 0,
                params = {},
                flags = {},
                subcommands = {}
            },
            {
                name = "describe",
                aliases = {},
                pipe = true,
                eat_before_sub_command = 0,
                params = {},
                flags = {},
                subcommands = {}
            },
            {
                name = "link",
                aliases = {},
                pipe = true,
                eat_before_sub_command = 0,
                params = {},
                flags = {},
                subcommands = {}
            },
            {
                name = "delete",
                aliases = {"remove"},
                pipe = true,
                eat_before_sub_command = 0,
                params = {},
                flags = {},
                subcommands = {}
            },
            {
                name = "rename",
                aliases = {},
                pipe = true,
                eat_before_sub_command = 0,
                params = {},
                flags = {},
                subcommands = {}
            },
            {
                name = "restrict",
                aliases = {},
                pipe = true,
                eat_before_sub_command = 0,
                params = {},
                flags = {},
                subcommands = {}
            },
            {
                name = "unrestrict",
                aliases = {},
                pipe = true,
                eat_before_sub_command = 0,
                params = {},
                flags = {},
                subcommands = {}
            },
            {
                name = "run",
                aliases = {"try"},
                pipe = true,
                eat_before_sub_command = 0,
                params = {},
                flags = {},
                subcommands = {}
            }
        },
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "aliasbuildingblock",
        aliases = {"abb"},
        params = {
            {name = "amount", type = "number"},
            {name = "em", type = "string"},
            {name = "errorMessage", type = "string"},
            {name = "excludeSelf", type = "boolean"},
            {name = "regex", type = "regex"},
            {name = "replacement", type = "string"}
        },
        flags = {"EXTERNAL_INPUT", "PIPE", "SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "artflow",
        aliases = {"rafi", "randomartflowimage"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE", "SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "atop",
        aliases = nil,
        params = nil,
        flags = {
            "DEVELOPER",
            "MENTION",
            "PIPE",
            "SYSTEM",
            "WHITELIST"
        },
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "automodcheck",
        aliases = {"amc"},
        params = nil,
        flags = {"DEVELOPER", "MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "badapplerendition",
        aliases = {"badapple", "bar"},
        params = nil,
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "ban",
        aliases = {"unban"},
        params = {
            {name = "all", type = "boolean"},
            {name = "channel", type = "string"},
            {name = "clear", type = "boolean"},
            {name = "command", type = "string"},
            {name = "index", type = "number"},
            {name = "invocation", type = "string"},
            {name = "multiplier", type = "number"},
            {name = "type", type = "string"},
            {name = "string", type = "string"},
            {name = "user", type = "string"}
        },
        flags = {"MENTION"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "bancheck",
        aliases = {"bc"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "beefact",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "block",
        aliases = {"unblock"},
        params = {{name = "channel", type = "string"}, {name = "command", type = "string"}, {name = "platform", type = "string"}, {name = "user", type = "string"}},
        flags = {"MENTION"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "bot",
        aliases = nil,
        params = {{name = "channel", type = "string"}, {name = "mode", type = "string"}, {name = "url", type = "string"}},
        flags = {"MENTION", "PIPE", "SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "botsubs",
        aliases = nil,
        params = {{name = "channel", type = "string"}, {name = "channelsOnly", type = "boolean"}, {name = "emotesOnly", type = "boolean"}},
        flags = {"PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "chan",
        aliases = {"4chan", "textchan", "filechan", "imagechan"},
        params = {{name = "regex", type = "regex"}, {name = "textOnly", type = "string"}},
        flags = {"EXTERNAL_INPUT", "MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "channelfounderlist",
        aliases = {"cfl", "founders"},
        params = {{name = "includeDates", type = "boolean"}, {name = "subStatus", type = "boolean"}},
        flags = {"MENTION"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "chatneighbour",
        aliases = {"cn"},
        params = nil,
        flags = {"BLOCK", "OPT_OUT", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "check",
        aliases = nil,
        params = {{name = "index", type = "number"}},
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "checkem",
        aliases = {"CheckEm", "check'em"},
        params = nil,
        flags = {"MENTION", "PIPE", "SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "code",
        aliases = nil,
        params = nil,
        flags = {"DEVELOPER", "MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "coinflip",
        aliases = {"cf"},
        params = {{name = "fail", type = "boolean"}},
        flags = {"MENTION", "PIPE", "SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "comment",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "commitcount",
        aliases = {"FarmingCommits"},
        params = {{name = "since", type = "date"}},
        flags = {
            "DEVELOPER",
            "MENTION",
            "NON_NULLABLE",
            "PIPE",
            "SKIP_BANPHRASE"
        },
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "cookie",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "PIPE", "ROLLBACK"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "copypasta",
        aliases = nil,
        params = {{name = "allowAsciiArt", type = "boolean"}},
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "corona",
        aliases = {"covid"},
        params = nil,
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "countline",
        aliases = {"cl"},
        params = nil,
        flags = {"MENTION", "OPT_OUT", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "countlinechannel",
        aliases = {"clc"},
        params = nil,
        flags = {"MENTION", "PIPE", "SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "countlinetotal",
        aliases = {"clt"},
        params = nil,
        flags = {"MENTION"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "crypto",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "cryptogame",
        aliases = {"cg"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "cryptowallet",
        aliases = {"cw"},
        params = {{name = "type", type = "string"}},
        flags = {"MENTION", "PIPE", "SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "currency",
        aliases = {"money"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE", "SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "current",
        aliases = {"song"},
        params = {{name = "linkOnly", type = "boolean"}},
        flags = {"DEVELOPER", "MENTION", "PIPE", "SUPINICS_ONLY"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "dalle",
        aliases = {},
        params = {{name = "id", type = "string"}, {name = "random", type = "boolean"}, {name = "search", type = "string"}},
        flags = {"MENTION", "NON_NULLABLE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "dankdebug",
        aliases = {"js"},
        params = {
            {name = "arguments", type = "string"},
            {name = "errorInfo", type = "boolean"},
            {name = "force", type = "boolean"},
            {name = "function", type = "string"},
            {name = "importGist", type = "string"}
        },
        flags = {"EXTERNAL_INPUT", "DEVELOPER", "MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "dayoftheyear",
        aliases = {"doty", "monthoftheyear", "moty"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE", "SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "debug",
        aliases = nil,
        params = {{name = "function", type = "string"}, {name = "importGist", type = "string"}},
        flags = {
            "EXTERNAL_INPUT",
            "DEVELOPER",
            "PIPE",
            "SKIP_BANPHRASE",
            "SYSTEM",
            "WHITELIST"
        },
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "define",
        aliases = {"def"},
        params = {{name = "lang", type = "string"}},
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "devnull",
        aliases = {"/dev/null", "null"},
        params = nil,
        flags = {"NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "dictionary",
        aliases = {"dict"},
        params = {{name = "index", type = "string"}},
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "discord",
        aliases = nil,
        params = nil,
        flags = {"EXTERNAL_INPUT", "MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "doesnotexist",
        aliases = {"dne"},
        params = {{name = "linkOnly", type = "boolean"}, {name = "summary", type = "boolean"}, {name = "wordOnly", type = "boolean"}},
        flags = {"NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "downloadclip",
        aliases = {"dlclip"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "emotecheck",
        aliases = {"ec"},
        params = nil,
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "epal",
        aliases = {"ForeverAlone"},
        params = {{name = "game", type = "string"}, {name = "gender", type = "string"}, {name = "sex", type = "string"}},
        flags = {"MENTION"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "externalbot",
        aliases = {"ebot"},
        params = nil,
        flags = {"EXTERNAL_INPUT", "MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "faceit",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "fakenews",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "faq",
        aliases = {},
        params = nil,
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "fill",
        aliases = nil,
        params = nil,
        flags = {"PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "findraidstreams",
        aliases = {"frs"},
        params = {{name = "haste", type = "string"}},
        flags = {"DEVELOPER", "PIPE", "WHITELIST"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "firstchannelfollower",
        aliases = {"fcf"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "OPT_OUT", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "firstfollowedchannel",
        aliases = {"ffc"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "OPT_OUT", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "firstline",
        aliases = {"fl"},
        params = {{name = "channel", type = "string"}, {name = "textOnly", type = "boolean"}},
        flags = {"EXTERNAL_INPUT", "MENTION", "OPT_OUT", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "firstseen",
        aliases = {"fs"},
        params = nil,
        flags = {"BLOCK", "MENTION", "OPT_OUT", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "followage",
        aliases = {"fa"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "formula1",
        aliases = {"f1"},
        params = {{name = "season", type = "number"}, {name = "year", type = "number"}, {name = "weather", type = "boolean"}},
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "forsenCD",
        aliases = {"pajaCD"},
        params = nil,
        flags = {"PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "forsenE",
        aliases = nil,
        params = nil,
        flags = {"PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "fuck",
        aliases = nil,
        params = nil,
        flags = {"BLOCK", "MENTION", "OPT_OUT", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "funfact",
        aliases = {"ff"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "gachi",
        aliases = {"gachilist", "gl"},
        params = nil,
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "gachicheck",
        aliases = {"gc"},
        params = nil,
        flags = {"MENTION", "PIPE", "SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "gachisearch",
        aliases = {"gs", "gsa", "gachiauthorsearch"},
        params = {{name = "linkOnly", type = "boolean"}},
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "gamesdonequick",
        aliases = {"gdq"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "getprofilepicture",
        aliases = {"avatar", "pfp"},
        params = {{name = "banner", type = "boolean"}, {name = "linkOnly", type = "boolean"}},
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "getvideodata",
        aliases = {"gvd"},
        params = nil,
        flags = {"DEVELOPER", "MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "gift",
        aliases = {"give"},
        params = nil,
        flags = {"DEVELOPER", "MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "github",
        aliases = nil,
        params = nil,
        flags = {"DEVELOPER", "MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "githubstatus",
        aliases = {"ghs"},
        params = nil,
        flags = {"DEVELOPER", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "gpt",
        aliases = {"chatgpt"},
        params = {
            {name = "context", type = "string"},
            {name = "history", type = "string"},
            {name = "model", type = "string"},
            {name = "limit", type = "number"},
            {name = "temperature", type = "number"}
        },
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "haHAA",
        aliases = {"4Head", "4HEad", "HEad"},
        params = {{name = "search", type = "string"}},
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "help",
        aliases = {"commands", "helpgrep"},
        params = nil,
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "horoscope",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "howlongtobeat",
        aliases = {"hltb"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "hug",
        aliases = nil,
        params = nil,
        flags = {"OPT_OUT", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "id",
        aliases = {"uid"},
        params = nil,
        flags = {"MENTION", "PIPE", "SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "inspireme",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "isdown",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "joinchannel",
        aliases = nil,
        params = {{name = "platform", type = "string"}, {name = "silent", type = "boolean"}},
        flags = {"MENTION", "PIPE", "SYSTEM", "WHITELIST"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "kanji",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "kiss",
        aliases = nil,
        params = nil,
        flags = {"OPT_OUT", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "knowyourmeme",
        aliases = {"kym"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "lastcommand",
        aliases = {"_"},
        params = {{name = "input", type = "boolean"}},
        flags = {"PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "lastline",
        aliases = {"ll", "lastmessage", "lm"},
        params = {{name = "textOnly", type = "boolean"}},
        flags = {"EXTERNAL_INPUT", "MENTION", "OPT_OUT", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "lastseen",
        aliases = {"ls"},
        params = nil,
        flags = {"BLOCK", "MENTION", "OPT_OUT", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "link",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "SYSTEM"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "liveuamap",
        aliases = {"lum", "luam"},
        params = {{name = "lang", type = "string"}},
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "markov",
        aliases = nil,
        params = {
            {name = "debug", type = "string"},
            {name = "dull", type = "boolean"},
            {name = "channel", type = "string"},
            {name = "exact", type = "boolean"},
            {name = "stop", type = "boolean"},
            {name = "words", type = "number"}
        },
        flags = {"NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "mastodon",
        aliases = {},
        params = {{name = "instance", type = "string"}, {name = "random", type = "boolean"}},
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "math",
        aliases = nil,
        params = {{name = "fixed", type = "boolean"}, {name = "precision", type = "number"}},
        flags = {"EXTERNAL_INPUT", "MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "mdn",
        aliases = nil,
        params = nil,
        flags = {"DEVELOPER", "MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "me",
        aliases = {"/me"},
        params = nil,
        flags = {},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "necrodancer",
        aliases = {"nd", "ndr", "necrodancerreset"},
        params = {{name = "zone", type = "string"}},
        flags = {"DEVELOPER", "MENTION", "PIPE", "SUPINICS_ONLY"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "news",
        aliases = nil,
        params = {{name = "country", type = "string"}},
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "npm",
        aliases = nil,
        params = nil,
        flags = {"DEVELOPER", "MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "nutrients",
        aliases = nil,
        params = {{name = "specific", type = "string"}},
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "ocr",
        aliases = nil,
        params = {{name = "engine", type = "number"}, {name = "force", type = "boolean"}, {name = "lang", type = "string"}},
        flags = {"EXTERNAL_INPUT", "MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "optout",
        aliases = {"unoptout"},
        params = nil,
        flags = {"MENTION", "SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "origin",
        aliases = nil,
        params = {{name = "index", type = "number"}},
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "osrs",
        aliases = nil,
        params = {
            {name = "activity", type = "string"},
            {name = "boss", type = "string"},
            {name = "force", type = "boolean"},
            {name = "rude", type = "boolean"},
            {name = "seasonal", type = "boolean"},
            {name = "skill", type = "string"},
            {name = "virtual", type = "boolean"}
        },
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "pastebin",
        aliases = {
            "pbg",
            "pbp",
            "gist",
            "hbg",
            "hbp"
        },
        params = {{name = "hasteServer", type = "string"}, {name = "force", type = "boolean"}, {name = "gistUser", type = "string"}, {name = "raw", type = "boolean"}},
        flags = {"EXTERNAL_INPUT", "MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "pick",
        aliases = nil,
        params = {{name = "delimiter", type = "string"}},
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "ping",
        aliases = {
            "pang",
            "peng",
            "pong",
            "pung",
            "pyng"
        },
        params = nil,
        flags = {"PIPE", "SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "pingme",
        aliases = {"letmeknow", "lmk"},
        params = nil,
        flags = {"BLOCK", "MENTION", "OPT_OUT", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "pipe",
        aliases = nil,
        params = {{name = "_apos", type = "object"}, {name = "_char", type = "string"}, {name = "_force", type = "boolean"}, {name = "_pos", type = "number"}},
        flags = {"MENTION", "PIPE", "META"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "playsound",
        aliases = {"ps"},
        params = nil,
        flags = {"DEVELOPER", "MENTION", "PIPE", "SUPINICS_ONLY"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "poe",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "pyramid",
        aliases = nil,
        params = nil,
        flags = {"DEVELOPER", "WHITELIST"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "query",
        aliases = {"wolframalpha", "wa"},
        params = {{name = "imageSummary", type = "boolean"}},
        flags = {"EXTERNAL_INPUT", "MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randomalbum",
        aliases = {"ra"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randomanimalfact",
        aliases = {
            "raf",
            "rbf",
            "rcf",
            "rdf",
            "rff"
        },
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randomanimalpicture",
        aliases = {
            "rap",
            "rbp",
            "rcp",
            "rdp",
            "rfp"
        },
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randomclip",
        aliases = {"rc"},
        params = {
            {name = "author", type = "string"},
            {name = "dateFrom", type = "date"},
            {name = "dateTo", type = "date"},
            {name = "limit", type = "number"},
            {name = "linkOnly", type = "boolean"},
            {name = "period", type = "string"}
        },
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randomcocktail",
        aliases = {"cock", "drinks", "tail", "cocktail"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randomcommandalias",
        aliases = {"rca"},
        params = {
            {name = "body", type = "string"},
            {name = "command", type = "string"},
            {name = "createdAfter", type = "date"},
            {name = "createdBefore", type = "date"},
            {name = "description", type = "string"},
            {name = "name", type = "string"},
            {name = "user", type = "string"}
        },
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randomdonger",
        aliases = {"rd"},
        params = nil,
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randomemoji",
        aliases = {"re"},
        params = nil,
        flags = {"PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randomemote",
        aliases = {"rem"},
        params = {
            {name = "7tv", type = "boolean"},
            {name = "animated", type = "boolean"},
            {name = "bttv", type = "boolean"},
            {name = "channel", type = "string"},
            {name = "ffz", type = "boolean"},
            {name = "follower", type = "boolean"},
            {name = "global", type = "boolean"},
            {name = "repeat", type = "boolean"},
            {name = "regex", type = "regex"},
            {name = "sub", type = "boolean"},
            {name = "twitch", type = "boolean"}
        },
        flags = {"PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randomfilm",
        aliases = {"rf"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randomgachi",
        aliases = {"rg"},
        params = {{name = "fav", type = "string"}, {name = "linkOnly", type = "boolean"}, {name = "type", type = "string"}},
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randomgeneratedmeme",
        aliases = {"rgm"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randomhistoricevent",
        aliases = {"rhe"},
        params = nil,
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randominstagram",
        aliases = {"rig"},
        params = {{name = "rawLinkOnly", type = "boolean"}, {name = "postLinkOnly", type = "boolean"}},
        flags = {"MENTION", "NON_NULLABLE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "randomline",
        aliases = {"rl", "rq"},
        params = {{name = "textOnly", type = "boolean"}},
        flags = {"BLOCK", "EXTERNAL_INPUT", "OPT_OUT", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randommeal",
        aliases = {"rmeal"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randommeme",
        aliases = {"rm"},
        params = {
            {name = "comments", type = "boolean"},
            {name = "flair", type = "string"},
            {name = "ignoreFlair", type = "string"},
            {name = "linkOnly", type = "boolean"},
            {name = "showFlairs", type = "boolean"},
            {name = "skipGalleries", type = "boolean"}
        },
        flags = {"EXTERNAL_INPUT", "MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randompastebin",
        aliases = {"rpb"},
        params = {{name = "linkOnly", type = "boolean"}, {name = "syntax", type = "string"}},
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randomsadcat",
        aliases = {"rsc"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randomscp",
        aliases = {"rscp"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randomuploadervideo",
        aliases = {"ruv"},
        params = {{name = "linkOnly", type = "boolean"}},
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "randomword",
        aliases = {"rw"},
        params = {{name = "endsWith", type = "string"}, {name = "regex", type = "regex"}, {name = "startsWith", type = "string"}},
        flags = {"PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "record",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "reload",
        aliases = nil,
        params = {{name = "skipUpgrade", type = "boolean"}},
        flags = {"PIPE", "SKIP_BANPHRASE", "SYSTEM", "WHITELIST"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "remind",
        aliases = {"notify", "remindme", "remindprivate", "privateremind"},
        params = {{name = "after", type = "string"}, {name = "at", type = "string"}, {name = "on", type = "string"}, {name = "private", type = "boolean"}},
        flags = {"BLOCK", "MENTION", "OPT_OUT", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "reset",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "PIPE", "SYSTEM"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "restart",
        aliases = nil,
        params = nil,
        flags = {"SYSTEM", "WHITELIST"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "resumeafk",
        aliases = {"rafk", "cafk", "continueafk"},
        params = nil,
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "roll",
        aliases = {"dice"},
        params = {{name = "textOnly", type = "boolean"}},
        flags = {"MENTION", "PIPE", "SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "russianarmylosses",
        aliases = {"ral"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "russianroulette",
        aliases = {"rr"},
        params = nil,
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "schedule",
        aliases = nil,
        params = nil,
        flags = {
            "EXTERNAL_INPUT",
            "MENTION",
            "NON_NULLABLE",
            "OPT_OUT",
            "PIPE"
        },
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "set",
        aliases = {"unset"},
        params = {{name = "from", type = "string"}},
        flags = {"MENTION", "OWNER_OVERRIDE", "PIPE"},
        subcommands = {
            {
                name = "reminder",
                aliases = {"remind", "reminders"},
                pipe = true,
                subcommands = {},
                eat_before_sub_command = 0,
                flags = {},
                params = {}
            },
            {
                name = "suggestion",
                aliases = {"suggest", "suggestions"},
                pipe = false,
                subcommands = {},
                eat_before_sub_command = 0,
                flags = {},
                params = {}
            },
            {
                name = "location",
                aliases = {},
                pipe = false,
                subcommands = {},
                eat_before_sub_command = 0,
                flags = {},
                params = {}
            },
            {
                name = "gc",
                aliases = {},
                pipe = true,
                subcommands = {},
                eat_before_sub_command = 0,
                flags = {},
                params = {}
            },
            {
                name = "discord",
                aliases = {},
                pipe = false,
                subcommands = {},
                eat_before_sub_command = 0,
                flags = {},
                params = {}
            },
            {
                name = "birthday",
                aliases = {"bday"},
                pipe = false,
                subcommands = {},
                eat_before_sub_command = 0,
                flags = {},
                params = {}
            },
            {
                name = "language",
                aliases = {"lang"},
                pipe = false,
                subcommands = {},
                eat_before_sub_command = 0,
                flags = {},
                params = {}
            },
            {
                name = "twitchlotto",
                aliases = {"tl"},
                pipe = true,
                subcommands = {},
                eat_before_sub_command = 1,
                flags = {},
                params = {}
            },
            {
                name = "twitchlottodescription",
                aliases = {"tld"},
                pipe = true,
                subcommands = {},
                eat_before_sub_command = 0,
                flags = {},
                params = {}
            },
            {
                name = "twitchlottoblacklist",
                aliases = {"tlbl"},
                pipe = false,
                subcommands = {},
                eat_before_sub_command = 0,
                flags = {},
                params = {}
            },
            {
                name = "instagram-nsfw",
                aliases = {"rig-nsfw"},
                pipe = false,
                subcommands = {},
                eat_before_sub_command = 0,
                flags = {},
                params = {}
            },
            {
                name = "reddit-nsfw",
                aliases = {"rm-nsfw"},
                pipe = false,
                subcommands = {},
                eat_before_sub_command = 0,
                flags = {},
                params = {}
            },
            {
                name = "twitch-lotto-nsfw",
                aliases = {"twitchlotto-nsfw", "tl-nsfw"},
                pipe = false,
                subcommands = {},
                eat_before_sub_command = 0,
                flags = {},
                params = {}
            },
            {
                name = "twitter-nsfw",
                aliases = {"tweet-nsfw"},
                pipe = false,
                subcommands = {},
                eat_before_sub_command = 0,
                flags = {},
                params = {}
            },
            {
                name = "timer",
                aliases = {},
                pipe = true,
                subcommands = {},
                eat_before_sub_command = 0,
                flags = {},
                params = {}
            },
            {
                name = "trackfavourite",
                aliases = {
                    "tf",
                    "track-fav",
                    "trackfavorite",
                    "track-favourite",
                    "track-favorite"
                },
                pipe = true,
                subcommands = {},
                eat_before_sub_command = 0,
                flags = {},
                params = {}
            }
        },
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "shoutout",
        aliases = {"so"},
        params = nil,
        flags = {"MENTION"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "shuffle",
        aliases = nil,
        params = {{name = "fancy", type = "boolean"}},
        flags = {"NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "simplesql",
        aliases = {"ssql"},
        params = nil,
        flags = {"MENTION", "PIPE", "SYSTEM", "WHITELIST"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "slots",
        aliases = nil,
        params = {{name = "pattern", type = "string"}},
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "songrequest",
        aliases = {"sr"},
        params = {{name = "start", type = "string"}, {name = "end", type = "string"}, {name = "type", type = "string"}},
        flags = {"MENTION", "PIPE", "SUPINICS_ONLY"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "songrequestqueue",
        aliases = {"srq", "queue"},
        params = nil,
        flags = {"MENTION", "PIPE", "SUPINICS_ONLY"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "songrequestrandomgachi",
        aliases = {"gsr", "srg", "srrg"},
        params = {{name = "fav", type = "string"}},
        flags = {"SKIP_BANPHRASE", "WHITELIST"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "sort",
        aliases = nil,
        params = nil,
        flags = {"NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "speedrun",
        aliases = nil,
        params = {
            {name = "category", type = "string"},
            {name = "showCategories", type = "boolean"},
            {name = "abbreviation", type = "string"},
            {name = "abbr", type = "string"},
            {name = "runner", type = "string"}
        },
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "stackoverflowsearch",
        aliases = {"stackoverflow", "sos"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "stalk",
        aliases = nil,
        params = nil,
        flags = {
            "BLOCK",
            "EXTERNAL_INPUT",
            "MENTION",
            "OPT_OUT",
            "PIPE"
        },
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "statistics",
        aliases = {"stat", "stats"},
        params = {{name = "recalculate", type = "boolean"}},
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "steamgameplayers",
        aliases = {"sgp"},
        params = {{name = "gameID", type = "string"}},
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "stock",
        aliases = {"stocks", "stonks"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "stream",
        aliases = nil,
        params = nil,
        flags = {
            "DEVELOPER",
            "MENTION",
            "PIPE",
            "SYSTEM",
            "WHITELIST"
        },
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "streamgames",
        aliases = {"games", "sg"},
        params = nil,
        flags = {
            "DEVELOPER",
            "MENTION",
            "PIPE",
            "SYSTEM",
            "SUPINICS_ONLY"
        },
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "streaminfo",
        aliases = {"si", "uptime", "vod"},
        params = {{name = "summary", type = "boolean"}, {name = "youtube", type = "string"}},
        flags = {"EXTERNAL_INPUT", "MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "subage",
        aliases = {"sa"},
        params = nil,
        flags = {"MENTION"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "subscribe",
        aliases = {"unsubscribe"},
        params = nil,
        flags = {"MENTION", "PIPE", "SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "suggest",
        aliases = {"suggestions"},
        params = {{name = "amend", type = "number"}},
        flags = {"MENTION", "SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "supibotupdates",
        aliases = nil,
        params = nil,
        flags = {"PING"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "test",
        aliases = nil,
        params = {
            {name = "boolean", type = "boolean"},
            {name = "date", type = "date"},
            {name = "number", type = "number"},
            {name = "object", type = "object"},
            {name = "regex", type = "regex"},
            {name = "string", type = "string"}
        },
        flags = {"DEVELOPER", "PIPE", "SKIP_BANPHRASE", "SYSTEM"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "texttospeech",
        aliases = {"tts"},
        params = {{name = "lang", type = "string"}, {name = "language", type = "string"}, {name = "speed", type = "number"}},
        flags = {"MENTION", "PIPE", "SKIP_BANPHRASE", "SUPINICS_ONLY"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "texttransform",
        aliases = {"tt", "reversetexttransform", "rtt"},
        params = nil,
        flags = {"EXTERNAL_INPUT", "NON_NULLABLE", "PIPE"},
        subcommands = {
            {
                name = "bubble",
                aliases = {},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "fancy",
                aliases = {},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "upside-down",
                aliases = {"flipped", "ud", "upsidedown"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "elite",
                aliases = {"leet", "l33t", "1337"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "medieval",
                aliases = {},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "runic",
                aliases = {"runes"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "superscript",
                aliases = {"smol", "super"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "vaporwave",
                aliases = {"vw", "vapor"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "cockney",
                aliases = {"3Head"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "cowboy",
                aliases = {"KKona", "KKonaW"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "outback",
                aliases = {"KKrikey", "australian"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "capitalize",
                aliases = {"cap"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "lowercase",
                aliases = {"lc", "lower"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "uppercase",
                aliases = {"uc", "upper"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "monkaOMEGA",
                aliases = {},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "OMEGALUL",
                aliases = {},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "owoify",
                aliases = {"owo", "uwu", "uwuify"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "reverse",
                aliases = {},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "random",
                aliases = {},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "antiping",
                aliases = {"unping"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "trim",
                aliases = {},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "explode",
                aliases = {},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "binary",
                aliases = {"bin"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "morse",
                aliases = {},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "box",
                aliases = {"boxes"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "spongebob",
                aliases = {"mock", "mocking", "spongemock"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "typoglycemia",
                aliases = {"tg", "jumble"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "official",
                aliases = {},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "base64",
                aliases = {"b64"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "ascii",
                aliases = {},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "hex",
                aliases = {"hexadecimal"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "forsen",
                aliases = {"forsencode"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            },
            {
                name = "spurdo",
                aliases = {"fug", "Spurdo"},
                pipe = true,
                params = {},
                flags = {},
                subcommands = {},
                eat_before_sub_command = 0
            }
        },
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "tf2",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "thesaurus",
        aliases = nil,
        params = {{name = "singleWord", type = "boolean"}},
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "time",
        aliases = nil,
        params = nil,
        flags = {
            "BLOCK",
            "MENTION",
            "NON_NULLABLE",
            "OPT_OUT",
            "PIPE"
        },
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "top",
        aliases = nil,
        params = nil,
        flags = {"MENTION"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "topgames",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "topstreams",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "totalcountline",
        aliases = {"acl", "tcl"},
        params = nil,
        flags = {"MENTION", "PIPE", "SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "trackreupload",
        aliases = {"tr"},
        params = nil,
        flags = {"DEVELOPER", "MENTION", "PIPE", "WHITELIST"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "translate",
        aliases = nil,
        params = {
            {name = "confidence", type = "boolean"},
            {name = "engine", type = "string"},
            {name = "from", type = "string"},
            {name = "to", type = "string"},
            {name = "textOnly", type = "string"}
        },
        flags = {"EXTERNAL_INPUT", "MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "transliterate",
        aliases = nil,
        params = {{name = "japaneseOnly", type = "boolean"}},
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "truck",
        aliases = nil,
        params = nil,
        flags = {"BLOCK", "OPT_OUT", "PIPE", "SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "tuck",
        aliases = {"gnkiss", "headpat"},
        params = nil,
        flags = {"BLOCK", "OPT_OUT", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "twitchlotto",
        aliases = {"tl"},
        params = {{name = "excludeChannel", type = "string"}, {name = "excludeChannels", type = "string"}, {name = "forceUnscored", type = "boolean"}, {name = "preferUnscored", type = "boolean"}},
        flags = {"MENTION"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "twitchlottoexplain",
        aliases = {"tle"},
        params = nil,
        flags = {"MENTION"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "twitter",
        aliases = {"tweet"},
        params = {
            {name = "includeReplies", type = "boolean"},
            {name = "includeRetweets", type = "boolean"},
            {name = "mediaOnly", type = "boolean"},
            {name = "random", type = "boolean"},
            {name = "textOnly", type = "boolean"},
            {name = "trends", type = "string"}
        },
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "unmention",
        aliases = {"remention"},
        params = nil,
        flags = {"MENTION"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "unping",
        aliases = {"reping"},
        params = nil,
        flags = {"MENTION"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "urban",
        aliases = nil,
        params = {{name = "index", type = "number"}},
        flags = {"EXTERNAL_INPUT", "MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "vanish",
        aliases = nil,
        params = nil,
        flags = {"SKIP_BANPHRASE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "videostats",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE", "WHITELIST"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "vote",
        aliases = {"poll"},
        params = nil,
        flags = {"MENTION", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "weather",
        aliases = nil,
        params = {
            {name = "alerts", type = "boolean"},
            {name = "format", type = "string"},
            {name = "latitude", type = "number"},
            {name = "longitude", type = "number"},
            {name = "pollution", type = "boolean"},
            {name = "radar", type = "boolean"}
        },
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "whatanimeisit",
        aliases = {"tracemoe"},
        params = nil,
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "whatemoteisit",
        aliases = {"weit"},
        params = {{name = "linkOnly", type = "boolean"}},
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "when",
        aliases = nil,
        params = nil,
        flags = {"MENTION", "PIPE", "SUPINICS_ONLY"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "whisper",
        aliases = {"/w", "pm"},
        params = nil,
        flags = {},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = false
    },
    {
        name = "wiki",
        aliases = nil,
        params = {{name = "lang", type = "language"}, {name = "linkOnly", type = "boolean"}},
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "wrongsong",
        aliases = {"ws"},
        params = nil,
        flags = {"DEVELOPER", "MENTION", "PIPE", "SUPINICS_ONLY"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    },
    {
        name = "youtubesearch",
        aliases = {"ys"},
        params = {{name = "index", type = "number"}, {name = "linkOnly", type = "boolean"}},
        flags = {"MENTION", "NON_NULLABLE", "PIPE"},
        subcommands = nil,
        eat_before_sub_command = 0,
        pipe = true
    }
}, excluded_flags = {"WHITELIST"}}
