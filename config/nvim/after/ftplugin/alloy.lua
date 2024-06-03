vim.opt_local.commentstring="// %s"

-- fixers
vim.api.nvim_buf_set_var(0, "ale_fixers", {
  "remove_trailing_lines",
  "trim_whitespace",
})
vim.api.nvim_buf_set_var(0, "ale_fix_on_save", 1)
