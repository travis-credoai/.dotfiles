return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local custom = require'plugins.lualine.slanted-gaps'

    require('lualine').setup {
      options = custom.options,
      sections = custom.sections,
      inactive_sections = custom.inactive_sections,
    }
  end,
}
