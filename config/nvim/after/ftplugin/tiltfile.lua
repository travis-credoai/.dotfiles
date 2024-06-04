vim.opt_local.tabstop=2
vim.opt_local.softtabstop=2
vim.opt_local.shiftwidth=2
vim.opt_local.commentstring="# %s"

-- fixers
vim.b.ale_fixers = {
  "remove_trailing_lines",
  "trim_whitespace",
}
vim.b.ale_fix_on_save = 1
