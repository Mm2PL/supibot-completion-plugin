import { decode, encode } from "./json";
import utils from "./utils";

export type Command = {
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

function load_file(this: void, fname: string, default_val = {}): any {
    const [f, err] = io.open(fname, 'r');
    if (err !== null || f === undefined) {
        c2.log(c2.LogLevel.Warning, "Failed to load file", fname, err);
        return default_val;
    }
    const dat = <string>f.read('a');
    print('loading file', fname);
    return decode(dat);
}


export class Config {
    data: Record<string, any>;

    constructor() {
        this.data = load_file('config.json');
        this.init_defaults();
    }

    private init_defaults(): void {
        this.data.my_username ??= "";
        this.data.rewrite_gift ??= false;
        this.data.intercept_alias ??= true;
        this.data.excluded_flags ??= ["WHITELIST"];
    }

    public save(): void {
        c2.log(c2.LogLevel.Info, 'Writing config file.');
        const [f, err] = io.open('config.json', 'w');
        if (err !== null || f === undefined) {
            c2.log(c2.LogLevel.Info, 'Failed to open config file', err);
            throw new Error(`Unable to open config file: ${err}`);
        }
        f.write(encode(this.data));
        f.close();
    }

    public get my_username(): string {
        return this.data.my_username ?? "";
    }
    public set my_username(val: string) {
        this.data.my_username = val;
    }

    public get rewrite_gift(): boolean {
        return this.data.rewrite_gift ?? false;
    }
    public set rewrite_gift(val: boolean) {
        this.data.rewrite_gift = val;
    }

    public get intercept_alias(): boolean {
        return this.data.intercept_alias ?? true;
    }
    public set intercept_alias(val: boolean) {
        this.data.intercept_alias = val;
    }

    public get excluded_flags(): Array<string> {
        return this.data.excluded_flags ?? ["WHITELIST"];
    }
    public set excluded_flags(val: Array<string>) {
        this.data.excluded_flags = val;
    }
};

const gen = load_file("completions_generated.json");
const { definitions, git } = gen;


export default {
    config: new Config(),
    definitions: <Array<Command>>definitions,
    git,
};
