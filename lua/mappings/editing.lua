local map = vim.keymap.set

vim.cmd([[
  nnoremap d <Nop>
  nnoremap x <Nop>
  nnoremap p <Nop>
  nnoremap P <Nop>

  nnoremap <Tab> >>
  nnoremap <S-Tab> <<
]])

function remove_word_left() vim.cmd('normal! "_db') end
function remove_word_right() vim.cmd('normal! "_dw') end

map("n", "<Enter>", "i<Enter><Esc>", { desc = "Insert new line below" })
map("v", "<Tab>", ">gv", {desc = "indent", noremap = true, silent = true })
map("v", "<S-Tab>", "<gv", {desc = "unindent", noremap = true, silent = true })
map('n', '<C-Enter>', 'o<Esc>==', { desc = "new line after", noremap = true, silent = true })
map('i', '<C-Enter>', '<Esc>o', { desc = "new line after", noremap = true, silent = true })
map("n", "<A-Up>", ":m-2<CR>==", { desc = "Move current line up" })
map("i", "<A-Up>", "<Esc>:m-2<CR>==gi", { desc = "Move current line up (insert mode)" })
map("n", "<A-Down>", ":m+<CR>==", { desc = "Move current line down" })
map("i", "<A-Down>", "<Esc>:m+<CR>==gi", { desc = "Move current line down (insert mode)" })
map("x", "<M-Up>", ":move '<-2<CR>gv=gv", { desc = "Move selected block up" })
map("x", "<M-Down>", ":move '>+<CR>gv=gv", { desc = "Move selected block down" })


for _, mode in ipairs({'n', 'v', 'i'}) do
  map(mode, '<BS>', '"_X', { noremap = true, silent = true })
  map(mode, '<C-BS>', remove_word_left, { noremap = true, silent = true })

  map(mode, '<Del>', '"_x', { noremap = true, silent = true })
  map(mode, '<C-Del>', remove_word_right, { noremap = true, silent = true })
end

map("n", "<C-d>", '"_dd', { noremap = true, silent = true })
map("n", "<C-v>", '"+P', { desc = "Paste from clipboard" })
map("n", "<C-x>", 'V"+d', { noremap = true, silent = true })
map("v", "<C-c>", '"+y', { desc = "Copy selection to clipboard" })
map("v", "<C-x>", '"+d', { desc = "Cut selection to clipboard" })
map("i", "<C-v>", '<C-r>+', { desc = "Paste from clipboard" })
map("t", "<C-v>", "<C-\\><C-n>\"+P", { desc = "Paste in terminal mode" })
