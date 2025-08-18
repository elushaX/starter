-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 
---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = "vscode_dark",

    hl_override = {
        Comment = {
            italic = true
        },
        ["@comment"] = {
            italic = true
        }
    }
}

M.nvdash = {
    load_on_startup = false
}

M.ui = {
	tabufline = {
		enabled = false,
		lazyload = false,
	},
	statusline = {
		theme = "vscode",
	},
}


if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0.04
  vim.g.neovide_cursor_trail_size = 0

  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 20
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 19
  vim.g.neovide_floating_corner_radius = 4
  vim.g.neovide_scale_factor = 0.8
    -- " Put anything you want to happen only in Neovide here"
end

return M
