local ____lualib = require("lualib_bundle")
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ObjectEntries = ____lualib.__TS__ObjectEntries
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local ____exports = {}
local props
local ____data = require("data")
local storage = ____data.default
local ____utils = require("utils")
local utils = ____utils.default
local ____storage_0 = storage
local config = ____storage_0.config
local function config_show(ctx, args)
    ctx.channel:add_system_message("Supibot Completion Plugin config:")
    for ____, p in ipairs(props) do
        ctx.channel:add_system_message((((("[" .. p.name) .. "] ") .. p.display) .. ": ") .. tostring(config.data[p.name]))
    end
end
local function config_set(ctx, args)
    if #args == 0 then
        ctx.channel:add_system_message("Usage: /sbc:config set <property_name> <value>")
        return
    end
    local prop = table.remove(ctx.words, 1)
    local value = table.remove(ctx.words, 1)
    if prop == nil or value == nil then
        return assert(false)
    end
    local p = __TS__ArrayFind(
        props,
        function(____, v) return v.name == prop end
    )
    if p == nil then
        ctx.channel:add_system_message("Unknown sbc config: " .. prop)
        return
    end
    do
        local function ____catch(e)
            ctx.channel:add_system_message("Error: " .. tostring(e))
            return true
        end
        local ____try, ____hasReturned, ____returnValue = pcall(function()
            config.data[prop] = p.convert(value)
        end)
        if not ____try then
            ____hasReturned, ____returnValue = ____catch(____hasReturned)
        end
        if ____hasReturned then
            return ____returnValue
        end
    end
    ctx.channel:add_system_message(("Updated " .. prop) .. ".")
    config:save()
end
local function conv_str(s)
    return s
end
local function conv_bool(s)
    if s == "true" then
        return true
    end
    if s == "false" then
        return false
    end
    error(
        __TS__New(Error, ("Unable to convert: " .. s) .. " to boolean"),
        0
    )
end
props = {{name = "my_username", display = "Username", convert = conv_str}, {name = "rewrite_gift", display = "Rewrite $gift to $cookie", convert = conv_bool}, {name = "intercept_alias", display = "Intercept $alias command and reload aliases", convert = conv_bool}}
local config_subs = {
    show = {
        help = "Shows you the config",
        func = config_show,
        completions = function() return {} end
    },
    set = {
        help = "Sets a config value",
        func = config_set,
        completions = function(words)
            if #words == 0 then
                return {}
            end
            if #words == 1 then
                return __TS__ArrayMap(
                    props,
                    function(____, it) return it.name .. " " end
                )
            else
                local prop = __TS__ArrayFind(
                    props,
                    function(____, it) return string.lower(it.name) == words[1] end
                )
                if (prop and prop.convert) == conv_bool then
                    return {"true", "false"}
                end
                return {}
            end
        end
    }
}
local function command_config(ctx)
    table.remove(ctx.words, 1)
    if #ctx.words == 0 then
        ctx.channel:add_system_message("Available /sbc:config subcommands:")
        for ____, ____value in ipairs(__TS__ObjectEntries(config_subs)) do
            local k = ____value[1]
            local sub = ____value[2]
            ctx.channel:add_system_message((("  " .. k) .. " -- ") .. sub.help)
        end
        return
    end
    local sub = table.remove(ctx.words, 1)
    local cb = config_subs[sub]
    cb.func(
        ctx,
        {table.unpack(ctx.words)}
    )
end
function ____exports.init_config_edit()
    c2.register_command("/sbc:config", command_config)
end
function ____exports.sbcconfig_complete(ev)
    local words = __TS__StringSplit(ev.full_text_content, " ")
    if words[#words] == "" then
        table.remove(words)
    end
    if #words == 1 then
        return utils.new_completion_list()
    end
    if #words == 2 then
        local list = utils.new_completion_list()
        list.hide_others = true
        list.values = __TS__ArrayMap(
            __TS__ObjectKeys(config_subs),
            function(____, it) return it .. " " end
        )
        return utils.filter(list, ev.query)
    end
    table.remove(words, 1)
    local sub = table.remove(words, 1)
    local out = utils.new_completion_list()
    out.values = config_subs[sub].completions(words)
    if #out.values > 0 then
        out.hide_others = true
    end
    return utils.filter(out, ev.query)
end
return ____exports
