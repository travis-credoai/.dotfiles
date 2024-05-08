vim.api.nvim_buf_set_var(0, "ale_fix_on_save", 1)
vim.api.nvim_buf_set_var(0, "ale_fixers", {
  "remove_trailing_lines",
  "trim_whitespace",
  "prettier",
})
