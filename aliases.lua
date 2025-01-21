local ____lualib = require("lualib_bundle")
local __TS__Spread = ____lualib.__TS__Spread
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local ____exports = {}
local config, aliases
local ____json = require("json")
local decode = ____json.decode
local ____data = require("data")
local data = ____data.default
local ____utils = require("utils")
local utils = ____utils.default
local ____async = require("async")
local asyncwrap = ____async.asyncwrap
local plawait = ____async.plawait
function ____exports.aload_aliases(ok_cb, err_cb)
    if not ____exports.should_load_aliases() then
        c2.log(c2.LogLevel.Info, "Ignoring loading aliases, no username given.")
        return
    end
    local url = ("https://supinic.com/api/bot/user/" .. utils.encode_uri_component(config.my_username)) .. "/alias/list"
    print("Begin downloading aliases from " .. url)
    local req = c2.HTTPRequest.create(c2.HTTPMethod.Get, url)
    req:set_header("User-Agent", utils.HTTP_USER_AGENT)
    req:on_success(function(res)
        local ok, json = pcall(
            decode,
            res:data()
        )
        if not ok then
            local ____opt_1 = c2.Channel.by_name("supinic")
            if ____opt_1 ~= nil then
                ____opt_1:add_system_message("Failed to load aliases: API returned invalid JSON")
            end
            c2.log(
                c2.LogLevel.Critical,
                ("FAILED TO LOAD ALIASES: RECEIVED " .. tostring(res:status())) .. " BUT COULD NOT PARSE JSON."
            )
            c2.log(
                c2.LogLevel.Critical,
                "Data: " .. res:data()
            )
            if err_cb then
                err_cb("JSON parse failure")
            end
            return
        end
        aliases = __TS__ArrayMap(
            {__TS__Spread(json.data)},
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
        local ____opt_3 = c2.Channel.by_name("supinic")
        if ____opt_3 ~= nil then
            ____opt_3:add_system_message(("Loaded " .. tostring(aliases and #aliases)) .. " supibot user aliases.")
        end
        if ok_cb then
            ok_cb()
        else
            print("OK Callback missing for load aliases")
        end
    end)
    req:on_error(function(res)
        c2.log(
            c2.LogLevel.Warning,
            "Failed to load aliases for user \"",
            config.my_username,
            "\" (HTTP ",
            res:status(),
            " ): ",
            res:error()
        )
        local ____opt_7 = c2.Channel.by_name("supinic")
        if ____opt_7 ~= nil then
            ____opt_7:add_system_message("Failed to load aliases: " .. res:error())
        end
        if err_cb then
            err_cb((("HTTP error: " .. res:error()) .. ": ") .. tostring(res:status()))
        else
            print("no err callback")
        end
    end)
    req:finally(function()
        print("Finish loading aliases")
    end)
    req:execute()
end
function ____exports.should_load_aliases()
    return config.my_username ~= ""
end
local ____data_0 = data
config = ____data_0.config
function ____exports.load_aliases()
    return ____exports.aload_aliases(nil, nil)
end
aliases = nil
function ____exports.get_aliases()
    return aliases
end
local function alias_interceptor(ctx)
    ctx.channel:send_message(
        table.concat(ctx.words, " "),
        false
    )
    if not aliases or not config.intercept_alias then
        return
    end
    table.remove(ctx.words, 1)
    local subcommand = table.remove(ctx.words, 1)
    if not subcommand then
        c2.log(c2.LogLevel.Warning, "Failed to parse $alias command, missing subcommand")
        return
    end
    local ADD_SUBCOMMANDS = {"create", "add", "upsert", "addedit"}
    if __TS__ArrayIncludes(ADD_SUBCOMMANDS, subcommand) then
        local name = table.remove(ctx.words, 1)
        if not name then
            c2.log(c2.LogLevel.Warning, "Failed to parse $alias add command, missing name")
            return
        end
        local existing = __TS__ArrayFind(
            aliases,
            function(____, it) return it.name == name end
        )
        if existing == nil then
            aliases[#aliases + 1] = {
                name = name,
                created = "1970-01-01T00:00:00Z",
                edited = nil,
                link_author = nil,
                link_name = nil,
                invocation = table.remove(ctx.words, 1) or "<unknown>"
            }
        end
        return
    end
    local DELETE_SUBCOMMANDS = {"delete", "remove"}
    if __TS__ArrayIncludes(DELETE_SUBCOMMANDS, subcommand) then
        local name = table.remove(ctx.words, 1)
        if not name then
            c2.log(c2.LogLevel.Warning, "Failed to parse $alias delete command, missing name")
            return
        end
        local existing = __TS__ArrayFind(
            aliases,
            function(____, it) return it.name == name end
        )
        if existing then
            __TS__ArraySplice(
                aliases,
                __TS__ArrayIndexOf(aliases, existing),
                1
            )
        end
    end
    local COPYLINK_SUBCOMMANDS = {"copy", "copyplace", "link", "linkplace"}
    if __TS__ArrayIncludes(COPYLINK_SUBCOMMANDS, subcommand) then
        local source_user = table.remove(ctx.words, 1)
        if not source_user then
            c2.log(c2.LogLevel.Warning, "Failed to parse $alias copy/link command, missing user")
            return
        end
        local source_name = table.remove(ctx.words, 1)
        if not source_name then
            c2.log(c2.LogLevel.Warning, "Failed to parse $alias copy/link command, missing alias name")
            return
        end
        local custom_name = table.remove(ctx.words, 1)
        local name = custom_name or source_name
        local existing = __TS__ArrayFind(
            aliases,
            function(____, it) return it.name == name end
        )
        if existing then
            existing.link_author = source_user
            existing.link_name = source_name
        else
            aliases[#aliases + 1] = {
                name = name,
                created = "1970-01-01T00:00:00Z",
                edited = nil,
                link_author = source_user,
                link_name = source_name,
                invocation = "<unknown>"
            }
        end
    end
    if subcommand == "duplicate" then
        local nameold = table.remove(ctx.words, 1)
        if not nameold then
            c2.log(c2.LogLevel.Warning, "Failed to parse $alias duplicate command, missing old name")
            return
        end
        local namenew = table.remove(ctx.words, 1)
        if not namenew then
            c2.log(c2.LogLevel.Warning, "Failed to parse $alias duplicate command, missing new name")
            return
        end
        local existing = __TS__ArrayFind(
            aliases,
            function(____, it) return it.name == nameold end
        )
        if not existing then
            return
        end
        aliases[#aliases + 1] = __TS__ObjectAssign({}, existing, {name = namenew})
    end
end
local function aliasreload(ctx)
    if not ____exports.should_load_aliases() then
        ctx.channel:add_system_message("Configure '/sbc:config set my_username <name>' first.")
        return
    end
    ctx.channel:add_system_message("Reloading aliases")
    local ok, res = plawait(____exports.aload_aliases)
    if ok then
        ctx.channel:add_system_message("Done reloading aliases")
    else
        ctx.channel:add_system_message("Failed to reload: " .. tostring(res))
    end
end
c2.register_command(
    "/sbc:aliasreload",
    asyncwrap(aliasreload)
)
if config.intercept_alias then
    c2.register_command("$alias", alias_interceptor)
end
return ____exports
