" https://github.com/dense-analysis/ale/blob/master/supported-tools.md
let b:ale_linters = ['terraform_ls']
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']
let b:ale_fix_on_save = 1
setlocal commentstring=#\ %s
