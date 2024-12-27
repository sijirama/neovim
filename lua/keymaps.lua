local map = vim.api.nvim_set_keymap
local set = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--navigate buffers
map('n', '<S-l>', ':bnext<CR>', opts)
map('n', '<S-h>', ':bprevious<CR>', opts)
map('n', '<leader>q', ':q<CR>', opts)
map('n', '<leader>qq', ':q!<CR>', opts)

--NOTE: insert mode
map('i', 'jk', '<ESC>', opts)

vim.api.nvim_set_keymap('n', '<A-Right>', ':lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-Left>', ':lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-Down>', ':cnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-Up>', ':cprev<CR>', { noremap = true, silent = true })

--nvim tree stuff
map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
map('n', '<leader>fe', ':NvimTreeFocus<CR>', opts)
map('n', '<leader>ef', ':NvimTreeCollapse<CR>', opts)

--toggle terminal
vim.keymap.set('n', '<leader>t', ':ToggleTerm direction=float dir=. <CR>', opts)

--toggle navbuddy
local navbuddy = require 'nvim-navbuddy'
vim.keymap.set('n', '<leader>a', navbuddy.open)

function _G.set_terminal_keymaps()
     local opts = { buffer = 0 }
     vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
     vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
     vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
     vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
     vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
     vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
     vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

--NOTE: format code
vim.api.nvim_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
     desc = 'Highlight when yanking (copying) text',
     group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
     callback = function()
          vim.highlight.on_yank()
     end,
})
