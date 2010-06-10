require 'socket.http'
require 'json/json' --require 'json' doesn't work for me

luahub.prefix = 'http://github.com/api/v2/json/'
local request = socket.http.request
local auth = ''
function set_auth(login, token)
	if login then
		auth = '?login='..login..'&token=' .. token
	else
		auth = ''
	end
end
local function _callapi(query)
	local get, response = request(luahub.prefix .. query .. auth)
	if response == 200 then
		return json.decode(get)
	else
		error('GitHub returned status '..response..': '..json.decode(get).error, 4)
	end
end

function luahub._apiquery(...)
	return _callapi(table.concat({...}, '/'))
end
