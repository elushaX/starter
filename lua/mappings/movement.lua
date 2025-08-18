
local map = vim.keymap.set

function move_right_word() functions.move_by_sub_word("left") end
function move_left_word() functions.move_by_sub_word("right") end
function move_right_sub_word() functions.move_by_word("right") end
function move_left_sub_word() functions.move_by_word("left") end

map("n", "<A-Left>", '<C-o>+', { desc = "Cursor prev" })
map("n", "<A-Right>", '<C-I>+', { desc = "Cursor next" })
map("i", "<A-Left>", '<C-o>+', { desc = "Cursor prev" })
map("i", "<A-Right>", '<C-I>+', { desc = "Cursor next" })

map("n", "<X1Mouse>", '<C-o>+', { desc = "Cursor prev" })
map("n", "<X2Mouse>", '<C-I>+', { desc = "Cursor next" })
map("i", "<X1Mouse>", '<C-o>+', { desc = "Cursor prev" })
map("i", "<X2Mouse>", '<C-I>+', { desc = "Cursor next" })

map("n", "<C-A-Right>", move_right_word, { silent = true })
map("n", "<C-A-Left>",  move_left_word,  { silent = true })
map("n", "<C-Right>", move_right_sub_word, { silent = true })
map("n", "<C-Left>", move_left_sub_word, { silent = true })
