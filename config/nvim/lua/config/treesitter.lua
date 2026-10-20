-- treesitter
-------------
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- nvim-treesitter (main branch) only installs parsers and queries. Highlighting
-- is enabled below, and incremental selection is a Neovim default (v_an, v_in).
-- install() is async and a no-op for parsers that are already installed.
require('nvim-treesitter').install {
  "c", "lua", "rust", "yaml", "vim", "python", "dockerfile", "go", "mermaid",
  "markdown", "terraform", "hcl", "typescript", "toml", "css", "html",
  "javascript", "regex", "scss", "svelte", "tsx", "typst", "vue",
}

-- matchup talks to Neovim's treesitter directly; these keep the regex engine
vim.g.matchup_treesitter_disabled = { "c", "ruby" }

local max_filesize = 100 * 1024 -- 100 KB

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter_start", {clear = true}),
  callback = function(event)
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(event.buf))
    if ok and stats and stats.size > max_filesize then
      return
    end
    -- errors when the filetype has no installed parser, which just means no highlighting
    pcall(vim.treesitter.start, event.buf)
  end,
})
