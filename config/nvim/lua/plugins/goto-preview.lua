return {
  "rmagatti/goto-preview",
  enabled = true,
  dependencies = { "rmagatti/logger.nvim" },
  event = "BufEnter",
  config = function()
    require("goto-preview").setup({
      default_mappings = true
    })
  end,
}
