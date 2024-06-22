vim.o.tabstop=2
vim.o.softtabstop=2
vim.o.shiftwidth=2

vim.b.ale_fixers = {
  "remove_trailing_lines",
  "trim_whitespace",
  "yamlfmt"
}

vim.b.ale_linters = {"yamllint"}

vim.b.ale_fix_on_save = 1
