local ____lualib = import("lualib_bundle.lua")
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local __TS__StringEndsWith = ____lualib.__TS__StringEndsWith
local ____exports = {}
local ____inspect = import("inspect.lua")
local inspect = ____inspect.inspect
local ____utils = import("utils.lua")
local utils = ____utils.default
local generated = import("completions_generated.lua")
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
local function commands_and_their_aliases(_prefix, _out)
    local prefix = _prefix == nil and "$" or _prefix
    local out = _out == nil and utils.new_completion_list() or _out
    for ____, val in ipairs(generated.definitions) do
        if not utils.arr_contains_any(val.flags, generated.excluded_flags) then
            local ____out_values_0 = out.values
            ____out_values_0[#____out_values_0 + 1] = (prefix .. val.name) .. " "
            if val.aliases ~= nil then
                for ____, v2 in ipairs(val.aliases) do
                    local ____out_values_1 = out.values
                    ____out_values_1[#____out_values_1 + 1] = (prefix .. v2) .. " "
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
local function find_useful_completions(text, prefix, is_first_word)
    if not __TS__StringStartsWith(text, "$") then
        return utils.new_completion_list()
    end
    print(
        "text is: ",
        inspect(text)
    )
    print(
        "prefix is: ",
        inspect(prefix)
    )
    if is_first_word then
        local out = commands_and_their_aliases(nil, nil)
        out.hide_others = true
        return out
    end
    if __TS__StringStartsWith(text, "$") and __TS__StringEndsWith(text, " ") and utils.count_occurences_of_byte(text, " ") == 1 then
        local out = commands_and_their_aliases(nil, nil)
        out.hide_others = true
        return out
    end
    if __TS__StringStartsWith(text, "$ ") and utils.count_occurences_of_byte(text, " ") == 1 then
        local out = commands_and_their_aliases("", nil)
        out.hide_others = true
        return out
    end
    local _0, _1, command = string.find(text, "^[$] ?([^ ]+) ?")
    print("Command is: ", command)
    local is_piped = false
    local cmd_data = lookup_command(command)
    if command == "pipe" then
        is_piped = true
        print("pipe detected")
        local commandA = string.match(text, "[|] ?([^ ]+)[^|]+$")
        local commandB = string.match(text, "pipe *([^ ]+)[^|]+$")
        local m1 = string.match(text, "[|] ?[^ ]+$")
        local m2 = string.match(text, "pipe *[^ ]+$")
        if m1 ~= nil or m2 ~= nil then
            local out = commands_and_their_aliases("", nil)
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
    while (cmd_data and cmd_data.subcommands) ~= nil and (cmd_data and cmd_data.subcommands) ~= nil do
        print(
            cmd_data,
            " has subcommands: ",
            inspect(cmd_data.subcommands)
        )
        local WORD = " [^ ]+"
        local temp = string.match(
            text,
            (tostring(command) .. string.rep(WORD, cmd_data.eat_before_sub_command)) .. "$"
        )
        if temp ~= nil then
            print("matched subcmd")
            local out = utils.new_completion_list()
            out.hide_others = true
            for ____, val in ipairs(cmd_data.subcommands) do
                if not (val.pipe and is_piped) then
                    local ____out_values_4 = out.values
                    ____out_values_4[#____out_values_4 + 1] = val.name .. " "
                    for ____, v2 in ipairs(val.aliases or ({})) do
                        local ____out_values_5 = out.values
                        ____out_values_5[#____out_values_5 + 1] = v2 .. " "
                    end
                end
            end
            return out
        end
        command = string.match(
            text,
            (tostring(command) .. string.rep(WORD, cmd_data.eat_before_sub_command)) .. " ([^ ]+)"
        )
        cmd_data = lookup_subcommand(command, cmd_data)
        if cmd_data == nil then
            break
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
        return commands_and_their_aliases("", nil)
    end
    return utils.new_completion_list()
end
local function filter(self, inp, filter)
    local out = utils.new_completion_list()
    out.hide_others = inp.hide_others
    for ____, c in ipairs(inp.values) do
        if __TS__StringStartsWith(c, filter) then
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
            find_useful_completions(full_text, text, is_first_word),
            text
        )
    end
)
c2.register_command("/sbc:eval", cmd_eval)
c2.system_msg("supinic", "[Completion loaded]")
return ____exports
