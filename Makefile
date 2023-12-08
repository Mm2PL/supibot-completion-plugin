all: completions_generated.json init.lua

# Change this to your preferred package manager
NPM := npm

init.lua: init.ts utils.ts chatterino.d.ts completions_generated.json tsconfig.json package.json Makefile
	$(NPM) run build
	sed -i 's/= require("\(.\+\)")/= import("\1.lua")/g' init.lua utils.lua

completions_generated.json: generate.js supibot/commands/**
	node generate.js

update_pull:
	git -C supibot pull
	$(NPM) install

update: update_pull completions_generated.json init.lua
