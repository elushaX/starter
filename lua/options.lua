require "nvchad.options"

local o = vim.o

o.mouse = "a" -- resize windows with mouse etc

-- Enable showing invisible characters (tabs, trailing spaces, etc.)
o.list = true

-- Define how invisible characters are displayed:
--   tab: Display tabs with 2 spaces and ⸗ symbol
--   trail: Show trailing spaces as ·
--   extends/precedes: Show line continuation markers
--   space: Show normal spaces as · (when 'list' is enabled)
o.listchars = "tab:  ⸗,trail:·,extends:>,precedes:<,space:·"

-- Use system clipboard for all yank/paste operations:
--   unnamedplus: Use + register (X11 clipboard)
--   unnamed: Use * register (X11 primary selection)
o.clipboard = "unnamedplus,unnamed"

-- Allow hiding modified buffers without saving (don't force :w before switching buffers)
o.hidden = true

-- Show line numbers
o.number = true

-- Number of spaces to use for each step of (auto)indent
o.shiftwidth = 2

-- Number of spaces that a <Tab> counts for
o.tabstop = 2

-- Minimum number of lines to keep above/below cursor (large number centers cursor)
o.scrolloff = 100000

-- Remember this many commands in history
o.history = 1000

-- Enable enhanced command-line completion
o.wildmenu = true

-- Completion mode for command-line:
--   list: show all matches
--   longest: complete to longest common string
o.wildmode = "list:longest"

-- fixme o.shm:append("I")  -- Disable greetings
-- fixme : o.nobackup = true
-- fixme o.nowrap = true
-- o.relativenumber = true
-- o.expandtab = true

-- Highlighting
vim.cmd([[
  hi SpecialKey ctermfg=darkgray guifg=gray70
  syntax on
  filetype on
  filetype plugin on
  filetype indent on
]])