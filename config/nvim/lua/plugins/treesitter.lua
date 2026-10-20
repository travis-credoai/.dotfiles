return {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  -- pinned so every machine runs the API config/treesitter.lua is written for
  branch = "main",
  lazy = false, -- main does not support lazy-loading
  build = ":TSUpdate",
}
