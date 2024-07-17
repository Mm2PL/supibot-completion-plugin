all: data/completions_generated.json init.lua

# Change this to your preferred package manager
NPM := npm

init.lua: init.ts utils.ts chatterino.d.ts data/completions_generated.json tsconfig.json package.json Makefile percommand.ts configedit.ts
	$(NPM) run build

# This empty rule convinces make to update completions_generated if config.json was touched but not cry if it doesn't exist
data/config.json:
data/completions_generated.json: generate.js data/config.json $(wildcard supibot/commands/*/*.js)
	node generate.js

update_pull:
	git submodule update --init supibot
	git -C supibot checkout master
	git -C supibot pull
	cd supibot; $(NPM) install --no-package-lock

update: update_pull data/completions_generated.json init.lua
