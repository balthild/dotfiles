-- Modified from https://github.com/iDvel/rime-ice/blob/main/lua/reduce_english_filter.lua

local M = {}

function M.init(env)
  local config = env.engine.schema.config
  env.name_space = env.name_space:gsub("^*", "")

  -- the index to put english words
  M.idx = config:get_int(env.name_space .. "/idx")
end

function M.func(input, env)
  local code = env.engine.context.input

  local pending = {}
  local index = 0

  for candidate in input:iter() do
    index = index + 1

    -- yield normal candidates, skip and store english words
    if candidate.preedit:find(" ") or not candidate.text:match("[a-zA-Z]") or candidate.type == "user_table" then
      yield(candidate)
    else
      table.insert(pending, candidate)
    end

    -- yield pending english words
    if index >= M.idx + #pending - 1 then
      for _, candidate in ipairs(pending) do
        yield(candidate)
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
