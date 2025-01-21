import { decode } from "./json";
import data from './data';
import utils from "./utils";
import { asyncwrap, lawait, plawait } from "./async";

const { config } = data;

type AliasType = {
    name: string,
    created: string,
    edited: string | null,
    link_author: string | null,
    link_name: string | null,
    invocation: string,
};
type SupinicComAlias = {
    name: string,
    created: string,
    edited: string,
    linkAuthor: string | null,
    linkName: string | null,
    invocation: string
};

export function load_aliases() {
    return aload_aliases(null, null);
}
export function aload_aliases(ok_cb: null | (() => void), err_cb: null | ((what: string) => void)) {
    if (!should_load_aliases()) {
        c2.log(c2.LogLevel.Info, "Ignoring loading aliases, no username given.");
        return;
    }
    const url =
        `https://supinic.com/api/bot/user/${utils.encode_uri_component(config.my_username)}/alias/list`;
    print(`Begin downloading aliases from ${url}`);
    const req = c2.HTTPRequest.create(c2.HTTPMethod.Get, url);
    req.set_header("User-Agent", utils.HTTP_USER_AGENT);
    req.on_success((res: c2.HTTPResponse) => {
        const [ok, json] = pcall(decode, res.data());
        if (!ok) {
            c2.Channel.by_name("supinic")
                ?.add_system_message(`Failed to load aliases: API returned invalid JSON`);
            c2.log(c2.LogLevel.Critical, `FAILED TO LOAD ALIASES: RECEIVED ${res.status()} BUT COULD NOT PARSE JSON.`);
            c2.log(c2.LogLevel.Critical, "Data: " + res.data());
            if (err_cb) {
                err_cb("JSON parse failure");
            }
            return;
        }

        aliases = [...json.data].map((inp: SupinicComAlias) => {
            return {
                name: inp.name,
                created: inp.created,
                edited: inp.edited,
                link_author: inp.linkAuthor,
                link_name: inp.linkName,

                invocation: inp.invocation,
            }
        });
        c2.Channel.by_name("supinic")
            ?.add_system_message(`Loaded ${aliases?.length} supibot user aliases.`);
        if (ok_cb) {
            ok_cb();
        } else {
            print('OK Callback missing for load aliases');
        }
    });
    req.on_error((res: c2.HTTPResponse) => {
        c2.log(
            c2.LogLevel.Warning,
            "Failed to load aliases for user \"", config.my_username, "\" (HTTP ", res.status(), " ): ", res.error()
        );
        c2.Channel.by_name("supinic")
            ?.add_system_message(`Failed to load aliases: ${res.error()}`);
        if (err_cb) {
            err_cb(`HTTP error: ${res.error()}: ${res.status()}`);
        } else {
            print('no err callback');
        }
    });
    req.finally(() => {
        print('Finish loading aliases');
    });
    req.execute();
}

let aliases: Array<AliasType> | null = null;
export function get_aliases() {
    return aliases;
}
export function should_load_aliases() {
    return config.my_username !== "";
}

function alias_interceptor(ctx: c2.CommandContext) {
    ctx.channel.send_message(ctx.words.join(" "), false);
    if (!aliases || !config.intercept_alias)
        return;

    ctx.words.shift();
    const subcommand = ctx.words.shift();
    if (!subcommand) {
        c2.log(c2.LogLevel.Warning, "Failed to parse $alias command, missing subcommand");
        return;
    }
    const ADD_SUBCOMMANDS = [
        'create',
        'add',
        'upsert',
        'addedit'
    ];
    if (ADD_SUBCOMMANDS.includes(subcommand)) {
        const name = ctx.words.shift();
        if (!name) {
            c2.log(c2.LogLevel.Warning, "Failed to parse $alias add command, missing name");
            return;
        }
        const existing = aliases.find(it => it.name === name);
        if (existing === undefined) {
            aliases.push({
                name: name,
                created: "1970-01-01T00:00:00Z",
                edited: null,
                link_author: null,
                link_name: null,
                invocation: ctx.words.shift() ?? "<unknown>",
            })
        }
        return;
    }
    const DELETE_SUBCOMMANDS = [
        'delete',
        'remove'
    ];
    if (DELETE_SUBCOMMANDS.includes(subcommand)) {
        const name = ctx.words.shift();
        if (!name) {
            c2.log(c2.LogLevel.Warning, "Failed to parse $alias delete command, missing name");
            return;
        }
        const existing = aliases.find(it => it.name === name);
        if (existing) {
            aliases.splice(aliases.indexOf(existing), 1);
        }
    }
    const COPYLINK_SUBCOMMANDS = [
        'copy',
        'copyplace',
        'link',
        'linkplace',
    ];
    if (COPYLINK_SUBCOMMANDS.includes(subcommand)) {
        const source_user = ctx.words.shift();
        if (!source_user) {
            c2.log(c2.LogLevel.Warning, "Failed to parse $alias copy/link command, missing user");
            return;
        }
        const source_name = ctx.words.shift();
        if (!source_name) {
            c2.log(c2.LogLevel.Warning, "Failed to parse $alias copy/link command, missing alias name");
            return;
        }
        const custom_name = ctx.words.shift();

        const name = custom_name ?? source_name;
        const existing = aliases.find(it => it.name === name);
        if (existing) {
            existing.link_author = source_user;
            existing.link_name = source_name;
        } else {
            aliases.push({
                name: name,
                created: "1970-01-01T00:00:00Z",
                edited: null,
                link_author: source_user,
                link_name: source_name,
                invocation: "<unknown>",
            })
        }
    }
    if (subcommand === 'duplicate') {
        const nameold = ctx.words.shift();
        if (!nameold) {
            c2.log(c2.LogLevel.Warning, "Failed to parse $alias duplicate command, missing old name");
            return;
        }
        const namenew = ctx.words.shift();
        if (!namenew) {
            c2.log(c2.LogLevel.Warning, "Failed to parse $alias duplicate command, missing new name");
            return;
        }
        const existing = aliases.find(it => it.name === nameold);
        if (!existing)
            return;
        aliases.push(
            {
                ...existing,
                name: namenew,
            }
        )
    }
}

function aliasreload(ctx: c2.CommandContext) {
    if (!should_load_aliases()) {
        ctx.channel.add_system_message("Configure '/sbc:config set my_username <name>' first.");
        return;
    }
    ctx.channel.add_system_message("Reloading aliases");
    const [ok, res] = plawait(aload_aliases);
    if (ok) {
        ctx.channel.add_system_message("Done reloading aliases");
    } else {
        ctx.channel.add_system_message(`Failed to reload: ` + res);
    }
};

c2.register_command("/sbc:aliasreload", asyncwrap(aliasreload));

if (config.intercept_alias) {
    c2.register_command("$alias", alias_interceptor);
}
