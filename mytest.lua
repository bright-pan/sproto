local print_r = require "print_r"
local sproto = require "sproto"
local parser = require "sprotoparser"
local descriptor = sproto.parse [[
.type {
.field {
name 0 : string
buildin 1 : integer
type 2 : integer
tag 3 : integer
array 4 : boolean
}
name 0 : string
fields 1 : *field
}

.protocol {
name 0 : string
tag 1 : integer
request 2 : integer # index
response 3 : integer # index
}

.group {
type 0 : *type
protocol 1 : *protocol
}
]]

local rpc = [[
.rpc {
ok 0 : boolean
}
]]

print(type(parser.parse(rpc)))
print((parser.parse(rpc)))

local ab = {
	  type = {
		   {
				name="rpc",
				fields = {
				{
				name="ok",
				 buildin=0,
				 tag=1,
				 type=1,
				 array=false,
				 },
		   },
		   },
	  },
}
local code = descriptor:encode("group",ab)
print(type(code))
print(code)

local desc = descriptor:decode("group", parser.parse(rpc))
print_r(desc)
local desc = descriptor:decode("group", code)

print_r(desc)