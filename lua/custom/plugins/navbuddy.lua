local actions = require 'nvim-navbuddy.actions'

return {
     'SmiteshP/nvim-navbuddy',
     dependencies = {
          'SmiteshP/nvim-navic',
          'MunifTanjim/nui.nvim',
     },
     config = function()
          require('nvim-navbuddy').setup {
               mappings = {
                    ['<Left>'] = actions.parent(), -- Move to left panel
                    ['<Right>'] = actions.children(), -- Move to right panel
                    ['0'] = actions.root(), -- Move to first panel
               },
               lsp = {
                    auto_attach = true,
               },
          }
     end,
}
