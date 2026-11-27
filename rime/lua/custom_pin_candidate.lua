--- @class Env
--- @field engine any
--- @field pins table<string, Pin>

--- @class Pin
--- @field texts string[]
--- @field indices table<string, integer>

local M = {}

M.config = {
	{ "wo", "我" },
	{ "le", "了" },
	{ "de", "的 地 得" },
	{ "miao", "喵" },
	{ "wu", "唔 呜" },
	{ "na", "那" },
	{ "zan", "咱" },
}

--- @param env Env
function M.init(env)
	if env.pins ~= nil then
		return
	end

	env.pins = {}
	for _, item in ipairs(M.config) do
		local preedits = M.tokenize(item[1])
		local texts = M.tokenize(item[2])

		for _, preedit in ipairs(M.expand(preedits)) do
			local pin = env.pins[preedit]
			if pin == nil then
				pin = { texts = {}, indices = {} }
				env.pins[preedit] = pin
			end

			for _, text in ipairs(texts) do
				if pin.indices[text] == nil then
					table.insert(pin.texts, text)
					pin.indices[text] = #pin.texts
				end
			end
		end
	end
end

--- @param env Env
function M.func(input, env)
	-- 当前输入框的 preedit，未经过方案 translator/preedit_format 转换
	-- 输入「nihaoshij」则为「nihaoshij」，选择了「你好」后变成「你好shij」
	local preedit_full = env.engine.context:get_preedit().text
	-- 非汉字部分的 preedit，如「shij」
	local preedit_tail = string.gsub(preedit_full, "[^a-zA-Z]", "")

	-- 只有整个 preedit_tail 都匹配时才重排，其余情况原样输出
	local pin = env.pins and env.pins[preedit_tail]
	if pin == nil then
		for candidate in input:iter() do
			yield(candidate)
		end
		return
	end

	local found = 0
	local pinned = {}
	local others = {}

	for candidate in input:iter() do
		local preedit = candidate.preedit:gsub(" ", "")
		if preedit ~= preedit_tail then
			table.insert(others, candidate)
			break
		end

		local index = pin.indices[candidate.text]
		if index ~= nil and pinned[index] == nil then
			found = found + 1
			pinned[index] = candidate
		else
			table.insert(others, candidate)
		end

		-- 找齐了或查询超过 100 个就不找了，如果要固顶的候选项不在前 100 就不会被固顶
		if found == #pin.texts or #others > 100 then
			break
		end
	end

	-- 保持配置中的候选项顺序
	for index = 1, #pin.texts do
		local candidate = pinned[index]
		if candidate ~= nil then
			candidate.comment = "!"
			yield(candidate)
		end
	end

	for _, candidate in ipairs(others) do
		yield(candidate)
	end

	for candidate in input:iter() do
		yield(candidate)
	end
end

--- @param source string
--- @return string[]
function M.tokenize(source)
	local result = {}
	for token in source:gmatch("%S+") do
		table.insert(result, token)
	end
	return result
end

--- @param codes string[]
--- @return string[]
function M.expand(codes)
	if #codes == 0 then
		return {}
	end

	--- @type string[][]
	local vectors = {}
	for i, code in ipairs(codes) do
		vectors[i] = { code }

		-- 首字母
		if #code > 1 then
			table.insert(vectors[i], code:sub(1, 1))
		end

		-- 完整声母
		if code:match("^[zcs]h") then
			table.insert(vectors[i], code:sub(1, 2))
		end
	end

	--- @type string[]
	local preedits = { "" }
	for _, vector in ipairs(vectors) do
		-- 类似于笛卡尔积，但把每组结果拼接成单一字符串
		local combinations = {}

		for _, prefix in ipairs(preedits) do
			for _, code in ipairs(vector) do
				table.insert(combinations, prefix .. code)
			end
		end

		preedits = combinations
	end

	return preedits
end

return M
