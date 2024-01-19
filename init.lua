local ____lualib = require("lualib_bundle")
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local __TS__StringEndsWith = ____lualib.__TS__StringEndsWith
local ____exports = {}
local ____utils = require("utils")
local utils = ____utils.default
local generated = require("completions_generated")
---
-- @param prefix Prefix to add to completions, usually "$" or "". Do not use spaces.
local function commands_and_their_aliases(prefix)
    local out = utils.new_completion_list()
    for ____, val in ipairs(generated.definitions) do
        if not utils.arr_contains_any(val.flags, generated.excluded_flags) then
            local ____opt_0 = val.aliases
            local lowerAlias = ____opt_0 and __TS__ArrayFilter(
                val.aliases,
                function(____, a) return string.lower(a) == string.lower(val.name) end
            )
            if lowerAlias ~= nil and #lowerAlias ~= nil and #lowerAlias > 0 then
                local ____out_values_2 = out.values
                ____out_values_2[#____out_values_2 + 1] = (prefix .. lowerAlias[1]) .. " "
            end
            local ____out_values_3 = out.values
            ____out_values_3[#____out_values_3 + 1] = (prefix .. val.name) .. " "
            if val.aliases ~= nil then
                for ____, v2 in ipairs(val.aliases) do
                    if not __TS__ArrayIncludes(out.values, v2) then
                        local ____out_values_4 = out.values
                        ____out_values_4[#____out_values_4 + 1] = (prefix .. v2) .. " "
                    end
                end
            end
        end
    end
    return out
end
local function lookup_command(name)
    c2.log(c2.LogLevel.Debug, "Looking up ", name)
    for ____, c in ipairs(generated.definitions) do
        if c.name == name then
            return c
        end
        local ____opt_2 = c.aliases
        if ____opt_2 and __TS__ArrayIncludes(c.aliases, name) then
            return c
        end
    end
    return nil
end
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
                        goto __continue33
                    end
                    local ____out_values_8 = out.values
                    ____out_values_8[#____out_values_8 + 1] = val.name .. " "
                    for ____, v2 in ipairs(val.aliases or ({})) do
                        local ____out_values_9 = out.values
                        ____out_values_9[#____out_values_9 + 1] = v2 .. " "
                    end
                end
                ::__continue33::
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
    if is_first_word then
        local out = commands_and_their_aliases("$")
        out.hide_others = true
        return out
    end
    if __TS__StringStartsWith(text, "$") and __TS__StringEndsWith(text, " ") and utils.count_occurences_of_byte(text, " ") == 1 then
        local out = commands_and_their_aliases("$")
        out.hide_others = true
        return out
    end
    if __TS__StringStartsWith(text, "$ ") and utils.count_occurences_of_byte(text, " ") == 1 then
        local out = commands_and_their_aliases("")
        out.hide_others = true
        return out
    end
    local _0, _1, command = string.find(text, "^[$] ?([^ ]+) ?")
    print(("Command is: \"" .. tostring(command)) .. "\"")
    local is_piped = false
    local cmd_data = lookup_command(command)
    if cmd_data ~= nil and cmd_data.name == "alias" and command == "$" then
        return utils.new_completion_list()
    end
    if command == "pipe" then
        is_piped = true
        print("pipe detected")
        local commandA = string.match(text, "[|] ?([^ ]+)[^|]+$")
        local commandB = string.match(text, "pipe *([^ ]+)[^|]+$")
        local m1 = string.match(text, "[|] ?[^ ]+$")
        local m2 = string.match(text, "pipe *[^ ]+$")
        if m1 ~= nil or m2 ~= nil then
            local out = commands_and_their_aliases("")
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
            return out
        end
    end
    if cmd_data ~= nil and cmd_data.params ~= nil and #cmd_data.params ~= 0 then
        local out = utils.new_completion_list()
        print("DANKING!")
        for ____, val in ipairs(cmd_data.params) do
            local ____out_values_10 = out.values
            ____out_values_10[#____out_values_10 + 1] = val.name .. ":"
        end
        return out
    end
    if command == "help" then
        local completions = commands_and_their_aliases("")
        completions.hide_others = true
        return completions
    end
    return utils.new_completion_list()
end
local function filter(self, inp, filter)
    local out = utils.new_completion_list()
    out.hide_others = inp.hide_others
    filter = string.lower(filter)
    for ____, c in ipairs(inp.values) do
        if __TS__StringStartsWith(
            string.lower(c),
            filter
        ) then
            local ____out_values_11 = out.values
            ____out_values_11[#____out_values_11 + 1] = c
        end
    end
    return out
end
c2.register_callback(
    c2.EventType.CompletionRequested,
    function(text, full_text, position, is_first_word)
        c2.log(
            c2.LogLevel.Debug,
            "doing completions: ",
            text,
            full_text,
            position,
            is_first_word
        )
        return filter(
            nil,
            find_useful_completions(full_text, text, position, is_first_word),
            text
        )
    end
)
c2.system_msg("supinic", "[Completion loaded]")
if utils.has_load() then
    local function cmd_eval(ctx)
        table.remove(ctx.words, 1)
        local input = table.concat(ctx.words, " ")
        local source = "return " .. input
        c2.system_msg(ctx.channel_name, ">>>" .. input)
        local f
        local err
        f, err = load(source)
        if f == nil then
            c2.system_msg(
                ctx.channel_name,
                "!<" .. tostring(err)
            )
        else
            c2.system_msg(
                ctx.channel_name,
                "<< " .. tostring(f(nil))
            )
        end
    end
    c2.register_command("/sbc:eval", cmd_eval)
end
return ____exports
