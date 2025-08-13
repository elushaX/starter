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
}, {
    "williamboman/mason.nvim", -- checks for packages on system
    ensure_installed = {"clangd", "clang-format"}
}, {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                c = {"clang_format"},
                cpp = {"clang_format"}
            },
            formatters = {
                clang_format = {
                    -- args = {"--style=file"} -- Use .clang-format file in project
                }
            }
        })
    end

}, {
    "neovim/nvim-lspconfig",
    config = function()
        local lsp = require("lspconfig")
        lsp.clangd.setup {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            cmd = {"clangd", "--background-index", "--clang-tidy", "--header-insertion=never"}
        }
    end
}, {
  'ldelossa/calltree.nvim',
  lazy = false
}, {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = { -- Example mapping to toggle outline
    { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
  },
  opts = {
    -- Your setup opts here
  },
}, {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        ensure_installed = {"vim", "lua", "vimdoc", "c", "cpp", "cmake", "bash", "python", "lua", "html", "css"},
        highlight = {
            enable = true
        },
        indent = {
            enable = true
        }
    },
    config = function()
      require("configs.treesitter")
    end
},
{
  "gbprod/yanky.nvim",
  lazy = false, 
  opts = { 
    highlight = {
      on_put = false,
      on_yank = false,
      timer = 0,
    },
  },
  dependencies = { "folke/snacks.nvim" },
  keys = {
    {
      "<leader>p",
      function()
          Snacks.picker.yanky()
      end,
      mode = { "n", "x" },
      desc = "Open Yank History",
    },
  }
},
{
    "RRethy/vim-illuminate",
    lazy = false,
    config = function()
        require('illuminate').configure({
            delay = 0,
            filetypes_denylist = { "NvimTree", "TelescopePrompt" }
        })
    end
}, 
{"williamboman/mason-lspconfig.nvim"} }
-- { import = "nvchad.blink.lazyspec" }, -- test new blink
