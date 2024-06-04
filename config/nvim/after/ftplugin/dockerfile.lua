vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.textwidth = 0
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.fileformat = 'unix'


vim.b.ale_linters = {'hadolint'}
vim.b.ale_fixers = {'prettier', 'remove_trailing_lines', 'trim_whitespace'}
vim.b.ale_fix_on_save = 1
