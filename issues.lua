local issues = {}

function issues.search(user_id, repository, state, searchterm)
	local t = luahub._apiquery('issues/search', user_id, repository, state, searchterm)
	return t.issues
end

function issues.list(user_id, repository, state)
	local t = luahub._apiquery('issues/list', user_id, repository, state)
	return t.issues
end

function issues.show(user_id, repository, number)
	local t = luahub._apiquery('issues/show', user_id, repository, number)
	return t.issue
end

function issues.comments(user_id, repository, number)
	local t = luahub._apiquery('issues/comments', user_id, repository, number)
	return t.comments
end

function issues.open(user_id, repository) --FIXME: this needs POST to work
	local t = luahub._apiquery('issues/open', user_id, repository)
	return t.issue
end

function issues.close(user_id, repository, number)
	local t = luahub._apiquery('issues/close', user_id, repository, number)
	return t.issue
end

function issues.reopen(user_id, repository, number)
	local t = luahub._apiquery('issues/reopen', user_id, repository, number)
	return t.issue
end

luahub.issues = issues
