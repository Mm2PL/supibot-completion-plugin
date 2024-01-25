import * as generated from './completions_generated.json';

namespace utils {
    export function arr_contains_any<T>(this: void, left: Array<T>, right: Array<T>): boolean {
        for (const e of right) {
            if (left.includes(e)) return true;
        }
        return false;
    }

    export function count_occurences_of_byte(this: void, str: string, b: string): Number {
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
        return {hide_others: false, values: []};
    }

    export function has_load(this: void): boolean {
        try {
            load("");
            return true;
        } catch (e) {
            return false;
        }
    }
    /**
     * @param {string} prefix Prefix to add to completions, usually "$" or "". Do not use spaces.
     */
    export function commands_and_their_aliases(this: void, prefix: string, required_flags: Array<string> = []): c2.CompletionList {
        let out: c2.CompletionList = utils.new_completion_list();
        for (const val of generated.definitions) {
            if (required_flags.length !== 0 && !required_flags.every(it => val.flags.includes(it))) {
                continue;
            }
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
}

export default utils;
