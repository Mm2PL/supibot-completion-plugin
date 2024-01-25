local ____lualib = require("lualib_bundle")
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__ArrayEvery = ____lualib.__TS__ArrayEvery
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local ____exports = {}
local generated = require("completions_generated")
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
    utils.REQUIRE_LEGACY_GIVE_CFG = "REQUIRE_LEGACY_GIVE_CFG"
    local function get_excluded_flags()
        if generated.config.rewrite_gift then
            return generated.excluded_flags
        end
        local temp = {table.unpack(generated.excluded_flags)}
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
        for ____, val in ipairs(generated.definitions) do
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
end
____exports.default = utils
return ____exports
