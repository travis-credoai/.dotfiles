set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
set fileformat=unix

let b:ale_fixers = ['black', 'remove_trailing_lines', 'trim_whitespace']
let b:ale_fix_on_save = 0

set omnifunc=v:lua.vim.lsp.omnifunc()

set b:ale_virtualenv_dir_names = ['~/.virtualenvs', '~/.virtualenvs/py3']
