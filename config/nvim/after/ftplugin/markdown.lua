vim.api.nvim_buf_set_var(0, "ale_fix_on_save", 1)
vim.api.nvim_buf_set_var(0, "ale_fixers", {
  "remove_trailing_lines",
  "trim_whitespace",
  "prettier",
})

vim.api.nvim_create_autocmd( 'FileType', { pattern = 'markdown',
callback = function(args)
  vim.treesitter.start(args.buf, 'markdown')
  vim.bo[args.buf].syntax = 'on'  -- only if additional legacy syntax is needed
end
})
