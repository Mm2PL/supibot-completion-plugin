import storage from './data';

namespace utils {
    export const VERSION = 'v1.2.0';
    export const HTTP_USER_AGENT = `supibot-completion-plugin (${VERSION}) (https://github.com/mm2pl/supibot-completion-plugin)`;

    const ASCII = {
        'A': string.byte('A'),
        'Z': string.byte('Z'),
        'a': string.byte('a'),
        'z': string.byte('z'),
        '0': string.byte('0'),
        '9': string.byte('9'),
    };

    /**
     * Returns true if i is in [begin, end].
     */
    function in_range(this: void, i: number, begin: number, end: number): boolean {
        return begin <= i && i <= end;
    }

    export function encode_uri_component(this: void, input: string): string {
        let out = '';
        const outliers = [...'-.!~*\'()'];
        for (const char of input) {
            const byte = string.byte(char);
            if (outliers.includes(char)) {
                out += char;
            } else if (in_range(byte, ASCII.A, ASCII.Z)
                || in_range(byte, ASCII.a, ASCII.z)
                || in_range(byte, ASCII['0'], ASCII['9'])
            ) {
                out += char;
            } else {
                // We need to encode it with % encoding
                out += '%' + byte.toString(16);
            }
        }
        return out;
    }

    export function arr_contains_any<T>(this: void, left: Array<T>, right: Array<T>): boolean {
        for (const e of right) {
            if (left.includes(e)) return true;
        }
        return false;
    }

    export function count_occurences_of_byte(this: void, str: string, b: string): number {
        const byte = string.byte(b);
        let count = 0;
        for (let i = 1; i <= str.length; i++) {
            let sb = string.byte(str, i);
            if (sb == byte) {
                count++;
            }
        }
        return count
    }

    export function new_completion_list(this: void): c2.CompletionList {
        return { hide_others: false, values: [] };
    }

    export function has_load(this: void): boolean {
        try {
            load("");
            return true;
        } catch (e) {
            return false;
        }
    }

    export type CommandArgs = {
        params: Map<string, string>,
        argv: Array<string>
    }

    export function parse_params(this: void, text: string, expected_names: Array<string>): CommandArgs {
        let quoted = false;
        let lastspace = 0;
        let currentname = null;
        let value_begin = null;
        let last_param_end = 0;
        let non_param_args = [];
        const out = new Map();
        for (let i = 0; i < text.length; i++) {
            const char = text[i];
            if (char === ' ') {
                lastspace = i;
                if (!quoted && currentname !== null) {
                    // end of param value
                    out.set(currentname, text.slice(value_begin ?? 0, i));
                    currentname = null;
                    last_param_end = i;
                }
            }
            else if (char === ':' && !quoted) {
                // param:VALUE
                const name = text.slice(lastspace + 1, i);
                //print(`begin param? "${name}" ex: "${expected_names.join(";")}"`);
                if (expected_names.includes(name)) {
                    non_param_args.push(text.slice(last_param_end, i));
                    currentname = name;
                    value_begin = i + 1;
                }
            } else if (char === '"') {
                quoted = !quoted;
            }
        }
        if (quoted) {
            throw new Error('Unclosed quote');
        }
        if (currentname !== null) {
            out.set(currentname, text.slice(value_begin ?? 0, text.length));
        }
        non_param_args.push(text.slice(last_param_end, text.length));
        return { params: out, argv: non_param_args.join(" ").split(" ") };
    }

    export const REQUIRE_LEGACY_GIVE_CFG = "REQUIRE_LEGACY_GIVE_CFG";
    function get_excluded_flags(this: void): Array<string> {
        if (storage.config.rewrite_gift) {
            return storage.config.excluded_flags;
        }
        let temp = [...storage.config.excluded_flags];
        temp.push(REQUIRE_LEGACY_GIVE_CFG);
        return temp;
    }


    /**
     * @param {string} prefix Prefix to add to completions, usually "$" or "". Do not use spaces.
     */
    export function commands_and_their_aliases(this: void, prefix: string, required_flags: Array<string> = []): c2.CompletionList {
        let out: c2.CompletionList = utils.new_completion_list();
        const excl_flags = get_excluded_flags();
        for (const val of storage.definitions) {
            if (required_flags.length !== 0 && !required_flags.every(it => val.flags.includes(it))) {
                continue;
            }
            if (!utils.arr_contains_any(val.flags, excl_flags)) {
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

    export function filter(inp: c2.CompletionList, filter: string): c2.CompletionList {
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

}

export default utils;
