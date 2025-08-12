local M = {}

M.telescope = require("telescope.builtin")

function M.SwitchBuffer()
  local settings = {
    layout_strategy = "center",
    sort_mru = true,
    -- sort_lastused = true,
    ignore_current_buffer = true,
    layout_config = { width = 0.3, height = 0.8, prompt_position = "bottom" },
    startinsert = false,
  }
  M.telescope.buffers(settings)
end

vim.g.hidden_all = 0

function M.ToggleZenMode()
  if vim.g.hidden_all == 0 then
    vim.g.hidden_all = 1
    vim.opt.showmode = false
    vim.opt.ruler = false
    vim.opt.laststatus = 0
    vim.opt.showcmd = false
  else
    vim.g.hidden_all = 0
    vim.opt.showmode = true
    vim.opt.ruler = true
    vim.opt.laststatus = 3
    vim.opt.showcmd = true
  end
end

-- Split line into tokens with camelCase and symbol separation
function M.move_by_sub_word(dir)
  function tokenize(line)
    local tokens = {}
    local token_start = 1
    local token_type = nil

    local function char_type(ch)
      if ch:match("%s") then return "space" end
      if ch:match("[%a%d]") then return "alnum" end
      return "symbol"
    end

    local len = #line
    for i = 1, len do
      local ch = line:sub(i, i)
      local ctype = char_type(ch)
      local prev = (i > 1) and line:sub(i - 1, i - 1) or ""
      local camel_split = (ctype == "alnum" and ch:match("[A-Z]") and prev:match("[a-z]"))

      if token_type == nil then
        token_type = ctype
      elseif ctype ~= token_type or camel_split then
        table.insert(tokens, { start = token_start, stop = i - 1 })
        token_start = i
        token_type = ctype
      end
    end
    table.insert(tokens, { start = token_start, stop = len })
    return tokens
  end


  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.fn.getline(row)
  local tokens = tokenize(line)

  if dir == "right" then
    for _, t in ipairs(tokens) do
      if col < t.start then
        vim.api.nvim_win_set_cursor(0, { row, t.start })
        return
      end
    end
    vim.api.nvim_win_set_cursor(0, { row, #line + 1 }) -- end of line
  else -- left
    for i = #tokens, 1, -1 do
      if col > tokens[i].start then
        vim.api.nvim_win_set_cursor(0, { row, tokens[i].start })
        return
      end
    end
    vim.api.nvim_win_set_cursor(0, { row, 1 }) -- start of line
  end
end

-- Main word movement (space/punct separated, stop at EOL)
function M.move_by_word(dir)
  local col = vim.fn.col(".")
  local line = vim.fn.getline(".")
  if dir == "right" then
    local after = line:sub(col + 1)
    local pos = after:find("[%s%p]+%S")
    if pos then
      vim.fn.cursor(0, col + pos + 1)
    else
      vim.fn.cursor(0, #line)
    end
  else -- left
    local before = line:sub(1, col - 1)
    local rev = before:reverse()
    local pos = rev:find("[%s%p]+%S")
    if pos then
      vim.fn.cursor(0, col - pos)
    else
      vim.fn.cursor(0, 1)
    end
  end
end

-- Function to reload config without losing session
function _G.ReloadConfig()
  for name,_ in pairs(package.loaded) do
    if name:match("^user") or name:match("^plugins") or name:match("^settings") then
      package.loaded[name] = nil
    end
  end
  dofile(vim.fn.stdpath("config") .. "/init.lua")
  print("Config reloaded!")
end

return M
