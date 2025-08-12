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

return M
