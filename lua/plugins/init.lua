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
}, {"williamboman/mason.nvim"}, {"williamboman/mason-lspconfig.nvim"}, {
    "neovim/nvim-lspconfig",
    config = function()
        local lsp = require("lspconfig")
        lsp.clangd.setup {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            cmd = {"clangd", "--background-index", "--clang-tidy", "--header-insertion=never"}
        }
    end
}, {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        ensure_installed = {"vim", "lua", "vimdoc", "c", "cpp", "cmake", "bash", "python", "lua", "html", "css"},
        highlight = { enable = true },
        indent = { enable = true },
    }
}}
-- { import = "nvchad.blink.lazyspec" }, -- test new blink
