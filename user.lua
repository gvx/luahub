local user = {}

function user.search(name)
	local t = luahub._apiquery('user/search', name)
	t = t.users
	return t, #t > 0 and t[1].name
end

function user.show(name, info)
	if type(info) == 'table' then
		local i = {}
		for k,v in pairs(info) do
			i['values['..k..']'] = v
		end
		info = i
	end
	local t = luahub._apiquery('user/show', name, info)
	if t then
		t = t.user or t.users
		return t
	end
end

luahub.user = user
