return {
     -- amongst your other plugins
     {
          'akinsho/toggleterm.nvim',
          version = '*',
          opts = {
               size = function(term)
                    if term.direction == 'horizontal' then
                         return 30
                    elseif term.direction == 'vertical' then
                         return vim.o.columns * 0.4
                    end
               end,
               direction = 'vertical',
               open_mapping = [[<c-\>]],
               hide_numbers = true,
          },
     },
}
