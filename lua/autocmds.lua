require "nvchad.autocmds"

-- Autocommands
local remember_folds = vim.api.nvim_create_augroup("remember_folds", { clear = true })
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "*",
  callback = function() vim.cmd("silent! mkview") end,
  group = remember_folds,
  desc = "Save folds when leaving buffer"
})
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function() vim.cmd("silent! loadview") end,
  group = remember_folds,
  desc = "Load folds when entering buffer"
})