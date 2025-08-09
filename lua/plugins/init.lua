return {{
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform"
}, {
    "neovim/nvim-lspconfig",
    config = function()
        require "configs.lspconfig"
    end
}, {
    lazy = false,
    "NvChad/nvterm", -- to toggle terminal
    config = function()
        require("configs.nvterm")
    end
}, {
    'nvim-telescope/telescope.nvim',
    dependencies = {'nvim-lua/plenary.nvim'},
    opts = function()
        return require "configs.telescope"
    end
}, {
    "nvim-tree/nvim-tree.lua",
    cmd = {"NvimTreeToggle", "NvimTreeFocus"},
    opts = function()
        return require "configs.nvimtree"
    end
} -- { import = "nvchad.blink.lazyspec" }, -- test new blink
-- {
-- 	"nvim-treesitter/nvim-treesitter",
-- 	opts = {
-- 		ensure_installed = {
-- 			"vim", "lua", "vimdoc",
--      "html", "css"
-- 		},
-- 	},
-- },
}
