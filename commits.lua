local commits = {}

function commits.list(user_id, repository, branch, path)
	local t = luahub._apiquery('commits/list', user_id, repository, branch, path)
	return t.commits
end

function commits.show(user_id, repository, sha)
	local t = luahub._apiquery('commits/show', user_id, repository, sha)
	return t.commit
end

luahub.commits = commits
