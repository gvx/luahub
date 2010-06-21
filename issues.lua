local issues = {}

function issues.search(user_id, repository, state, searchterm)
	local t = luahub._apiquery('issues/search', user_id, repository, state, searchterm)
	return t.issues
end

function issues.list(user_id, repository, state)
	local t = luahub._apiquery('issues/list', user_id, repository, state)
	return t.issues
end

function issues.show(user_id, repository, issue_id)
	local t = luahub._apiquery('issues/show', user_id, repository, issue_id)
	return t.issue
end

function issues.comments(user_id, repository, issue_id)
	local t = luahub._apiquery('issues/comments', user_id, repository, issue_id)
	return t.comments
end

function issues.open(user_id, repository) --FIXME: this needs POST to work
	local t = luahub._apiquery('issues/open', user_id, repository)
	return t.issue
end

function issues.close(user_id, repository, issue_id)
	local t = luahub._apiquery('issues/close', user_id, repository, issue_id)
	return t.issue
end

function issues.reopen(user_id, repository, issue_id)
	local t = luahub._apiquery('issues/reopen', user_id, repository, issue_id)
	return t.issue
end

function issues.labels(user_id, repository)
	local t = luahub._apiquery('issues/labels', user_id, repository)
	return t.labels
end

function issues.addlabel(user_id, repository, label, issue_id)
	local t = luahub._apiquery('issues/label/add', user_id, repository, label, issue_id)
	return t.labels
end

function issues.removelabel(user_id, repository, label, issue_id)
	local t = luahub._apiquery('issues/label/remove', user_id, repository, label, issue_id)
	return t.labels
end

function issues.comment(user_id, repository, issue_id) --FIXME: add post
	local t = luahub._apiquery('issues/comment', user_id, repository, label, issue_id)
	return t.comment
end

luahub.issues = issues
