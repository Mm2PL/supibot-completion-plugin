local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__SetDescriptor = ____lualib.__TS__SetDescriptor
local __TS__Spread = ____lualib.__TS__Spread
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____json = require("json")
local decode = ____json.decode
local function load_file(fname, default_val)
    if default_val == nil then
        default_val = {}
    end
    local f, err = io.open(fname, "r")
    if err ~= nil or f == nil then
        c2.log(c2.LogLevel.Warning, "Failed to load file", fname, err)
        return default_val
    end
    local dat = f:read("a")
    print("loading file", fname)
    return decode(dat)
end
____exports.Config = __TS__Class()
local Config = ____exports.Config
Config.name = "Config"
function Config.prototype.____constructor(self)
    self["#data"] = load_file("config.json")
end
__TS__SetDescriptor(
    Config.prototype,
    "my_username",
    {
        get = function(self)
            local ____self__23data_my_username_0 = self["#data"].my_username
            if ____self__23data_my_username_0 == nil then
                ____self__23data_my_username_0 = ""
            end
            return ____self__23data_my_username_0
        end,
        set = function(self, val)
            self["#data"].my_username = val
        end
    },
    true
)
__TS__SetDescriptor(
    Config.prototype,
    "rewrite_gift",
    {
        get = function(self)
            local ____self__23data_rewrite_gift_1 = self["#data"].rewrite_gift
            if ____self__23data_rewrite_gift_1 == nil then
                ____self__23data_rewrite_gift_1 = false
            end
            return ____self__23data_rewrite_gift_1
        end,
        set = function(self, val)
            self["#data"].rewrite_gift = val
        end
    },
    true
)
local gen = load_file("completions_generated.json")
local definitions = gen.definitions
local git = gen.git
local excluded_flags = gen.excluded_flags
local aliases = __TS__ArrayMap(
    {__TS__Spread(load_file("aliases.json", {data = {}}).data)},
    function(____, inp)
        return {
            name = inp.name,
            created = inp.created,
            edited = inp.edited,
            link_author = inp.linkAuthor,
            link_name = inp.linkName,
            invocation = inp.invocation
        }
    end
)
____exports.default = {
    config = __TS__New(____exports.Config),
    definitions = definitions,
    git = git,
    excluded_flags = excluded_flags,
    aliases = aliases
}
return ____exports
