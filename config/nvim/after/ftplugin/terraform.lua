-- https://github.com/dense-analysis/ale/blob/master/supported-tools.md
vim.b.ale_linters = {'terraform_ls'}
vim.b.ale_fixers = {'remove_trailing_lines', 'trim_whitespace'}
vim.b.ale_fix_on_save = 1
vim.opt_local.commentstring="# %s"
