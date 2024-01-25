all: completions_generated.json init.lua

# Change this to your preferred package manager
NPM := npm

init.lua: init.ts utils.ts chatterino.d.ts completions_generated.json tsconfig.json package.json Makefile percommand.ts
	$(NPM) run build

completions_generated.json: generate.js config.json $(wildcard supibot/commands/*/*.js)
	node generate.js

update_pull:
	git submodule update --init supibot
	git -C supibot checkout master
	git -C supibot pull
	cd supibot; $(NPM) install

update: update_pull completions_generated.json init.lua
