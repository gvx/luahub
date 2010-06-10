local blob = {}

function blob.show(user_id, repository, tree_sha, path) --TODO: add support for ?meta=1
	local t = luahub._apiquery('blob/show', user_id, repository, tree_sha, path)
	return t.blob
end

function blob.all(user_id, repository, tree_sha)
	local t = luahub._apiquery('blob/all', user_id, repository, tree_sha)
	return t.blobs
end

function blob.full(user_id, repository, tree_sha)
	local t = luahub._apiquery('blob/full', user_id, repository, tree_sha)
	return t.blobs
end

luahub.blob = blob
