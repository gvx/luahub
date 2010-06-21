require 'socket.http'
require 'socket.url'
require 'json/json' --require 'json' doesn't work for me

luahub.prefix = 'github.com/api/v2/json/'
local request = socket.http.request
local escape = socket.url.escape
local auth = ''
function set_auth(login, token)
	if login then
		auth = login .. ':' .. token
	else
		auth = ''
	end
end
local function _callapi(query, body)
	local get, response = request('http://' .. auth .. luahub.prefix .. query, body)
	if response == 200 then
		return json.decode(get)
	else
		local t,a = pcall(json.decode, get)
		if t then
			t = ': '..a.error
		else
			t = ''
		end
		error('GitHub returned status '..response..t, 4)
	end
end

function luahub._apiquery(...)
	local query = {...}
	local body
	if type(query[#query]) == 'table' then
		local s = table.remove(query)
		body = {}
		for k,v in pairs(s) do
			table.insert(body, k .. '=' .. escape(v))
		end
		body = table.concat(body, '&')
	end
	return _callapi(table.concat(query, '/'), body)
end
