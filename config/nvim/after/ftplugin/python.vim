set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
set fileformat=unix

let b:ale_fixers = ['black', 'remove_trailing_lines', 'trim_whitespace']
let b:ale_fix_on_save = 1

set omnifunc=v:lua.vim.lsp.omnifunc()

let b:ale_python_auto_pipenv = 1
let b:ale_python_auto_poetry = 1
let b:ale_python_auto_virtualenv = 1
let b:ale_python_flake8_auto_pipenv = 1
let b:ale_python_flake8_auto_poetry = 1
