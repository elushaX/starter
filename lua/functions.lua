local M = {}

M.telescope = require("telescope.builtin")

function M.SwitchBuffer()
  local settings = {
    layout_strategy = "center",
    sort_mru = true,
    -- sort_lastused = true,
    ignore_current_buffer = true,
    layout_config = { width = 0.3, height = 0.8, prompt_position = "bottom" },
    startinsert = true,
  }
  M.telescope.buffers(settings)
end

vim.g.hidden_all = 0

function M.LUB()
    bufnrs = { "" }
    if vim.tbl_isempty(bufnrs) then
        vim.print("No modified buffers")
    else
        M.telescope.buffers { 
          bufnrs = bufnrs
        }
    end
end

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

-- Helper function to check if a character is a word boundary (space or punctuation)
local function is_word_boundary(char)
    return char:match("%s") or char:match("%p")
end

-- Helper function to check if a character is a camelCase boundary
local function is_camel_boundary(prev_char, curr_char)
    if not prev_char or not curr_char then return false end
    -- Check for transition from lowercase to uppercase (e.g., 'n' to 'C' in camelCase)
    return prev_char:match("[a-z]") and curr_char:match("[A-Z]")
end

-- Move cursor by word (space/punctuation separated, stop at EOL)
function M.move_by_word(dir)
    vim.cmd("w")

    local cursor = vim.api.nvim_win_get_cursor(0) -- Example: Neovim API
    local line_num = cursor[1]
    local col = cursor[2]
    local line = vim.api.nvim_get_current_line() -- Get current line text
    local line_len = #line

    if dir == "right" then -- Forward
        while col < line_len do
            col = col + 1
            local char = line:sub(col, col)
            if is_word_boundary(char) then
                -- Skip consecutive boundaries
                while col < line_len and is_word_boundary(line:sub(col + 1, col + 1)) do
                    col = col + 1
                end
                break
            end
        end
    elseif dir == "left" then -- Backward
        while col > 1 do
            col = col - 1
            local char = line:sub(col, col)
            if is_word_boundary(char) then
                -- Skip consecutive boundaries
                while col > 1 and is_word_boundary(line:sub(col - 1, col - 1)) do
                    col = col - 1
                end
                break
            end
        end
    end

    -- Stop at EOL or beginning of line
    col = math.max(1, math.min(line_len, col))
    vim.api.nvim_win_set_cursor(0, {line_num, col}) -- Update cursor position
end

-- Move cursor by subword (camelCase or underscore separated, stop at EOL)
function M.move_by_sub_word(dir)
    local cursor = vim.api.nvim_win_get_cursor(0) -- Example: Neovim API
    local line_num = cursor[1]
    local col = cursor[2]
    local line = vim.api.nvim_get_current_line() -- Get current line text
    local line_len = #line

    if dir == "right" then -- Forward
        while col < line_len do
            col = col + 1
            local curr_char = line:sub(col, col)
            local prev_char = col > 1 and line:sub(col - 1, col - 1) or nil
            if is_word_boundary(curr_char) or is_camel_boundary(prev_char, curr_char) then
                -- Skip consecutive boundaries
                while col < line_len and is_word_boundary(line:sub(col + 1, col + 1)) do
                    col = col + 1
                end
                break
            end
        end
    elseif dir == "left" then -- Backward
        while col > 1 do
            col = col - 1
            local curr_char = line:sub(col, col)
            local prev_char = col > 1 and line:sub(col - 1, col - 1) or nil
            if is_word_boundary(curr_char) or is_camel_boundary(prev_char, curr_char) then
                -- Skip consecutive boundaries
                while col > 1 and is_word_boundary(line:sub(col - 1, col - 1)) do
                    col = col - 1
                end
                break
            end
        end
    end

    -- Stop at EOL or beginning of line
    col = math.max(1, math.min(line_len, col))
    vim.api.nvim_win_set_cursor(0, {line_num, col}) -- Update cursor position
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


function M.git_blame()
  if vim.fn.executable("git") == 0 then
    return ""
  end

  local file = vim.fn.expand("%")
  if file == "" or vim.fn.filereadable(file) == 0 then
    return ""
  end

  local line = vim.fn.line(".")
  local cmd = string.format("git blame -L %d,+1 --porcelain -- %s", line, file)
  local result = vim.fn.systemlist(cmd)

  if #result == 0 or result[1]:match("^fatal") then
    return ""
  end

  local author = ""
  local commit = result[1]:match("^(%S+)")
  for _, l in ipairs(result) do
    local a = l:match("^author (.+)")
    if a then
      author = a
      break
    end
  end

  if commit == "0000000000000000000000000000000000000000" then
    return "Not committed yet"
  end


  return string.format(" %s [%s]", author, commit:sub(1, 8))
end

M.show_cursor_diagnostic = function()
  -- Get diagnostics for current line & column
  local line = vim.fn.line(".") - 1
  local col = vim.fn.col(".") - 1

  local diags = vim.diagnostic.get(0, {
    lnum = line
  })

  -- Find diagnostic that covers the cursor position
  local msg = nil
  for _, d in ipairs(diags) do
    if d.col <= col and col < d.end_col then
      msg = d.message
      break
    end
  end

  -- Remove any previous namespace annotations
  local ns = vim.api.nvim_create_namespace("cursor_diagnostic")
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

  if msg then
    vim.api.nvim_buf_set_extmark(0, ns, line, 0, {
      virt_text = { { " " .. msg, "DiagnosticVirtualTextWarn" } },
      virt_text_pos = "eol",
    })
  end
end

return M
