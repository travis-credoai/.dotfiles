return {
  {
    "Equilibris/nx.nvim",
    enabled = false,

    dependencies = {
      "nvim-telescope/telescope.nvim",
    },

    opts  = {
      -- See below for config options
      nx_cmd_root = "npm nx",
    },

    -- Plugin will load when you use these keys
    keys = {
      { "<leader>nx", "<cmd>Telescope nx actions<CR>", desc = "nx actions"}
    },
  },
}
