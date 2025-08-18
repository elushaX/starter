require "nvchad.mappings"

local functions = require('functions')

local builtin = require("telescope.builtin")
local utils = require("telescope.utils")

local Path = require('plenary.path')

local map = vim.keymap.set

local telescope = require('telescope.builtin')

local function oldfiles_in_cwd()
  telescope.oldfiles({
    cwd_only = true,  -- Only show files in the current working directory
    cwd = vim.fn.getcwd(),  -- Explicitly set to current directory
  })
end

function live_grep() builtin.live_grep({ cwd = utils.buffer_dir() }) end

function rename()
    -- Yank visual selection into register h
    vim.cmd('normal! "hy')
    -- Pre-fill the substitute command, put cursor before the last //
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(':%s/<C-r>h//gc<Left><Left><Left>', true, false, true),
        'c',
        false
    )
end

function file_explorer()
	require("telescope").extensions.file_browser.file_browser()
end

local rename_cmd = ':%s/\\<<C-r><C-w>\\>//g<Left><Left>'

-- Map the custom picker (e.g., to <Leader>fo)
--
map("n", "<Leader><Leader>", ":nohlsearch<CR>", { desc = "clear search highlighting" })

map('n', '<Leader>fo', oldfiles_in_cwd, { desc = '[F]ind [O]ld files in CWD' })
map("n", "<Leader>tt", "<cmd>Telescope<CR>", { desc = "open telescope" })
map("n", "<Leader>ll", "<cmd>lua require('persistence').load({ last = true })<cr>", { desc = "load last session" })
map("n", "<Leader>ld", "<cmd>lua BuffersDelete()<cr>", { desc = "clear current session" })
map("n", "<Leader>sa", "<cmd>wa<cr>", { desc = "save all files" })
map("n", "<Leader>ss", "<cmd>w<cr>", { desc = "save file" })
map("n", "<Leader>sq", "<cmd>wqa<cr>", { desc = "save all files and quit" })
map("n", "<Leader>sd", "<cmd>bd<cr>", { desc = "close current buffer" })
map("n", "<Leader>ee", "<cmd>lua NVTreeToggleBufferView()<cr>", { desc = "show open tabs in nvtree" })
map("n", "<Leader>cc", ":ClangdSwitchSourceHeader<CR>", { desc = "switch source/header" })
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fw", live_grep, { desc = "Find buffers" })
map("n", "<Leader>df", ":Format<CR>", { desc = "format file" })
map('n', '<Leader>dr', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'Rename symbol (LSP)' })
map("n", "<leader>fe", file_explorer)


map('n', '<F12>', vim.lsp.buf.definition)
map('n', '<F11>', functions.telescope.lsp_references)
map('n', '<F12>', vim.lsp.buf.definition) 
map('n', '<F2>', rename_cmd, { noremap = true })
map('v', '<F2>', rename,  { noremap = true, silent = false })

map("n", "t", functions.SwitchBuffer, { desc = "switch buffer" })
map("n", "<C-Tab>.", functions.SwitchBuffer, { desc = "switch buffer" })

map("n", "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "fzf in file" })
map("n", "<S-h>", functions.ToggleZenMode, { desc = "Toggle all UI elements (mode, ruler, statusline)" })

map("n", "qq", ":bdelete<CR>", { desc = "Close current buffer" })


-- Basic Editing

vim.cmd([[
  nnoremap d <Nop>
  nnoremap x <Nop>
  nnoremap p <Nop>
  nnoremap P <Nop>

  nnoremap u <Nop>
  nnoremap <C-q> <Nop> -- fixme


  nnoremap <Tab> >>
  nnoremap <S-Tab> <<

  nnoremap <C-1> :echo "Action 1"<CR>
]])

map("n", ";", ":", { desc = "Enter command mode" })
map('n', 'a', 'i')
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map('i', '<C-d>', '<Esc><Right>')

-- history
map("n", "<C-z>", 'u', { desc = "undo", noremap = true, silent = true })
map("n", "<C-r>", '<C-r>', { desc = "redo", noremap = true, silent = true })


return M
