return {
  'milanglacier/minuet-ai.nvim',
  lazy = false,
  config = function()
    local function env_key(name)
      local env_path = vim.fn.stdpath 'config' .. '/.env'
      local lines = vim.fn.filereadable(env_path) == 1 and vim.fn.readfile(env_path) or {}

      for _, line in ipairs(lines) do
        local key, value = line:match '^%s*([%w_]+)%s*=%s*(.-)%s*$'
        if key == name then
          return (value:gsub('^["\'](.*)["\']$', '%1'))
        end
      end

      return vim.env[name]
    end

    require('minuet').setup {
      provider = 'gemini',
      request_timeout = 3,
      throttle = 1500,
      debounce = 600,
      cmp = {
        enable_auto_complete = false,
      },
      provider_options = {
        gemini = {
          model = 'gemini-3.5-flash',
          api_key = function()
            return env_key 'GEMINI_API_KEY'
          end,
          optional = {
            generationConfig = {
              maxOutputTokens = 256,
            },
          },
        },
      },
    }
  end,
}
