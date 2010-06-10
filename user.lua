local user = {}

function user.search(name)
	local t = luahub._apiquery('user/search', name)
	t = t.users
	return t, #t > 0 and t[1].name
end

function user.show(name)
	local t = luahub._apiquery('user/show', name)
	if t then
		t = t.user
		return t
	end
end

luahub.user = user
