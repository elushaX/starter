require "nvchad.mappings"
local functions = require('functions')

local builtin = require("telescope.builtin")
local utils = require("telescope.utils")

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
map("n", "Tab.", functions.SwitchBuffer, { desc = "switch buffer" })
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
-- map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
-- map("n", "<leader>ff", function() builtin.find_files({ cwd = utils.buffer_dir() }) end, { desc = "Find buffers" })
map("n", "<leader>fw", function() builtin.live_grep({ cwd = utils.buffer_dir() }) end, { desc = "Find buffers" })

-- Select entire buffer
map("n", "<C-a>", "ggVG", { desc = "Select all content" })
map("v", "<C-a>", "ggVG", { desc = "Select all content" })
map("i", "<C-a>", "<Esc>ggVG", { desc = "Select all content" })

vim.cmd([[
nnoremap d <Nop>
nnoremap x <Nop>
nnoremap p <Nop>
nnoremap P <Nop>

nnoremap u <Nop>
nnoremap <C-q> <Nop> -- fixme
]])


map("n", "<C-z>", 'u', { noremap = true, silent = true })
map("n", "<C-q>", 'qa', { noremap = true, silent = true }) -- fixme

function setupClipboard()

 
  -- delete
  -- map("n", "<C-d>", 'V"_d', { noremap = true, silent = true })
  map("n", "<C-d>", '"_dd', { noremap = true, silent = true })

  map("n", "<C-v>", '"+P', { desc = "Paste from clipboard" })

  -- cut
  map("n", "<C-x>", 'V"+d', { noremap = true, silent = true })
  -- map("n", "<C-x>", '"+dd', { noremap = true, silent = true })

  -- map("v", "<d>", '"_d', { noremap = true, silent = true, desc = "Copy selection to clipboard" })
  -- map("n", "<d>", '"_x', { noremap = true, silent = true, desc = "Copy selection to clipboard" })
  map("v", "<C-c>", '"+y', { desc = "Copy selection to clipboard" })
  map("v", "<C-x>", '"+d', { desc = "Cut selection to clipboard" })
  map("i", "<C-v>", '<C-r>+', { desc = "Paste from clipboard" })
  map("t", "<C-v>", "<C-\\><C-n>\"+P", { desc = "Paste in terminal mode" })
  map('n', '<BS>', '"_X', { noremap = true, silent = true })
  map('v', '<BS>', '"_d', { noremap = true, silent = true })
end

setupClipboard()

-- cursor jumps
map("n", "<A-Left>", '<C-o>+', { desc = "Cursor prev" })
map("n", "<A-Right>", '<C-I>+', { desc = "Cursor next" })
map("i", "<A-Left>", '<C-o>+', { desc = "Cursor prev" })
map("i", "<A-Right>", '<C-I>+', { desc = "Cursor next" })

map("n", "<X1Mouse>", '<C-o>+', { desc = "Cursor prev" })
map("n", "<X2Mouse>", '<C-I>+', { desc = "Cursor next" })
map("i", "<X1Mouse>", '<C-o>+', { desc = "Cursor prev" })
map("i", "<X2Mouse>", '<C-I>+', { desc = "Cursor next" })

map('n', '<Leader>dr', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'Rename symbol (LSP)' })

-- Tab to indent in visual mode and keep selection
map("v", "<Tab>", ">gv", { noremap = true, silent = true })
map("v", "<S-Tab>", "<gv", { noremap = true, silent = true })
map("n", "<Tab>", "<cmd>b#<CR>", { noremap = true, silent = true })

-- Keymaps for subword movement
map("n", "<C-A-Right>", function() functions.move_by_sub_word("right") end, { silent = true })
map("n", "<C-A-Left>",  function() functions.move_by_sub_word("left") end,  { silent = true })
map("n", "<C-Right>", function() functions.move_by_word("right") end, { silent = true })
map("n", "<C-Left>", function() functions.move_by_word("left") end, { silent = true })



map('n', '<F12>', vim.lsp.buf.definition)
map('n', '<F11>', functions.telescope.lsp_references)

-- removal
map('n', '<leader>d', '\"_d', { noremap = true })
-- map('n', '<leader>dd', '\"_dd', { noremap = true })

-- renaming 
map('n', '<F2>', ':%s/\\<<C-r><C-w>\\>//g<Left><Left>', { noremap = true })
map('v', '<F2>', function()
    -- Yank visual selection into register h
    vim.cmd('normal! "hy')
    -- Pre-fill the substitute command, put cursor before the last //
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(':%s/<C-r>h//gc<Left><Left><Left>', true, false, true),
        'c',
        false
    )
end, { noremap = true, silent = false })

return M
