# Supibot completion plugin

A plugin for Chatterino both demonstrating that TSTL is capable enough and a somewhat useful feature.

## Usage

1. Ensure you are on a build after [#5000](https://github.com/chatterino/chatterino2/pull/5000).
2. Just dump the contents of the repo into a new directory in your chatterino plugins directory.
3. Enable in the settings

## Building

1. Clone with submodules
2. `npm i`
3. Use `make` to compile Typescript to Lua (if you delete `completions_generated.json` this will regenerate it)

### Update command definitions

1. This involves executing basically arbitrary code from [the supibot repo](https://github.com/supinic/supibot), ensure you are comfortable with that.
2. Run `make update` to update/download the `supibot` submodule, regenerate `completions_generated.json` and rebuild the plugin

