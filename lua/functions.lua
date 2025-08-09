local M = {}

M.telescope = require("telescope.builtin")

function M.SwitchBuffer()
  local settings = {
    layout_strategy = "center",
    sort_lastused = true,
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

return M