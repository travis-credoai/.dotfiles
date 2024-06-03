-- vim options
vim.o.tabstop=4
vim.o.softtabstop=4
vim.o.shiftwidth=4
vim.o.textwidth=0
vim.o.expandtab=true
vim.o.autoindent=true

-- env
vim.api.nvim_buf_set_var(0, "ale_python_auto_pipenv", 1)
vim.api.nvim_buf_set_var(0, "ale_python_auto_poetry", 1)
vim.api.nvim_buf_set_var(0, "ale_python_auto_virtualenv", 1)
vim.api.nvim_buf_set_var(0, "ale_python_flake8_auto_pipenv", 1)
vim.api.nvim_buf_set_var(0, "ale_python_flake8_auto_poetry", 1)
vim.api.nvim_buf_set_var(0, "ale_python_mypy_auto_poetry", 1)
vim.api.nvim_buf_set_var(0, "ale_python_mypy_executable", "poetry")

-- linters
vim.api.nvim_buf_set_var(0, "ale_linters", {})

-- fixers
vim.api.nvim_buf_set_var(0, "ale_fixers", {
  "remove_trailing_lines",
  "trim_whitespace",
})
vim.api.nvim_buf_set_var(0, "ale_fix_on_save", 1)
