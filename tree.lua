local tree = {}

function tree.show(user_id, repository, tree_sha)
	local t = luahub._apiquery('tree/show', user_id, repository, tree_sha)
	return t.tree
end

function tree.full(user_id, repository, tree_sha)
	local t = luahub._apiquery('tree/full', user_id, repository, tree_sha)
	return t.tree
end

luahub.tree = tree
