vim.o.tabstop=2
vim.o.softtabstop=2
vim.o.shiftwidth=2
vim.g.is_posix=1

vim.api.nvim_buf_set_var(0, "ale_fixers", {
  "remove_trailing_lines",
  "trim_whitespace",
  "mix_format"})

vim.api.nvim_buf_set_var(0, "ale_fix_on_save", 1)
