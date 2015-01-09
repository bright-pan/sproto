local parser = require "sprotoparser"
local core = require "sproto.core"
local print_r = require "print_r"

local sp = parser.parse [[
.Person {
	name 0 : string
	id 1 : integer
	email 2 : string

	.PhoneNumber {
		number 0 : string
		type 1 : integer
	}

	phone 3 : *PhoneNumber
}

.AddressBook {
	person 0 : *Person
}
]]
print(sp)
print(string.len(sp))
sp = core.newproto(sp)
--core.dumpproto(sp)
local st = core.querytype(sp, "AddressBook")
local st1 = core.querytype(sp, "Person")
print(st)
print(st1)

local ab = {
	person = {
		{
			name = "Alice",
			id = 10000,
			phone = {
				{ number = "123456789" , type = 1 },
				{ number = "87654321" , type = 2 },
			}
		},
		{
			name = "Bob",
			id = 20000,
			phone = {
				{ number = "01234567890" , type = 3 },
			}
		}
	}
}

collectgarbage "stop"

local encode_time , decode_time = ...

encode_time = assert(tonumber(encode_time))
decode_time = assert(tonumber(decode_time))

local code

for i=1,encode_time do
--	code = core.pack(core.encode(st, ab))
	code = core.encode(st, ab)
end
print(type(code))
print(code)
print(string.len(code))
local address
for i=1,decode_time do
--	local addr = core.decode(st, core.unpack(code))
	local addr = core.decode(st1, code)
	address = addr
--	for k,p in ipairs(addr.person) do
--		for k,v in ipairs(p.phone) do
--			for _,_ in pairs(v) do
--			end
--		end
--	end
end
print "************"
print(type(address))
print_r(address)
