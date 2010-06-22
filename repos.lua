local repos = {show = {}}

function repos.search(query, language, start_page)
	local t = ''
	if language or start_page then
		t = '?'
		if language then
			t = t .. 'language=' .. language
			if start_page then
				t = t .. '&'
			end
		end
		if start_page then
			t = t .. 'start_page=' .. start_page
		end
	end
	t = luahub._apiquery('repos/search', query .. t)
	t = t.repositories
	return t, #t > 0 and (t[1].username .. '/' .. t[1].name)
end

local _mt_show = {}
setmetatable(repos.show, _mt_show)
function _mt_show.__call(self, user, repo, extra) --variants: repos.show(user)
                             --repos.show(user, repo, {description='Blah', ...}
                             --repos.show(user, repo, 'collaborators') aka repos.show.collaborators(user, repo)
                             --repos.show(user, repo, 'contributors') aka repos.show.contributors(user, repo)
                             --repos.show(user, repo, 'network') aka repos.show.network(user, repo)
                             --repos.show(user, repo, 'languages') aka repos.show.languages(user, repo)
                             --etc.
                             --note show.contributors is different: it takes an extra boolean, whether or not to include anons
	if type(extra) == 'table' then
		local e = {}
		for k,v in pairs(extra) do
			e['values['..k..']'] = v
		end
		extra = e
	end
	local t = luahub._apiquery('repos/show', user, repo, extra)
	if t then
		t = t[extra] or t.repository or t.repositories
		return t
	end
end
function _mt_show.__index(self, name)
	return function()
		local t = luahub._apiquery('repos/show', user, repo, name)
		if t then
			return t[name]
		end
	end
end

function repos.watch(user, repo)
	luahub._apiquery('repos/watch', user, repo) --no data returned?
end

function repos.unwatch(user, repo)
	luahub._apiquery('repos/unwatch', user, repo) --no data returned?
end

function repos.fork(user, repo)
	local t = luahub._apiquery('repos/fork', user, repo)
	if t then
		t = t.repository
		return t
	end
end

function repos.keys(repo)
	local t = luahub._apiquery('repos/keys', repo)
	if t then
		t = t.public_keys
		return t
	end
end

--[[
function repos.show.collaborators(user, repo)
	local t = luahub._apiquery('repos/show', user, repo, 'collaborators')
	if t then
		return t.collaborators
	end
end
--]]

function repos.pushable()
	local t = luahub._apiquery('repos/pushable')
	return t
end

function repos.show.contributors(user, repo, show_anon)
	local t = luahub._apiquery('repos/show', user, repo, 'contributors', show_anon and 'anon')
	if t then
		return t.contributors
	end
end

--[[function repos.show.network(user, repo)
	local t = luahub._apiquery('repos/show', user, repo, 'network')
	if t then
		return t.network
	end
end]]

function repos.create(name, description, homepage, public)
	luahub._apiquery('repos/create', {name = name, description = description,
		homepage = homepage, public = public})
end

function repos.delete(name, token)
	local t = luahub._apiquery('repos/delete', name, token and {delete_token=token})
	return t.delete_token
end

-- TODO: add post actions for repos
--  - set/private
--  - set/public
--  - keys/add
--  - keys/remove
--  - repos/collaborators/:repo/add/:user
--  - repos/collaborators/:repo/remove/:user


luahub.repos = repos
