/*
function startswith(str: any, start: String): boolean {
    return str.sub(1, start.length) == start;
}

function endswith(str: any, fin: String) {
    return str.sub(-fin.length) == fin;
}
*/
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
        for(let i = 1; i <= str.length; i++) {
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
        try{
            load("");
            return true;
        }catch(e) {
            return false;
        }
    }
}

export default utils;
