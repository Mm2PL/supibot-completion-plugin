function startswith(str, start)
   return str:sub(1, #start) == start
end

function endswith(str, fin)
   return str:sub(-#fin) == fin
end

function table_contains(tab, elem)
    for i, v in ipairs(tab) do
        if v == elem then
            return true
        end
    end
    return false
end

function table_contains_any(tab, elems)
    for i, v in ipairs(tab) do
        for _, elem in ipairs(elems) do
            if table_contains(tab, elem) then return true end
        end
    end
    return false
end


function countOccurencesOfByte(str, b)
    local byte = b:byte()
    local count = 0
    for i = 1, #str do
        local sb = str:byte(i)
        if sb == byte then
            count = count + 1
        end
    end
    return count
end


inspect = import("inspect.lua")

generated = import("completions_generated.lua")

function cmdEval(ctx)
    table.remove(ctx.words, 1)
    local input = table.concat(ctx.words, " ")
    local source = "return " .. input
    c2.system_msg(ctx.channel_name, ">>>" .. input)
    local f, err = load(source)
    if f == nil then
        c2.system_msg(ctx.channel_name "!<" .. tostring(err))
    else
        c2.system_msg(ctx.channel_name, "<< " .. tostring(f()))
    end
end


c2.register_command("/sbc:eval", cmdEval)

function commandsAndTheirAliases(prefix, out)
    local prefix = prefix or "$"
    local out = out or {}
    for _, val in ipairs(generated.definitions) do
        if not table_contains_any(val.flags, generated.excluded_flags) then
            out[#out+1] = {prefix .. val.name .. " ", c2.CompletionType.CustomCompletion}
            for _, v2 in ipairs(val.aliases) do
                out[#out+1] = {prefix .. v2 .. " ", c2.CompletionType.CustomCompletion}
            end
        end
    end

    return out
end

function lookup_command(name)
    print("looking up ".. (name or "<nil>!!!"))
    for _, c in ipairs(generated.definitions) do
        if c.name == name then
            return c
        end
        for _, alias in ipairs(c.aliases) do
            if alias == name then
                return c
            end
        end
    end
end

function lookup_subcommand(name, cmdData)
    print("looking up ".. (name or "<nil>!!!") .. " in " .. (cmdData.name or "<nil>!!!"))
    for _, c in ipairs(cmdData.subcommands) do
        if c.name == name then
            return c
        end
        for _, alias in ipairs(c.aliases) do
            if alias == name then
                return c
            end
        end
    end
end

function onCompletionsRequested(text, prefix, isFirstWord)
    local ret = actualOnCompletionsRequested(text, prefix, isFirstWord)
    print("completions: " .. inspect(ret))
    return ret
end

function actualOnCompletionsRequested(text, prefix, isFirstWord)
    if not startswith(text, "$") then
        return {}
    end
    print("text is \"" .. text .. "\"")
    print("prefix is \"" .. prefix .. "\"")
    -- case for "$COMMAND"
    if isFirstWord then
        -- check for prefix
        local out = commandsAndTheirAliases()
        out.done = true
        return out
    end

    -- case for "$COMMAND "
    if startswith(text, "$") and endswith(text, " ") and countOccurencesOfByte(text, " ") == 1 then
        local out = commandsAndTheirAliases()
        out.done = true
        return out
    end

    -- case for "$ COMMAND"
    if startswith(text, "$ ") and countOccurencesOfByte(text, " ") == 1 then
        local out = commandsAndTheirAliases("")
        out.done = true
        return out
    end

    local _, _, command = text:find("^[$] ?([^ ]+) ?")
    print(command)
    local is_piped = false
    local cmdData = lookup_command(command)
    -- case for meta commands
    if command == "pipe" then
        is_piped = true

        print("pipe detected")
        -- check for "|"
        -- TODO: account for pipe _char param
        local commandA = text:match("[|] ?([^ ]+)[^|]+$")
        local commandB = text:match("pipe *([^ ]+)[^|]+$")
        if text:match("[|] ?[^ ]+$") or text:match("pipe *[^ ]+$") then
            local out = commandsAndTheirAliases("")
            out.done = true
            return out
        end
        command = commandA or commandB
        cmdData = lookup_command(command)
    --elseif command == "alias" then
    --    print("alias detected")
    end

    while cmdData.subcommands do
        print(cmdData.name  .. " has subcommands: " .. inspect(cmdData.subcommands))
        -- check for if first word after command
        local WORD = " [^ ]+"
        --print("fdmfdm " .. inspect.inspect(cmdData))
        if text:match(command .. WORD:rep(cmdData.eat_before_sub_command + 1) .. "$") then
            print("matched subcommand query")
            local out = {}
            for _, val in ipairs(cmdData.subcommands) do
                if not (not val.pipe and is_piped) then
                    out[#out+1] = {val.name .. " ", c2.CompletionType.CustomCompletion}
                    for _, v2 in ipairs(val.aliases) do
                        out[#out+1] = {v2 .. " ", c2.CompletionType.CustomCompletion}
                    end
                end
            end
            out.done = true

            return out
        end
        --print("fdmfdm " .. inspect.inspect(cmdData))
        command = text:match(command .. WORD:rep(cmdData.eat_before_sub_command) .. " ([^ ]+)")
        cmdData = lookup_subcommand(command, cmdData)
        if cmdData == nil then
            break
        end
    end

    if cmdData and cmdData.params and #cmdData.params ~= 0 then
        local out = {}
        --out[#out+1] = {"from:", c2.CompletionType.CustomCompletion}
        --return out
        print("DANKING")
        for _, val in ipairs(cmdData.params) do
            out[#out+1] = {val.name .. ":", c2.CompletionType.CustomCompletion}
        end

        return out
    end

    -- special cases
    if command == "help" then
        return commandsAndTheirAliases("")
    end

    --print("not xd")
    return {}
end
print("WIP Supibot contextual completion loaded!")
c2.system_msg("supinic", "[Completion loaded]")
