-- treesitter
-------------
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "rust", "yaml", "vim", "python", "dockerfile", "go", "mermaid", "markdown", "terraform", "hcl", "typescript", "toml" },
  auto_install = false,
  highlight = {
    enable = true,
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  matchup = {
    enable = true,              -- mandatory, false will disable the whole extension
    disable = { "c", "ruby" },  -- optional, list of language that will be disabled
    -- [options]
  },
}

-- hack to get tfvars read by treesitter as tf files
vim.treesitter.language.register("terraformls", "terraform-vars")
