
local map = vim.keymap.set

function move_right_word() vim.cmd("normal! w") end
function move_left_word() vim.cmd("normal! b") end
function move_right_sub_word() vim.cmd("normal! w") end
function move_left_sub_word() vim.cmd("normal! b") end

map("n", "<A-Left>", '<C-o>+', { desc = "Cursor prev" })
map("n", "<A-Right>", '<C-I>+', { desc = "Cursor next" })
map("i", "<A-Left>", '<C-o>+', { desc = "Cursor prev" })
map("i", "<A-Right>", '<C-I>+', { desc = "Cursor next" })

map("n", "<X1Mouse>", '<C-o>+', { desc = "Cursor prev" })
map("n", "<X2Mouse>", '<C-I>+', { desc = "Cursor next" })
map("i", "<X1Mouse>", '<C-o>+', { desc = "Cursor prev" })
map("i", "<X2Mouse>", '<C-I>+', { desc = "Cursor next" })

for _, mode in ipairs({'n', 'v', 'i'}) do
  map(mode, "<C-A-Right>", move_right_word, { silent = true })
  map(mode, "<C-A-Left>", move_left_word, { silent = true })
  map(mode, "<C-Right>", move_right_sub_word, { silent = true })
  map(mode, "<C-Left>", move_left_sub_word, { silent = true })
end
