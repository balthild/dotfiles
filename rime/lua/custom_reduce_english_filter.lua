-- Derived from https://github.com/iDvel/rime-ice/blob/main/lua/reduce_english_filter.lua

local M = {}

function M.init(env)
	-- the index to put english words
	M.idx = 5
end

function M.func(input, env)
	local pending = {}
	local index = 0

	for candidate in input:iter() do
		index = index + 1

		-- yield normal candidates or proper names, skip and store other english words
		if
			candidate.preedit:find(" ")
			or candidate.type == "user_table"
			or candidate.text:match("[^a-z]")
		then
			yield(candidate)
		else
			table.insert(pending, candidate)
		end

		-- yield pending english words
		if index >= M.idx + #pending - 1 then
			for _, word in ipairs(pending) do
				yield(word)
			end
			break
		end
	end

	-- yield the rest
	for candidate in input:iter() do
		yield(candidate)
	end
end

return M
