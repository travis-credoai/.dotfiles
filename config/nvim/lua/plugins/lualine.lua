return {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local custom = require'plugins.lualine.slanted-gaps'

    require('lualine').setup {
      options = custom.options,
      sections = custom.sections,
      inactive_sections = custom.inactive_sections,
      extensions = {'fugitive', 'nerdtree', 'lazy', 'quickfix', 'toggleterm', 'trouble'}
    }
  end,
}
