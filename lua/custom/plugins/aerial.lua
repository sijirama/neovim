vim.keymap.set('n', '<leader>aa', '<cmd>AerialToggle!<CR>')

return {
     'stevearc/aerial.nvim',
     opts = {},
     -- Optional dependencies
     dependencies = {
          'nvim-treesitter/nvim-treesitter',
          'nvim-tree/nvim-web-devicons',
     },
     config = function()
          require('aerial').setup {
               backends = { 'treesitter', 'lsp', 'markdown', 'asciidoc', 'man' },
               highlight_on_hover = true,
               autojump = true,
               layout = {
                    max_width = { 80, 0.2 },
                    width = nil,
                    min_width = 60,
               },
          }
     end,
}
