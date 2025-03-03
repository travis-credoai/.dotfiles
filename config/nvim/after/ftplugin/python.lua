-- vim options
vim.o.tabstop=4
vim.o.softtabstop=4
vim.o.shiftwidth=4
vim.o.textwidth=0
vim.o.expandtab=true
vim.o.autoindent=true

-- env
vim.b.ale_python_auto_pipenv = 1
vim.b.ale_python_auto_poetry = 1
vim.b.ale_python_auto_virtualenv = 1
vim.b.ale_python_flake8_auto_pipenv = 1
vim.b.ale_python_flake8_auto_poetry = 1
vim.b.ale_python_mypy_auto_poetry = 1
vim.b.ale_python_mypy_executable = "poetry"
vim.g.SimpylFold_docstring_preview = 1
vim.g.SimpylFold_fold_import = 0


-- linters
vim.b.ale_linters = {}

-- fixers
vim.b.ale_fixers = {
  "remove_trailing_lines",
  "trim_whitespace",
}
vim.b.ale_fix_on_save = 1
