-- mappings.lua or any lua file
local M = {}

-- Example menu items
local menu_items = {
  { label = "Say Hello", action = function() print("Hello!") end },
  { label = "Current Line", action = function() print(vim.fn.getline(".")) end },
  { label = "Delete Line", action = function() vim.cmd("normal! dd") end },
}

local current_index = 1
local menu_buf, menu_win

local function render_menu()
  if not vim.api.nvim_buf_is_valid(menu_buf) then return end
  local lines = {}
  for i, item in ipairs(menu_items) do
    if i == current_index then
      table.insert(lines, "> " .. item.label)
    else
      table.insert(lines, "  " .. item.label)
    end
  end
  vim.api.nvim_buf_set_lines(menu_buf, 0, -1, false, lines)
end

local function open_menu()
  current_index = 1
  menu_buf = vim.api.nvim_create_buf(false, true)

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local opts = {
    relative = "cursor",
    row = 1,
    col = 0,
    width = 30,
    height = #menu_items,
    style = "minimal",
    border = "rounded",
  }

  menu_win = vim.api.nvim_open_win(menu_buf, true, opts)

  vim.api.nvim_buf_set_keymap(menu_buf, "n", "<Down>", "", {
    nowait = true,
    noremap = true,
    callback = function()
      current_index = current_index + 1
      if current_index > #menu_items then current_index = 1 end
      render_menu()
    end,
  })

  vim.api.nvim_buf_set_keymap(menu_buf, "n", "<Up>", "", {
    nowait = true,
    noremap = true,
    callback = function()
      current_index = current_index - 1
      if current_index < 1 then current_index = #menu_items end
      render_menu()
    end,
  })

  vim.api.nvim_buf_set_keymap(menu_buf, "n", "<CR>", "", {
    nowait = true,
    noremap = true,
    callback = function()
      menu_items[current_index].action()
      vim.api.nvim_win_close(menu_win, true)
    end,
  })

  vim.api.nvim_buf_set_keymap(menu_buf, "n", "<Esc>", "", {
    nowait = true,
    noremap = true,
    callback = function()
      vim.api.nvim_win_close(menu_win, true)
    end,
  })

  render_menu()
end

-- Alt+Enter to open menu
vim.keymap.set("n", "<M-CR>", open_menu, { noremap = true, silent = true })

return M

