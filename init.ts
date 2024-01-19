//import {inspect} from './inspect';
import utils from './utils';
import * as generated from './completions_generated.json';



/**
 * @param {string} prefix Prefix to add to completions, usually "$" or "". Do not use spaces.
 */
function commands_and_their_aliases(this: void, prefix: string): c2.CompletionList {
    let out: c2.CompletionList = utils.new_completion_list();
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
};
type SupinicComAlias = {
    name: string,
    invocation: string,
    created: string,
    edited: string | null,
    link_author: string | null,
    link_name: string | null,
};

/**
 * Look up a command by name from the generated definitions
 */
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

/**
 * Look up a subcommand of a given command by name
 */
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

function users_aliases(this: void, prefix: string): c2.CompletionList {
    const out = utils.new_completion_list();
    if (generated.aliases.length === 0)
        return out;
    out.hide_others = true;
    for (const alias of <any[]>generated.aliases) {
        out.values.push(prefix + alias.name);
    }
    return out;
}

function try_subcommand_completions(this: void, text: string, sub_data: Command | null, subcommand: string, tree: string[], is_piped: boolean): c2.CompletionList | null {
    while (sub_data?.subcommands !== null && sub_data?.subcommands !== undefined) {
        print(`Iterating subcommand loop: at ${tree.join("->")} (${sub_data.subcommands.length} subs)`);

        const WORD = " [^ ]+";
        const pat_end = subcommand + string.rep(WORD, sub_data.eat_before_sub_command + 1) + "$";
        print(`Created pattern: "${pat_end}" for ${subcommand}, text is "${text}"`);
        let [temp] = string.match(text, pat_end);
        if (temp !== null) {
            print(`matched subcmd "${temp}" from "${pat_end}"`);
            let out = utils.new_completion_list();
            out.hide_others = true;
            for (const val of sub_data.subcommands) {
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

        const pat_more = subcommand + string.rep(WORD, sub_data.eat_before_sub_command) + " ([^ ]+)";
        [subcommand] = string.match(text, pat_more);
        sub_data = lookup_subcommand(subcommand, sub_data);
        if (sub_data == null) {
            print(`No more sub commands at ${tree.join("->")} with pattern "${pat_more}"`);
            break;
        }
        print(`Have more sub commands at ${tree.join("->")} -> "${subcommand}"`);
        tree.push(subcommand);
    }
    return null;
}

function find_useful_completions(this: void, text: string, prefix: string, cursor_position: number, is_first_word: boolean): c2.CompletionList {
    if (!text.startsWith("$")) {
        return utils.new_completion_list();
    }
    // Alias invocation like "$$ASD"
    if (is_first_word && text.startsWith('$$')) {
        return users_aliases("$$");
    }

    if (is_first_word) {
        let out = commands_and_their_aliases("$");
        out.hide_others = true;
        return out;
    }

    // for "$COMMAND "
    if (text.startsWith("$") && text.endsWith(" ") && utils.count_occurences_of_byte(text, " ") == 1) {
        let out = commands_and_their_aliases("$");
        out.hide_others = true;
        return out;
    }

    // for "$ COMMAND"
    if (text.startsWith("$ ") && utils.count_occurences_of_byte(text, " ") == 1) {
        let out = commands_and_their_aliases("");
        out.hide_others = true;
        return out;
    }
    let [_0, _1, command] = string.find(text, "^[$] ?([^ ]+) ?");
    let is_piped = false;
    let cmd_data = lookup_command(<string>command);
    print(`Command is: "${command}"`);
    if (cmd_data !== null && cmd_data.name === "alias" && command === "$") {
        return users_aliases("");
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
            let out = commands_and_their_aliases("");
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

    const sub_command_tree: string[] = [<string>command];

    const maybe_comps = try_subcommand_completions(text, cmd_data, <string>command, sub_command_tree, is_piped);
    if (maybe_comps !== null) {
        // have subcommands to complete
        return maybe_comps;
    }
    print(`Tree is ${sub_command_tree.join("->")}`);
            return out;
        }
    }
    if (cmd_data !== null && cmd_data.params !== null && cmd_data.params.length != 0) {
        let out = utils.new_completion_list();
        print("DANKING!")
        for (const val of cmd_data.params) {
            if (val.type === 'boolean') {
                out.values.push(val.name + ":true");
                out.values.push(val.name + ":false");
            } else {
                out.values.push(val.name + ":");
            }
        }
        return out;
    }

    // special cases
    if (command == "help") {
        let completions = commands_and_their_aliases("");
        completions.hide_others = true;
        return completions;
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
        return filter(find_useful_completions(full_text, text, position, is_first_word), text);
    }
);

if (utils.has_load()) {
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

c2.system_msg("supinic", "[Completion loaded]");
    c2.register_command("/sbc:eval", cmd_eval);
}
