local ____lualib = require("lualib_bundle")
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ObjectEntries = ____lualib.__TS__ObjectEntries
local __TS__ArrayUnshift = ____lualib.__TS__ArrayUnshift
local __TS__StringSubstring = ____lualib.__TS__StringSubstring
local __TS__StringTrim = ____lualib.__TS__StringTrim
local __TS__ArrayPushArray = ____lualib.__TS__ArrayPushArray
local ____exports = {}
local ____utils = require("utils")
local utils = ____utils.default
local BanType = BanType or ({})
BanType.OFFLINE_ONLY = "offline-only"
BanType.ONLINE_ONLY = "online-only"
BanType.ARGUMENTS = "arguments"
BanType.COOLDOWN = "cooldown"
BanType.BLACKLIST = "blacklist"
BanType.REMINDER_PREVENTION = "reminder-prevention"
local commands = {}
do
    --- COMMON = [user:] [command:] [invocation:]
    -- $ban [type:blacklist] $COMMON
    -- $ban type:reminder-prevention [user:] [channel:]
    -- $ban type:cooldown [multiplier:] $COMMON
    -- $ban type:arguments [all:(true|false)] [index:] [string:]
    -- $unban type:arguments [clear:(true|false)] [all:(true|false)] [index:] [string:]
    function commands.ban(cmd, invocation, text, prefix)
        local out = utils.new_completion_list()
        if __TS__StringStartsWith(prefix, "command:") then
            return utils.commands_and_their_aliases("command:")
        end
        if __TS__StringStartsWith(prefix, "invocation:") then
            return utils.commands_and_their_aliases("invocation:")
        end
        local ____utils_parse_params_3 = utils.parse_params
        local ____text_2 = text
        local ____opt_0 = cmd.params
        local parsed = ____utils_parse_params_3(
            ____text_2,
            ____opt_0 and __TS__ArrayMap(
                cmd.params,
                function(____, it) return it.name end
            ) or ({})
        )
        local typ = parsed.params:get("type")
        local invalid_type = true
        for ____, ____value in ipairs(__TS__ObjectEntries(BanType)) do
            local k = ____value[1]
            local v = ____value[2]
            if v == typ then
                invalid_type = false
            end
        end
        if typ == nil or invalid_type then
            local ____out_values_4 = out.values
            ____out_values_4[#____out_values_4 + 1] = "type:" .. BanType.ARGUMENTS
            local ____out_values_5 = out.values
            ____out_values_5[#____out_values_5 + 1] = "type:" .. BanType.BLACKLIST
            local ____out_values_6 = out.values
            ____out_values_6[#____out_values_6 + 1] = "type:" .. BanType.COOLDOWN
            local ____out_values_7 = out.values
            ____out_values_7[#____out_values_7 + 1] = "type:" .. BanType.OFFLINE_ONLY
            local ____out_values_8 = out.values
            ____out_values_8[#____out_values_8 + 1] = "type:" .. BanType.ONLINE_ONLY
            local ____out_values_9 = out.values
            ____out_values_9[#____out_values_9 + 1] = "type:" .. BanType.REMINDER_PREVENTION
            typ = "blacklist"
        end
        if typ == BanType.REMINDER_PREVENTION then
            local ____out_values_10 = out.values
            ____out_values_10[#____out_values_10 + 1] = "user:"
            local ____out_values_11 = out.values
            ____out_values_11[#____out_values_11 + 1] = "channel:"
            out.hide_others = false
            return out
        end
        if typ == BanType.COOLDOWN then
            local ____out_values_12 = out.values
            ____out_values_12[#____out_values_12 + 1] = "multiplier:"
            local ____out_values_13 = out.values
            ____out_values_13[#____out_values_13 + 1] = "multiplier:1.5"
            local ____out_values_14 = out.values
            ____out_values_14[#____out_values_14 + 1] = "multiplier:2"
        end
        if typ == BanType.ARGUMENTS then
            local ____out_values_15 = out.values
            ____out_values_15[#____out_values_15 + 1] = "all:true"
            local ____out_values_16 = out.values
            ____out_values_16[#____out_values_16 + 1] = "index:"
            local ____out_values_17 = out.values
            ____out_values_17[#____out_values_17 + 1] = "string:"
            if invocation == "unban" then
                local ____out_values_18 = out.values
                ____out_values_18[#____out_values_18 + 1] = "clear:true"
            end
        end
        local ____out_values_19 = out.values
        ____out_values_19[#____out_values_19 + 1] = "user:"
        local ____out_values_20 = out.values
        ____out_values_20[#____out_values_20 + 1] = "command:"
        local ____out_values_21 = out.values
        ____out_values_21[#____out_values_21 + 1] = "invocation:"
        out.hide_others = true
        return out
    end
    --- Advanced mode: $block command:<all|blockable command> user: [channel:] [platform:]
    -- Simple mode: $block <user> <all|blockable command>
    function commands.block(cmd, text, prefix)
        local ____utils_parse_params_25 = utils.parse_params
        local ____text_24 = text
        local ____opt_22 = cmd.params
        local parsed = ____utils_parse_params_25(
            ____text_24,
            ____opt_22 and __TS__ArrayMap(
                cmd.params,
                function(____, it) return it.name end
            ) or ({})
        )
        local argv = parsed.argv
        table.remove(argv, 1)
        if __TS__StringStartsWith(prefix, "command:") then
            return utils.commands_and_their_aliases("command:", {"BLOCK"})
        end
        local out = utils.new_completion_list()
        local ____out_values_26 = out.values
        ____out_values_26[#____out_values_26 + 1] = "channel:"
        local ____out_values_27 = out.values
        ____out_values_27[#____out_values_27 + 1] = "command:"
        local ____out_values_28 = out.values
        ____out_values_28[#____out_values_28 + 1] = "platform:"
        local ____out_values_29 = out.values
        ____out_values_29[#____out_values_29 + 1] = "user:"
        if parsed.params.size == 0 then
            local merged = utils.commands_and_their_aliases("", {"BLOCK"})
            __TS__ArrayUnshift(merged.values, "all")
            merged.hide_others = #argv == 2
            return merged
        end
        return utils.new_completion_list()
    end
    --- Advanced mode: $unping command:<all|command> [user:] [channel:] [platform:]
    -- Simple mode: $unping <all|command>
    function commands.unping(cmd, text, prefix)
        if __TS__StringStartsWith(prefix, "command:") then
            return utils.commands_and_their_aliases("command:")
        end
        local parsed = utils.parse_params(text, {"channel", "user", "command", "platform"})
        local argv = parsed.argv
        table.remove(argv, 1)
        local out = utils.new_completion_list()
        local ____out_values_30 = out.values
        ____out_values_30[#____out_values_30 + 1] = "channel:"
        local ____out_values_31 = out.values
        ____out_values_31[#____out_values_31 + 1] = "user:"
        local ____out_values_32 = out.values
        ____out_values_32[#____out_values_32 + 1] = "command:"
        local ____out_values_33 = out.values
        ____out_values_33[#____out_values_33 + 1] = "platform:"
        if parsed.params.size == 0 then
            local merged = utils.commands_and_their_aliases("")
            __TS__ArrayUnshift(merged.values, "all")
            __TS__ArrayUnshift(
                merged.values,
                table.unpack(out.values)
            )
            merged.hide_others = true
            return merged
        end
        return out
    end
    --- $optout id:<number>
    -- $optout [channel:] [platform:] [command:(all|optoutable command)]
    -- $optout <all|optoutable command> [channel:] [platform:]
    function commands.optout(cmd, text, prefix, cursor_position)
        if __TS__StringStartsWith(prefix, "command:") then
            local cmds = utils.commands_and_their_aliases("command:", {"OPT_OUT"})
            __TS__ArrayUnshift(cmds.values, "command:all")
            return cmds
        end
        local ____opt_34 = cmd.params
        local params = ____opt_34 and __TS__ArrayMap(
            cmd.params,
            function(____, it) return it.name end
        ) or ({})
        local parsed = utils.parse_params(text, params)
        local argv = parsed.argv
        local committed_args = __TS__StringTrim(__TS__StringSubstring(text, 0, cursor_position - #prefix) .. __TS__StringSubstring(text, cursor_position))
        local committed = utils.parse_params(committed_args, params)
        table.remove(committed.argv, 1)
        table.remove(argv, 1)
        local out = utils.new_completion_list()
        if parsed.params:get("id") == nil then
            local ____out_values_36 = out.values
            ____out_values_36[#____out_values_36 + 1] = "id:"
            local ____out_values_37 = out.values
            ____out_values_37[#____out_values_37 + 1] = "channel:"
            local ____out_values_38 = out.values
            ____out_values_38[#____out_values_38 + 1] = "platform:"
            if #committed.argv == 0 then
                local ____out_values_39 = out.values
                ____out_values_39[#____out_values_39 + 1] = "command:"
                local to_merge = utils.commands_and_their_aliases("")
                __TS__ArrayPushArray(out.values, to_merge.values)
            end
        end
        return out
    end
    function commands.unmention(cmd, text, prefix)
        if __TS__StringStartsWith(prefix, "command:") then
            local cmds = utils.commands_and_their_aliases("command:")
            return cmds
        end
        local ____utils_parse_params_43 = utils.parse_params
        local ____text_42 = text
        local ____opt_40 = cmd.params
        local parsed = ____utils_parse_params_43(
            ____text_42,
            ____opt_40 and __TS__ArrayMap(
                cmd.params,
                function(____, it) return it.name end
            ) or ({})
        )
        local out = utils.new_completion_list()
        out.hide_others = true
        local ____out_values_44 = out.values
        ____out_values_44[#____out_values_44 + 1] = "channel:"
        local ____out_values_45 = out.values
        ____out_values_45[#____out_values_45 + 1] = "command:"
        local ____out_values_46 = out.values
        ____out_values_46[#____out_values_46 + 1] = "platform:"
        if parsed.params.size == 0 then
            local to_merge = utils.commands_and_their_aliases("")
            out.hide_others = true
            __TS__ArrayPushArray(out.values, to_merge.values)
        end
        return out
    end
end
____exports.default = commands
return ____exports
