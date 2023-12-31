//import {inspect} from './inspect';
import utils from './utils';
import * as generated from './completions_generated.json';

function cmd_eval(this: void, ctx: c2.CommandContext) {
    table.remove(ctx.words, 1);
    let input: string = ctx.words.join(" ");
    let source = "return " + input;
    c2.system_msg(ctx.channel_name, ">>>" + input);
    let f: (() => any) | undefined;
    let err: any;
    [f, err] = load(source);
    if (f === undefined) {
        c2.system_msg(ctx.channel_name, "!<" + tostring(err));
    } else {
        c2.system_msg(ctx.channel_name, "<< " + tostring(f()));
    }
}

function commands_and_their_aliases(this: void, _prefix: string | null, _out: c2.CompletionList | null): c2.CompletionList {
    let prefix: string = _prefix === null ? "$" : _prefix;
    let out: c2.CompletionList = _out === null ? utils.new_completion_list() : _out;
    for (const val of generated.definitions) {
        if (!utils.arr_contains_any(val.flags, generated.excluded_flags)) {
            // Prioritize aliases that are more uppercase but otherwise equal to command name
            // XXX: setting potential: remove uncapitalised command name
            const lowerAlias = val.aliases?.filter(a => a.toLowerCase() == val.name.toLowerCase());
            if (lowerAlias !== undefined && lowerAlias.length !== undefined && lowerAlias.length > 0) {
                out.values.push(prefix + lowerAlias[0] + " ");
            }

            out.values.push(prefix + val.name + " ");
            if (val.aliases !== null) {
                for (const v2 of val.aliases) {
                    if (!out.values.includes(v2)) {
                        out.values.push(prefix + v2 + " ");
                    }
                }
            }
        }
    }
    return out;
}

type Command = {
    name: string,
    aliases: string[] | null,
    params: {
        name: string,
        type: string,
    }[] | null,
    flags: string[],
    subcommands: Command[] | null,
    eat_before_sub_command: number,
    pipe: boolean,
}

function lookup_command(this: void, name: string): Command | null {
    c2.log(c2.LogLevel.Debug, "Looking up ", name);
    for (const c of generated.definitions) {
        if (c.name === name) {
            return c;
        }
        if (c.aliases?.includes(name)) {
            return c;
        }
    }
    return null;
}

function lookup_subcommand(this: void, name: string, cmdData: Command): Command | null {
    if (cmdData.subcommands === null) return null;
    for (const c of cmdData.subcommands) {
        if (c.name === name) {
            return c;
        }
        if (c.aliases !== null) {
            for (const alias of c.aliases) {
                if (alias === name) {
                    return c;
                }
            }
        }
    }
    return null;
}

function find_useful_completions(this: void, text: string, prefix: string, is_first_word: boolean): c2.CompletionList {
    if (!text.startsWith("$")) {
        return utils.new_completion_list();
    }
    //print("text is: ", inspect(text));
    //print("prefix is: ", inspect(prefix));

    if (is_first_word) {
        let out = commands_and_their_aliases(null, null);
        out.hide_others = true;
        return out;
    }

    // for "$COMMAND "
    if (text.startsWith("$") && text.endsWith(" ") && utils.count_occurences_of_byte(text, " ") == 1) {
        let out = commands_and_their_aliases(null, null);
        out.hide_others = true;
        return out;
    }

    // for "$ COMMAND"
    if (text.startsWith("$ ") && utils.count_occurences_of_byte(text, " ") == 1) {
        let out = commands_and_their_aliases("", null);
        out.hide_others = true;
        return out;
    }
    let [_0, _1, command] = string.find(text, "^[$] ?([^ ]+) ?");
    print("Command is: \"" + command + "\"");
    let is_piped = false;
    let cmd_data = lookup_command(<string>command);
    if (cmd_data !== null && cmd_data.name === "alias" && command === "$") {
        // we are in alias invocation, do not currently have the data for this
        return utils.new_completion_list();
    }

    // meta commands
    if (command == "pipe") {
        is_piped = true;
        print("pipe detected")
        // check for "|"
        // TODO: account for pipe _char param
        let [commandA] = string.match(text, "[|] ?([^ ]+)[^|]+$")
        let [commandB] = string.match(text, "pipe *([^ ]+)[^|]+$")

        let [m1] = string.match(text, "[|] ?[^ ]+$");
        let [m2] = string.match(text, "pipe *[^ ]+$");
        if (m1 !== null || m2 !== null) {
            let out = commands_and_their_aliases("", null);
            out.hide_others = true;
            return out;
        }

        if (commandA !== null) {
            command = commandA;
        }
        if (commandB !== null) {
            command = commandB;
        }
        //command = commandA || commandB;
        cmd_data = lookup_command(<string>command);
    }

    while (cmd_data?.subcommands !== null && cmd_data?.subcommands !== undefined) {
        //print(cmd_data, " has subcommands: ", inspect(cmd_data.subcommands));

        const WORD = " [^ ]+";
        const pat = command + string.rep(WORD, cmd_data.eat_before_sub_command+1) + "$";
        let [temp] = string.match(text, pat);
        if (temp !== null) {
            print("matched subcmd ", temp, " from ", pat)
            let out = utils.new_completion_list();
            out.hide_others = true;
            for (const val of cmd_data.subcommands) {
                if (is_piped && !val.pipe) {
                    continue;
                }
                out.values.push(
                    val.name + " "
                );

                for (const v2 of val.aliases ?? []) {
                    out.values.push(v2 + " ");
                }
            }

            return out;
        }

        [command] = string.match(text, command + string.rep(WORD, cmd_data.eat_before_sub_command) + " ([^ ]+)");
        cmd_data = lookup_subcommand(command, cmd_data);
        if (cmd_data == null) {
            break;
        }
    }
    if (cmd_data !== null && cmd_data.params !== null && cmd_data.params.length != 0) {
        let out = utils.new_completion_list();
        print("DANKING!")
        for (const val of cmd_data.params) {
            out.values.push(val.name + ":");
        }
        return out;
    }

    // special cases
    if (command == "help") {
        return commands_and_their_aliases("", null);
    }

    return utils.new_completion_list();
}

function filter(inp: c2.CompletionList, filter: string): c2.CompletionList {
    let out = utils.new_completion_list();
    out.hide_others = inp.hide_others;
    filter = filter.toLowerCase();
    for (const c of inp.values) {
        if (c.toLowerCase().startsWith(filter)) {
            out.values.push(c);
        }
    }
    return out;
}

c2.register_callback(
    c2.EventType.CompletionRequested,
    (text: string, full_text: string, position: number, is_first_word: boolean) => {
        c2.log(c2.LogLevel.Debug, "doing completions: ", text, full_text, position, is_first_word);
        return filter(find_useful_completions(full_text, text, is_first_word), text);
    }
);


c2.register_command("/sbc:eval", cmd_eval);
c2.system_msg("supinic", "[Completion loaded]");
