-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
--    require('gitsigns').setup({ ... })
--
-- See `:help gitsigns` to understand what the configuration keys do
return {
     { -- Adds git related signs to the gutter, as well as utilities for managing changes
          'lewis6991/gitsigns.nvim',
          config = function()
               require('gitsigns').setup()
          end,

          opts = {
               signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked = { text = '┆' },
               },
               on_attach = function(bufnr)
                    local gitsigns = require 'gitsigns'

                    local function map(mode, l, r, opts)
                         opts = opts or {}
                         opts.buffer = bufnr
                         vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                         if vim.wo.diff then
                              vim.cmd.normal { ']c', bang = true }
                         else
                              gitsigns.nav_hunk 'next'
                         end
                    end, { desc = 'Jump to next git [c]hange' })

                    map('n', '[c', function()
                         if vim.wo.diff then
                              vim.cmd.normal { '[c', bang = true }
                         else
                              gitsigns.nav_hunk 'prev'
                         end
                    end, { desc = 'Jump to previous git [c]hange' })
               end,
          },
     },
}
