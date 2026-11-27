local M = {}

M.config = {
	user_phrase = "*",
	user_table = "*",
	sentence = "∞",
}

function M.init(env)
	--
end

function M.func(input, env)
	for candidate in input:iter() do
		if candidate.comment == "" then
			candidate.comment = M.config[candidate.type] or ""
		end

		yield(candidate)
	end
end

return M
