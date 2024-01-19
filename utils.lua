local ____lualib = require("lualib_bundle")
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local ____exports = {}
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
end
____exports.default = utils
return ____exports
