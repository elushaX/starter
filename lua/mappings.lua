require "nvchad.mappings"
local functions = require('functions')

local map = vim.keymap.set

-- UI Toggles
map("n", "<S-h>", functions.ToggleZenMode, { desc = "Toggle all UI elements (mode, ruler, statusline)" })

-- Basic Editing
map("n", "<Enter>", "i<Enter><Esc>", { desc = "Insert new line below" })
map("n", "qq", ":bdelete<CR>", { desc = "Close current buffer" })

-- Navigation
map("n", ";", ":", { desc = "Enter command mode" })

-- Line Movement
map("n", "<A-Up>", ":m-2<CR>==", { desc = "Move current line up" })
map("i", "<A-Up>", "<Esc>:m-2<CR>==gi", { desc = "Move current line up (insert mode)" })
map("n", "<A-Down>", ":m+<CR>==", { desc = "Move current line down" })
map("i", "<A-Down>", "<Esc>:m+<CR>==gi", { desc = "Move current line down (insert mode)" })
map("x", "<M-Up>", ":move '<-2<CR>gv=gv", { desc = "Move selected block up" })
map("x", "<M-Down>", ":move '>+<CR>gv=gv", { desc = "Move selected block down" })

-- Mode Switching
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- General Mappings
map("n", ";", ":", { desc = "command mode", nowait = true })
map("n", "<Leader><Leader>", ":nohlsearch<CR>", { desc = "clear search highlighting" })
map("n", "<C-f>", ":Format<CR>", { desc = "format file" })
map("n", "<Leader>cc", ":ClangdSwitchSourceHeader<CR>", { desc = "switch source/header" })
map("n", "t", functions.SwitchBuffer, { desc = "switch buffer" })
map("n", "<Leader>tt", "<cmd>Telescope<CR>", { desc = "open telescope" })
map("n", "<Leader>ll", "<cmd>lua require('persistence').load({ last = true })<cr>", { desc = "load last session" })
map("n", "<Leader>ld", "<cmd>lua BuffersDelete()<cr>", { desc = "clear current session" })
map("n", "<Leader>sa", "<cmd>wa<cr>", { desc = "save all files" })
map("n", "<Leader>ss", "<cmd>w<cr>", { desc = "save file" })
map("n", "<Leader>sq", "<cmd>wqa<cr>", { desc = "save all files and quit" })
map("n", "<Leader>sd", "<cmd>bd<cr>", { desc = "close current buffer" })
map("n", "<Leader>ee", "<cmd>lua NVTreeToggleBufferView()<cr>", { desc = "show open tabs in nvtree" })

-- Telescope Mappings
map("n", "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "fzf in file" })
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })

-- Select entire buffer
map("n", "<C-a>", "ggVG", { desc = "Select all content" })
map("v", "<C-a>", "ggVG", { desc = "Select all content" })
map("i", "<C-a>", "<Esc>ggVG", { desc = "Select all content" })

-- Copy (visual mode only - prevents conflict with command mode)
map("v", "<C-c>", '"+y', { desc = "Copy selection to clipboard" })
map("v", "<C-x>", '"+d', { desc = "Cut selection to clipboard" })
map("n", "<C-v>", '"+P', { desc = "Paste from clipboard" })
map("i", "<C-v>", '<C-r>+', { desc = "Paste from clipboard" })
map("t", "<C-v>", "<C-\\><C-n>\"+P", { desc = "Paste in terminal mode" })

-- cursor jumps
map("n", "<A-Left>", '<C-o>+', { desc = "Cursor prev" })
map("n", "<A-Right>", '<C-I>+', { desc = "Cursor next" })
map("i", "<A-Left>", '<C-o>+', { desc = "Cursor prev" })
map("i", "<A-Right>", '<C-I>+', { desc = "Cursor next" })

map("n", "<X1Mouse>", '<C-o>+', { desc = "Cursor prev" })
map("n", "<X2Mouse>", '<C-I>+', { desc = "Cursor next" })
map("i", "<X1Mouse>", '<C-o>+', { desc = "Cursor prev" })
map("i", "<X2Mouse>", '<C-I>+', { desc = "Cursor next" })

map('n', '<C-r>', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'Rename symbol (LSP)' })

-- context menu
map('n', '<A-CR>', function()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_input_mouse('right', 'press', '', 0, pos[1]-1, pos[2])
  vim.api.nvim_input_mouse('right', 'release', '', 0, pos[1]-1, pos[2])
end, { noremap = true, silent = true })

return M
