-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

require 'options'
require 'keymaps'
require 'bootstrap'
require 'plugins'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- dev plugins
-- package.path = package.path .. ';/home/sijirama/Desktop/me/coder/sweep.nvim/lua/?.lua'
-- package.path = package.path .. ';/home/sijirama/Desktop/me/coder/sweep.nvim/lua/?/init.lua'
-- vim.opt.runtimepath:append '/home/sijirama/Desktop/me/coder/sweep.nvim'

-- require('sweep').setup {
--      debounce_delay = 2000,
--      prediction_timeout = 60000,
--      statusline = true,
--      debug = true,
-- }
