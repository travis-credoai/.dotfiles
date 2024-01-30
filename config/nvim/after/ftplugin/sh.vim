set tabstop=4
set softtabstop=4
set shiftwidth=4

let b:ale_fix_on_save = 1
let b:ale_fixers = [
\ 'remove_trailing_lines',
\ 'trim_whitespace',
\ 'shfmt',
\]
let b:ale_linters = [
\ 'shellcheck',
\]

let b:ale_sh_shellcheck_change_directory=0
