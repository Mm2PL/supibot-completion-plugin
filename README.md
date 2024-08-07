# Supibot completion plugin

A plugin for Chatterino both demonstrating that TSTL is capable enough and a somewhat useful feature.

## Features

The plugin:

- Completes simple commands (like `$ping`).
- Understands the concept of subcommands (commands like `$alias`, `$abb`, `$set`).
- Understands the `$pipe` command, you can complete commands inside of it (cannot use the `_char` param yet).
- Understands command parameters, you can complete parameter names (like `$rca description:`).
- Understands that `$help` takes a command as an input.

## Usage

1. Ensure you are on a build after [#5280](https://github.com/chatterino/chatterino2/pull/5280).
2. Just dump the contents of the repo into a new directory in your chatterino plugins directory.
3. Enable in the settings

## Building

1. Clone with submodules
2. `npm i`
3. Optionally copy `data/config.dist.json` to `data/config.json` and put in your username to download a list of your Supibot aliases automatically.
4. Use `make` to compile Typescript to Lua (if you delete `data/completions_generated.json` this will regenerate it)

### Update command definitions

1. This involves executing basically arbitrary code from [the supibot repo](https://github.com/supinic/supibot), ensure you are comfortable with that.
2. Run `make update` to update/download the `supibot` submodule, regenerate `data/completions_generated.json` and rebuild the plugin

## Projects used

This uses `json.lua` created by rxi, [the project is available
here](https://github.com/rxi/json.lua). The license may be found at the top of
the file. The Typescript definitions (`json.d.ts`) for it were created by me.

