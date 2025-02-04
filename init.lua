local ____lualib = require("lualib_bundle")
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local __TS__StringEndsWith = ____lualib.__TS__StringEndsWith
local ____exports = {}
local ____utils = require("utils")
local utils = ____utils.default
local ____percommand = require("percommand")
local commands = ____percommand.default
local ____data = require("data")
local storage = ____data.default
local ____aliases = require("aliases")
local load_aliases = ____aliases.load_aliases
local get_aliases = ____aliases.get_aliases
local ____configedit = require("configedit")
local init_config_edit = ____configedit.init_config_edit
local sbcconfig_complete = ____configedit.sbcconfig_complete
local ____storage_0 = storage
local config = ____storage_0.config
--- Look up a command by name from the generated definitions
local function lookup_command(name)
    c2.log(c2.LogLevel.Debug, "Looking up ", name)
    for ____, c in ipairs(storage.definitions) do
        if c.name == name then
            return c
        end
        local ____opt_1 = c.aliases
        if ____opt_1 and __TS__ArrayIncludes(c.aliases, name) then
            return c
        end
    end
    return nil
end
--- Look up a subcommand of a given command by name
local function lookup_subcommand(name, cmdData)
    if cmdData.subcommands == nil then
        return nil
    end
    for ____, c in ipairs(cmdData.subcommands) do
        if c.name == name then
            return c
        end
        if c.aliases ~= nil then
            for ____, alias in ipairs(c.aliases) do
                if alias == name then
                    return c
                end
            end
        end
    end
    return nil
end
local function users_aliases(prefix)
    local out = utils.new_completion_list()
    local aliases = get_aliases()
    if aliases == nil or #aliases == 0 then
        return out
    end
    out.hide_others = true
    for ____, alias in ipairs(aliases) do
        local ____out_values_3 = out.values
        ____out_values_3[#____out_values_3 + 1] = prefix .. alias.name
    end
    return out
end
local function try_subcommand_completions(text, sub_data, subcommand, tree, is_piped)
    while (sub_data and sub_data.subcommands) ~= nil and (sub_data and sub_data.subcommands) ~= nil do
        print(((("Iterating subcommand loop: at " .. table.concat(tree, "->")) .. " (") .. tostring(#sub_data.subcommands)) .. " subs)")
        local WORD = " [^ ]+"
        local pat_end = (subcommand .. string.rep(WORD, sub_data.eat_before_sub_command + 1)) .. "$"
        print(((((("Created pattern: \"" .. pat_end) .. "\" for ") .. subcommand) .. ", text is \"") .. text) .. "\"")
        local temp = string.match(text, pat_end)
        if temp ~= nil then
            print(((("matched subcmd \"" .. temp) .. "\" from \"") .. pat_end) .. "\"")
            local out = utils.new_completion_list()
            out.hide_others = true
            for ____, val in ipairs(sub_data.subcommands) do
                do
                    if is_piped and not val.pipe then
                        goto __continue23
                    end
                    local ____out_values_4 = out.values
                    ____out_values_4[#____out_values_4 + 1] = val.name .. " "
                    for ____, v2 in ipairs(val.aliases or ({})) do
                        local ____out_values_5 = out.values
                        ____out_values_5[#____out_values_5 + 1] = v2 .. " "
                    end
                end
                ::__continue23::
            end
            return out
        end
        local pat_more = (subcommand .. string.rep(WORD, sub_data.eat_before_sub_command)) .. " ([^ ]+)"
        subcommand = string.match(text, pat_more)
        sub_data = lookup_subcommand(subcommand, sub_data)
        if sub_data == nil then
            print(((("No more sub commands at " .. table.concat(tree, "->")) .. " with pattern \"") .. pat_more) .. "\"")
            break
        end
        print(((("Have more sub commands at " .. table.concat(tree, "->")) .. " -> \"") .. subcommand) .. "\"")
        tree[#tree + 1] = subcommand
    end
    return nil
end
local function find_useful_completions(text, prefix, cursor_position, is_first_word)
    if not __TS__StringStartsWith(text, "$") then
        return utils.new_completion_list()
    end
    if is_first_word and __TS__StringStartsWith(text, "$$") then
        return users_aliases("$$")
    end
    if is_first_word then
        local out = utils.commands_and_their_aliases("$")
        out.hide_others = true
        return out
    end
    if __TS__StringStartsWith(text, "$") and __TS__StringEndsWith(text, " ") and utils.count_occurences_of_byte(text, " ") == 1 then
        local out = utils.commands_and_their_aliases("$")
        out.hide_others = true
        return out
    end
    if __TS__StringStartsWith(text, "$ ") and utils.count_occurences_of_byte(text, " ") == 1 then
        local out = utils.commands_and_their_aliases("")
        out.hide_others = true
        return out
    end
    local _0, _1, command = string.find(text, "^[$] ?([^ ]+) ?")
    local is_piped = false
    local cmd_data = lookup_command(command)
    print(("Command is: \"" .. tostring(command)) .. "\"")
    if cmd_data ~= nil and cmd_data.name == "alias" and command == "$" then
        return users_aliases("")
    end
    if command == "pipe" then
        is_piped = true
        print("pipe detected")
        local commandA = string.match(text, "[|] ?([^ ]+)[^|]+$")
        local commandB = string.match(text, "pipe *([^ ]+)[^|]+$")
        local m1 = string.match(text, "[|] ?[^ ]+$")
        local m2 = string.match(text, "pipe *[^ ]+$")
        if m1 ~= nil or m2 ~= nil then
            local out = utils.commands_and_their_aliases("")
            out.hide_others = true
            return out
        end
        if commandA ~= nil then
            command = commandA
        end
        if commandB ~= nil then
            command = commandB
        end
        cmd_data = lookup_command(command)
    end
    local sub_command_tree = {command}
    local maybe_comps = try_subcommand_completions(
        text,
        cmd_data,
        command,
        sub_command_tree,
        is_piped
    )
    if maybe_comps ~= nil then
        return maybe_comps
    end
    print("Tree is " .. table.concat(sub_command_tree, "->"))
    if sub_command_tree[1] == "alias" then
        local spaces = utils.count_occurences_of_byte(text, " ")
        if spaces == 2 then
            local sub = sub_command_tree[2]
            local existing_only = sub == "describe" or sub == "delete" or sub == "rename" or sub == "unrestrict" or sub == "run" or sub == "edit"
            local out = users_aliases("")
            out.hide_others = existing_only
            print("Triggered special case for alias completion")
            return out
        end
    end
    if (cmd_data and cmd_data.name) == "ban" then
        return commands.ban(cmd_data, command, text, prefix)
    end
    if (cmd_data and cmd_data.name) == "block" then
        return commands.block(cmd_data, text, prefix)
    end
    if (cmd_data and cmd_data.name) == "unping" then
        return commands.unping(cmd_data, text, prefix)
    end
    if (cmd_data and cmd_data.name) == "optout" then
        return commands.optout(cmd_data, text, prefix, cursor_position)
    end
    if (cmd_data and cmd_data.name) == "unmention" then
        return commands.unmention(cmd_data, text, prefix)
    end
    if (cmd_data and cmd_data.name) == "osrs" then
        return commands.osrs(cmd_data, text, prefix)
    end
    if cmd_data ~= nil and cmd_data.params ~= nil and #cmd_data.params ~= 0 then
        local out = utils.new_completion_list()
        print("DANKING!")
        for ____, val in ipairs(cmd_data.params) do
            if val.type == "boolean" then
                local ____out_values_22 = out.values
                ____out_values_22[#____out_values_22 + 1] = val.name .. ":true"
                local ____out_values_23 = out.values
                ____out_values_23[#____out_values_23 + 1] = val.name .. ":false"
            else
                local ____out_values_24 = out.values
                ____out_values_24[#____out_values_24 + 1] = val.name .. ":"
            end
        end
        return out
    end
    if command == "help" or command == "code" or (cmd_data and cmd_data.name) == "optout" then
        local completions = utils.commands_and_their_aliases("")
        completions.hide_others = true
        return completions
    end
    return utils.new_completion_list()
end
c2.register_callback(
    c2.EventType.CompletionRequested,
    function(ev)
        if __TS__StringStartsWith(ev.full_text_content, "/sbc:config") then
            return sbcconfig_complete(ev)
        end
        c2.log(
            c2.LogLevel.Debug,
            "doing completions: ",
            ev.query,
            ev.full_text_content,
            ev.cursor_position,
            ev.is_first_word
        )
        return utils.filter(
            find_useful_completions(ev.full_text_content, ev.query, ev.cursor_position, ev.is_first_word),
            ev.query
        )
    end
)
if utils.has_load() then
    local function cmd_eval(ctx)
        table.remove(ctx.words, 1)
        local input = table.concat(ctx.words, " ")
        local source = "return " .. input
        ctx.channel:add_system_message(">>>" .. input)
        local f
        local err
        f, err = load(source)
        if f == nil then
            ctx.channel:add_system_message("!<" .. tostring(err))
        else
            ctx.channel:add_system_message("<< " .. tostring(f()))
        end
    end
    c2.register_command("/sbc:eval", cmd_eval)
end
if config.rewrite_gift then
    local function cmd_fake_gift(ctx)
        local invocation = table.remove(ctx.words, 1)
        local usage = ("This is Supibot-completion-plugin fake $gift/$give. Usage: " .. tostring(invocation)) .. " cookie <name>"
        if #ctx.words == 0 then
            ctx.channel:add_system_message(usage)
            return
        end
        local ____type = table.remove(ctx.words, 1)
        if ____type ~= "cookie" then
            ctx.channel:add_system_message(usage .. (". Unknown type \"" .. tostring(____type)) .. "\".")
            return
        end
        local target = table.remove(ctx.words, 1)
        if target == nil then
            ctx.channel:add_system_message(usage .. ". Missing username.")
            return
        end
        ctx.channel:send_message(
            "$cookie gift " .. tostring(target),
            false
        )
    end
    c2.register_command("$gift", cmd_fake_gift)
    c2.register_command("$give", cmd_fake_gift)
end
init_config_edit()
local ____opt_27 = c2.Channel.by_name("supinic")
if ____opt_27 ~= nil then
    ____opt_27:add_system_message(("[Supibot completion " .. tostring(storage.git.version)) .. " loaded]")
end
load_aliases()
return ____exports
