import {Command} from "./init";
import utils from "./utils";
enum BanType {
    OFFLINE_ONLY = "offline-only",
    ONLINE_ONLY = "online-only",
    ARGUMENTS = "arguments",
    COOLDOWN = "cooldown",
    BLACKLIST = "blacklist",
    REMINDER_PREVENTION = "reminder-prevention",
};

namespace commands {
    /**
     * COMMON = [user:] [command:] [invocation:]
     * $ban [type:blacklist] $COMMON
     * $ban type:reminder-prevention [user:] [channel:]
     * $ban type:cooldown [multiplier:] $COMMON
     * $ban type:arguments [all:(true|false)] [index:] [string:]
     * $unban type:arguments [clear:(true|false)] [all:(true|false)] [index:] [string:]
     */
    export function ban(this: void, cmd: Command, invocation: string, text: string, prefix: string): c2.CompletionList {
        const out = utils.new_completion_list();
        if (prefix.startsWith("command:")) {
            return utils.commands_and_their_aliases("command:");
        }
        if (prefix.startsWith("invocation:")) {
            return utils.commands_and_their_aliases("invocation:");
        }

        const parsed = utils.parse_params(text, cmd.params?.map(it => it.name) ?? []);
        let typ = parsed.params.get("type");
        let invalid_type = true;
        for (const [k, v] of Object.entries(BanType)) {
            if (v === typ) {
                invalid_type = false;
            }
        }
        if (typ === undefined || invalid_type) {
            // User didn't specify a "type:" param, suggest them possible variants
            // Not having one is perfectly valid too.
            // Note that lua k-v tables don't guarantee order
            out.values.push("type:" + BanType.ARGUMENTS);
            out.values.push("type:" + BanType.BLACKLIST);
            out.values.push("type:" + BanType.COOLDOWN);
            out.values.push("type:" + BanType.OFFLINE_ONLY);
            out.values.push("type:" + BanType.ONLINE_ONLY);
            out.values.push("type:" + BanType.REMINDER_PREVENTION);

            typ = "blacklist";
        }

        if (typ === BanType.REMINDER_PREVENTION) {
            out.values.push("user:");
            out.values.push("channel:");
            out.hide_others = false;
            return out;
        }
        if (typ === BanType.COOLDOWN) {
            out.values.push("multiplier:");
            out.values.push("multiplier:1.5");
            out.values.push("multiplier:2");
        }
        if (typ === BanType.ARGUMENTS) {
            out.values.push("all:true");
            out.values.push("index:");
            out.values.push("string:");
            if (invocation === 'unban') {
                out.values.push("clear:true");
            }
        }

        out.values.push("user:");
        out.values.push("command:");
        out.values.push("invocation:");
        out.hide_others = true;
        return out;
    }

    /**
     * Advanced mode: $block command:<all|blockable command> user: [channel:] [platform:]
     * Simple mode: $block <user> <all|blockable command>
     */
    export function block(this: void, cmd: Command, text: string, prefix: string): c2.CompletionList {
        const parsed = utils.parse_params(text, cmd.params?.map(it => it.name) ?? []);
        const {argv} = parsed;
        argv.shift(); // remove command name

        // maybe simple mode?
        if (prefix.startsWith("command:")) {
            return utils.commands_and_their_aliases("command:", ["BLOCK"]);
        }
        const out = utils.new_completion_list();
        out.values.push("channel:");
        out.values.push("command:");
        out.values.push("platform:");
        out.values.push("user:");
        if (parsed.params.size === 0) {
            // we can be in simple mode, as we have no params
            const merged = utils.commands_and_their_aliases("", ["BLOCK"]);
            merged.values.unshift("all");
            merged.values.push(...out.values);
            // have $[un]block <username> <word>|
            merged.hide_others = argv.length === 2;
            return merged;
        }
        return out;
    }

    /**
     * Advanced mode: $unping command:<all|command> [user:] [channel:] [platform:]
     * Simple mode: $unping <all|command>
     */
    export function unping(this: void, cmd: Command, text: string, prefix: string): c2.CompletionList {
        if (prefix.startsWith("command:")) {
            return utils.commands_and_their_aliases("command:");
        }
        // XXX: This is parsed in-command
        const parsed = utils.parse_params(text, ["channel", "user", "command", "platform"]);
        const {argv} = parsed;
        argv.shift(); // remove command name

        const out = utils.new_completion_list();
        out.values.push("channel:");
        out.values.push("user:");
        out.values.push("command:");
        out.values.push("platform:");
        if (parsed.params.size === 0) {
            // simple mode
            // $unping <all|command>
            const merged = utils.commands_and_their_aliases("");
            merged.values.unshift("all");
            // allow user to pick advanced mode but not complete usernames, emotes and such
            merged.values.unshift(...out.values);
            merged.hide_others = true;
            return merged;
        }
        return out;
    }

    /**
     * $optout id:<number>
     * $optout [channel:] [platform:] [command:(all|optoutable command)]
     * $optout <all|optoutable command> [channel:] [platform:]
     */
    export function optout(this: void, cmd: Command, text: string, prefix: string, cursor_position: number): c2.CompletionList {
        if (prefix.startsWith("command:")) {
            const cmds = utils.commands_and_their_aliases("command:", ["OPT_OUT"]);
            cmds.values.unshift("command:all");
            return cmds;
        }
        const params = cmd.params?.map(it => it.name) ?? [];
        const parsed = utils.parse_params(text, params);
        const {argv} = parsed;
        const committed_args = (text.substring(0, cursor_position - prefix.length) + text.substring(cursor_position)).trim();
        const committed = utils.parse_params(committed_args, params);
        committed.argv.shift();
        argv.shift(); // remove command name
        const out = utils.new_completion_list();
        // ID logically conflicts with all other params
        if (parsed.params.get("id") === null) {
            out.values.push("id:");
            out.values.push('channel:');
            out.values.push('platform:');
            // no command
            if (committed.argv.length === 0) {
                out.values.push('command:');
                const to_merge = utils.commands_and_their_aliases("");
                out.values.push(...to_merge.values);
            }
        }
        return out;
    }
    export function unmention(this: void, cmd: Command, text: string, prefix: string): c2.CompletionList {
        if (prefix.startsWith("command:")) {
            const cmds = utils.commands_and_their_aliases("command:");
            //cmds.values.unshift("command:all");
            return cmds;
        }
        const parsed = utils.parse_params(text, cmd.params?.map(it => it.name) ?? []);
        const out = utils.new_completion_list();
        out.hide_others = true;
        out.values.push("channel:");
        out.values.push("command:");
        out.values.push("platform:");

        if (parsed.params.size === 0) {
            const to_merge = utils.commands_and_their_aliases("");
            out.hide_others = true;
            out.values.push(...to_merge.values);
        }
        return out;
    }

    const PLAYER_COMMON = [
        'rude:',
        'seasonal:',
    ];
    /**
      * $osrs itemid <item>
      * $osrs price <item>
      *
      * PLAYER_COMMON := [rude:] [seasonal:]
      * $osrs <username> [skill:] [virtual:] ${PLAYER_COMMON}
      * ACTIVITY := ?
      * $osrs (kc|killcount|kill-count) (activity:${ACTIVITY}|boss:${ACTIVITY}) ${PLAYER_COMMON} <name> 
      * $osrs stars|star
      * $osrs status
      * $osrs guthix|tears|tog
      * $osrs wiki <free form text>
      */

    export function osrs(this: void, cmd: Command, text: string, prefix: string): c2.CompletionList {
        const s = text.split(" ", 2);
        const sub = s[1];

        const out = utils.new_completion_list();
        if (sub === 'itemid' || sub === 'price'
            || sub === 'stars' || sub === 'star'
            || sub === 'status'
            || sub === 'guthix' || sub == 'tears' || sub == 'tog'
            || sub == 'wiki') {
            return out; // nothing to complete
        }
        if (sub === 'kc' || sub == 'killcount' || sub === 'kill-count') {
            // TODO

            if (!text.includes('activity:') && !text.includes('boss:')) {
                out.values.push('activity:');
                out.values.push('boss:');
            }
            out.values.push(...PLAYER_COMMON);
            return out;
        }
        if (utils.count_occurences_of_byte(text, ' ') <= 2) {
            out.values.push('itemid ');
            out.values.push('price ');
            out.values.push('stars ', 'star ');
            out.values.push('status ');
            out.values.push('guthix ', 'tears ', 'tog ');
            out.values.push('wiki ');
            out.values.push('kc ', 'killcount ', 'kill-count ');
            out.values.push(...PLAYER_COMMON);
            out.values.push('skill:', 'virtual:');
            return out;
        }
        mm2pl_open_debugger().break_here();
        // $osrs <sub> ...
        return out;
    }
}

export default commands;
