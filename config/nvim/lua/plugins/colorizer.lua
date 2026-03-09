return {
  "norcalli/nvim-colorizer.lua",
  enabled = true,
  config = function()
    require("colorizer").setup({ 
      'lua'; 
    }, { mode = 'foreground' })
  end,
}
