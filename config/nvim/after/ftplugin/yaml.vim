set tabstop=2
set softtabstop=2
set shiftwidth=2

let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace', 'yamlfmt']
let b:ale_linters = ['yamllint']
let b:ale_fix_on_save = 1
