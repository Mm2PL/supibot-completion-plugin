local ____lualib = require("lualib_bundle")
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local __TS__StringAccess = ____lualib.__TS__StringAccess
local __TS__StringSlice = ____lualib.__TS__StringSlice
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__Spread = ____lualib.__TS__Spread
local __TS__ArrayEvery = ____lualib.__TS__ArrayEvery
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local ____exports = {}
local ____data = require("data")
local storage = ____data.default
local utils = {}
do
    function utils.arr_contains_any(left, right)
        for ____, e in ipairs(right) do
            if __TS__ArrayIncludes(left, e) then
                return true
            end
        end
        return false
    end
    function utils.count_occurences_of_byte(str, b)
        local byte = string.byte(b)
        local count = 0
        do
            local i = 1
            while i <= #str do
                local sb = string.byte(str, i)
                if sb == byte then
                    count = count + 1
                end
                i = i + 1
            end
        end
        return count
    end
    function utils.new_completion_list()
        return {hide_others = false, values = {}}
    end
    function utils.has_load()
        do
            local function ____catch(e)
                return true, false
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                load("")
                return true, true
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
    end
    function utils.parse_params(text, expected_names)
        local quoted = false
        local lastspace = 0
        local currentname = nil
        local value_begin = nil
        local last_param_end = 0
        local non_param_args = {}
        local out = __TS__New(Map)
        do
            local i = 0
            while i < #text do
                local char = __TS__StringAccess(text, i)
                if char == " " then
                    lastspace = i
                    if not quoted and currentname ~= nil then
                        out:set(
                            currentname,
                            __TS__StringSlice(text, value_begin or 0, i)
                        )
                        currentname = nil
                        last_param_end = i
                    end
                elseif char == ":" and not quoted then
                    local name = __TS__StringSlice(text, lastspace + 1, i)
                    if __TS__ArrayIncludes(expected_names, name) then
                        non_param_args[#non_param_args + 1] = __TS__StringSlice(text, last_param_end, i)
                        currentname = name
                        value_begin = i + 1
                    end
                elseif char == "\"" then
                    quoted = not quoted
                end
                i = i + 1
            end
        end
        if quoted then
            error(
                __TS__New(Error, "Unclosed quote"),
                0
            )
        end
        if currentname ~= nil then
            out:set(
                currentname,
                __TS__StringSlice(text, value_begin or 0, #text)
            )
        end
        non_param_args[#non_param_args + 1] = __TS__StringSlice(text, last_param_end, #text)
        return {
            params = out,
            argv = __TS__StringSplit(
                table.concat(non_param_args, " "),
                " "
            )
        }
    end
    utils.REQUIRE_LEGACY_GIVE_CFG = "REQUIRE_LEGACY_GIVE_CFG"
    local function get_excluded_flags()
        if storage.config.rewrite_gift then
            return storage.excluded_flags
        end
        local temp = {__TS__Spread(storage.excluded_flags)}
        temp[#temp + 1] = utils.REQUIRE_LEGACY_GIVE_CFG
        return temp
    end
    ---
    -- @param prefix Prefix to add to completions, usually "$" or "". Do not use spaces.
    function utils.commands_and_their_aliases(prefix, required_flags)
        if required_flags == nil then
            required_flags = {}
        end
        local out = utils.new_completion_list()
        local excl_flags = get_excluded_flags()
        for ____, val in ipairs(storage.definitions) do
            do
                if #required_flags ~= 0 and not __TS__ArrayEvery(
                    required_flags,
                    function(____, it) return __TS__ArrayIncludes(val.flags, it) end
                ) then
                    goto __continue26
                end
                if not utils.arr_contains_any(val.flags, excl_flags) then
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
            ::__continue26::
        end
        return out
    end
    function utils.filter(inp, filter)
        local out = utils.new_completion_list()
        out.hide_others = inp.hide_others
        filter = string.lower(filter)
        for ____, c in ipairs(inp.values) do
            if __TS__StringStartsWith(
                string.lower(c),
                filter
            ) then
                local ____out_values_5 = out.values
                ____out_values_5[#____out_values_5 + 1] = c
            end
        end
        return out
    end
end
____exports.default = utils
return ____exports
