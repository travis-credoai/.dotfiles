vim.b.ale_fix_on_save = 1
vim.opt_local.commentstring = '# %s'

vim.b.ale_fixers = {
  'remove_trailing_lines',
  'trim_whitespace',
  'terraform',
}
