all: data/completions_generated.json init.lua

# Change this to your preferred package manager
NPM := yarn

init.lua: data/completions_generated.json tsconfig.json package.json Makefile $(wildcard *.ts)
	$(NPM) run build

# This empty rule convinces make to update completions_generated if config.json was touched but not cry if it doesn't exist
data/config.json:
data/completions_generated.json: generate.js data/config.json $(wildcard supibot/build/commands/*/*.js)
	node generate.js

update_pull:
	git submodule update --init supibot
	git -C supibot checkout master
	git -C supibot pull
	cp supibot/config-default.json supibot/config.json
	cd supibot; $(NPM) install
	cd supibot; $(NPM) build

update: update_pull data/completions_generated.json init.lua
