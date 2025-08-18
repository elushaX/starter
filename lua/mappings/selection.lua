local map = vim.keymap.set

map("n", "<C-a>", "ggVG", { desc = "Select all content" })
map("v", "<C-a>", "ggVG", { desc = "Select all content" })
map("i", "<C-a>", "<Esc>ggVG", { desc = "Select all content" })
