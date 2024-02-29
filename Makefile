all: completions_generated.json init.lua

# Change this to your preferred package manager
NPM := npm

init.lua: init.ts utils.ts chatterino.d.ts completions_generated.json tsconfig.json package.json Makefile percommand.ts
	$(NPM) run build

# This empty rule convinces make to update completions_generated if config.json was touched but not cry if it doesn't exist
config.json:
completions_generated.json: generate.js config.json $(wildcard supibot/commands/*/*.js)
	node generate.js

update_pull:
	git submodule update --init supibot
	git -C supibot checkout master
	git -C supibot pull
	cd supibot; $(NPM) install --no-package-lock

update: update_pull completions_generated.json init.lua
