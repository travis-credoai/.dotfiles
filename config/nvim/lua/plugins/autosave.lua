return {
  "0x00-ketsu/autosave.nvim",
  enabled = true,
  config = function()
    require("autosave").setup({
      prompt = {
        enable = false,
      },
    })
  end,
}
