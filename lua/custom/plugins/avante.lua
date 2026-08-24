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

return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false,
  build = vim.fn.has 'win32' ~= 0 and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false' or 'make',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'hrsh7th/nvim-cmp',
    'nvim-tree/nvim-web-devicons',
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
  config = function()
    local openai_key = env_key 'OPENAI_API_KEY'
    local gemini_key = env_key 'GEMINI_API_KEY'

    vim.env.OPENAI_API_KEY = openai_key or vim.env.OPENAI_API_KEY
    vim.env.GEMINI_API_KEY = gemini_key or vim.env.GEMINI_API_KEY

    require('avante').setup {
      provider = openai_key and 'openai' or 'gemini',
      auto_suggestions_provider = openai_key and 'openai' or 'gemini',
      behaviour = {
        auto_suggestions = false,
        auto_approve_tool_permissions = false,
      },
      mappings = {
        ask = 'va',
        new_ask = 'vn',
        zen_mode = 'vz',
        edit = 've',
        refresh = 'vr',
        focus = 'vf',
        stop = 'vS',
        select_model = 'v?',
        select_history = 'vh',
        toggle = {
          default = 'vt',
          debug = 'vd',
          selection = 'vC',
          suggestion = 'vs',
          repomap = 'vR',
        },
        files = {
          add_current = 'vc',
          add_all_buffers = 'vB',
        },
        suggestion = {
          accept = '<M-l>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
      providers = {
        openai = {
          endpoint = 'https://api.openai.com/v1',
          model = 'gpt-4.1-mini',
          timeout = 30000,
          extra_request_body = {
            temperature = 0,
            max_completion_tokens = 8192,
          },
        },
        gemini = {
          endpoint = 'https://generativelanguage.googleapis.com/v1beta/models',
          model = 'gemini-3.5-flash',
          timeout = 30000,
          extra_request_body = {
            generationConfig = {
              temperature = 0,
            },
          },
        },
      },
    }

    local function get_suggestion()
      local avante = require 'avante'
      avante._init(vim.api.nvim_get_current_tabpage())
      local _, _, suggestion = avante.get()
      return suggestion
    end

    vim.keymap.set('i', '<M-s>', function()
      get_suggestion():suggest()
    end, { desc = 'Avante: request suggestion', silent = true })

    vim.keymap.set('i', '<M-l>', function()
      get_suggestion():accept()
    end, { desc = 'Avante: accept suggestion', silent = true })

    vim.keymap.set('i', '<M-]>', function()
      get_suggestion():next()
    end, { desc = 'Avante: next suggestion', silent = true })

    vim.keymap.set('i', '<M-[>', function()
      get_suggestion():prev()
    end, { desc = 'Avante: previous suggestion', silent = true })

    vim.keymap.set('i', '<C-]>', function()
      local suggestion = get_suggestion()
      if suggestion:is_visible() then
        suggestion:dismiss()
      end
    end, { desc = 'Avante: dismiss suggestion', silent = true })
  end,
}
