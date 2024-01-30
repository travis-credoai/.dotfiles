let b:ale_fix_on_save = 1
let b:ale_linters = [
\ { buffer -> { 'command': 'hclfmt' } }
\]
let b:ale_fixers = [
\ 'remove_trailing_lines',
\ 'trim_whitespace',
\ { buffer -> { 'command': 'hclfmt' } }
\]
setlocal commentstring=#\ %s
