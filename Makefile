all: completions_generated.json init.lua

init.lua: init.ts inspect.lua inspect.d.ts utils.ts chatterino.d.ts completions_generated.json tsconfig.json package.json Makefile
	npm run build
	sed -i 's/= require("\(.\+\)")/= import("\1.lua")/g' init.lua utils.lua

completions_generated.json: make_lua.js
	node make_lua.js

