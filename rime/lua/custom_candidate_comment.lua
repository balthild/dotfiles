local M = {}

function M.init(env)
	local config = env.engine.schema.config
	env.name_space = env.name_space:gsub("^*", "")
	M.is_in_user_dict = config:get_bool(env.name_space) or true
end

function M.func(input, env)
	for cand in input:iter() do
		if cand.type == "user_phrase" or cand.type == "user_table" then
			cand.comment = "*"
		end

		if cand.type == "sentence" then
			cand.comment = "∞"
		end

		yield(cand)
	end
end

return M
