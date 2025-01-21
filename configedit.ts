/** @noSelfInFile */
import storage from "./data";
import utils from "./utils";
const {config} = storage;

function config_show(ctx: c2.CommandContext, args: string[]): void {
    ctx.channel.add_system_message("Supibot Completion Plugin config:");
    for (const p of props) {
        ctx.channel.add_system_message(`[${p.name}] ${p.display}: ${config.data[p.name]}`);
    }
}

function config_set(ctx: c2.CommandContext, args: string[]): void {
    if (args.length === 0) {
        ctx.channel.add_system_message('Usage: /sbc:config set <property_name> <value>');
        return;
    }
    const prop = ctx.words.shift();
    const value = ctx.words.shift();
    if (prop === undefined || value === undefined) {
        return assert(false);
    }
    const p = props.find(v => v.name === prop);
    if (p === undefined) {
        ctx.channel.add_system_message(`Unknown sbc config: ${prop}`);
        return;
    }
    try {
        config.data[prop] = p.convert(value);
    } catch (e) {
        ctx.channel.add_system_message(`Error: ${e}`);
        return;
    }
    ctx.channel.add_system_message(`Updated ${prop}.`);
    config.save();
}

function conv_str(s: string) {return s;}
function conv_bool(s: string) {
    if (s === 'true') {
        return true;
    }
    if (s === 'false') {
        return false;
    }
    throw new Error(`Unable to convert: ${s} to boolean`);
}

const props = [
    {name: "my_username", display: "Username", convert: conv_str},
    {name: "rewrite_gift", display: "Rewrite $gift to $cookie", convert: conv_bool},
    { name: "intercept_alias", display: "Intercept $alias command and reload aliases", convert: conv_bool }
]

type ConfigSub = {
    help: string,
    func: (this: void, ctx: c2.CommandContext, args: string[]) => void,
    completions: (this: void, words: string[]) => string[],
};

const config_subs: Record<string, ConfigSub> = {
    show: {help: "Shows you the config", func: config_show, completions: () => []},
    set: {
        help: "Sets a config value",
        func: config_set,
        completions: (words: string[]) => {
            if (words.length == 0)
                return [];
            if (words.length == 1) {
                return props.map(it => it.name + ' ');
            } else {
                const prop = props.find(it => it.name.toLowerCase() == words[0]);
                if (prop?.convert == conv_bool) {
                    return ['true', 'false'];
                }
                return [];
            }
        }
    },
};

function command_config(ctx: c2.CommandContext) {
    ctx.words.shift();
    if (ctx.words.length === 0) {
        ctx.channel.add_system_message('Available /sbc:config subcommands:');
        for (const [k, sub] of Object.entries(config_subs)) {
            ctx.channel.add_system_message(`  ${k} -- ${sub.help}`);
        }
        return;
    }
    const sub = <string>ctx.words.shift();
    const cb = config_subs[sub];
    cb.func(ctx, [...ctx.words]);
}
export function init_config_edit() {
    c2.register_command('/sbc:config', command_config);
}

export function sbcconfig_complete(ev: c2.CompletionEvent): c2.CompletionList {
    const words = ev.full_text_content.split(' ');
    if (words[words.length - 1] == "") {
        words.pop();
    }
    if (words.length == 1) {
        return utils.new_completion_list();
    }
    if (words.length == 2) {
        // subcommand completion
        const list = utils.new_completion_list();
        list.hide_others = true;
        list.values = Object.keys(config_subs).map(it => it + ' ');
        return utils.filter(list, ev.query);
    }
    // /sbc:config <sub> <query>
    words.shift();
    const sub = <string>words.shift();
    const out = utils.new_completion_list();
    out.values = config_subs[sub].completions(words);
    if (out.values.length > 0) {
        out.hide_others = true;
    }
    return utils.filter(out, ev.query);
}
