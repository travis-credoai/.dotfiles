vim.opt_local.commentstring = "// %s"
vim.opt_local.expandtab = true

-- fixers
vim.b.ale_fixers = {
  "remove_trailing_lines",
  "trim_whitespace",
}
vim.b.ale_fix_on_save = 1
