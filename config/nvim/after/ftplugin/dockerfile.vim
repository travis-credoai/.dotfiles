set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set fileformat=unix

let b:ale_linters = ['hadolint']
let b:ale_fixers = ['prettier', 'remove_trailing_lines', 'trim_whitespace']
let b:ale_fix_on_save = 1
