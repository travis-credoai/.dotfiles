vim.o.tabstop=4
vim.o.softtabstop=4
vim.o.shiftwidth=4
vim.g.is_posix=1

vim.api.nvim_buf_set_var(0, "ale_fixers", {
  "remove_trailing_lines",
  "trim_whitespace",
  "shfmt"})

vim.api.nvim_buf_set_var(0, "ale_linters", {"shellcheck"})

vim.api.nvim_buf_set_var(0, "ale_fix_on_save", 1)
vim.api.nvim_buf_set_var(0, "ale_sh_shellcheck_change_directory", 0)
