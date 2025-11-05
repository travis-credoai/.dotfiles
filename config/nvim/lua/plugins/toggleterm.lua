return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup()
    
    -- Create a Lua terminal
    local Terminal = require('toggleterm.terminal').Terminal
    local lua_repl = Terminal:new({
      cmd = "lua",
      direction = "horizontal",
      close_on_exit = false,
    })
    
    vim.keymap.set("n", "<leader>tl", function() lua_repl:toggle() end)
  end
}
