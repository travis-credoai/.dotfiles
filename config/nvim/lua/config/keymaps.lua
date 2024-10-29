local util = require('lib.util')

vim.g.mapleader = ','

-- folding
util.key_mapper('n', '<space>', 'za')
vim.g.SimpylFold_docstring_preview=1

-- navigation
util.key_mapper('n', '<c-h>', '<c-w><c-h>')
util.key_mapper('n', '<c-j>', '<c-w><c-j>')
util.key_mapper('n', '<c-k>', '<c-w><c-k>')
util.key_mapper('n', '<c-l>', '<c-w><c-l>')
util.key_mapper('n', '<leader><space>', ':set nohlsearch<CR>')
util.key_mapper('n', '<leader>d[', vim.diagnostic.goto_prev)
util.key_mapper('n', '<leader>d]', vim.diagnostic.goto_next)
util.key_mapper('n', '<leader>dd', vim.diagnostic.setloclist)
util.key_mapper('n', '<leader>do', vim.diagnostic.open_float)
util.key_mapper('n', '<leader>nf', ':NERDTreeFind<CR>')
util.key_mapper('n', '<leader>nh', ':NERDTreeFocus<CR>')
util.key_mapper('n', '<leader>nt', ':NERDTreeToggle<CR>')
util.key_mapper('n', '<leader>w', ':w<CR>')
util.key_mapper('n', '<leader>w-', ':set nowrap<CR>')
util.key_mapper('n', '<leader>w=', ':set wrap<CR>')
util.key_mapper('n', '<leader>oo', '<cmd>lua require("util").saveTempSession()<CR>:only<CR>')
util.key_mapper('n', '<leader>O', util.restoreTempSession)
util.key_mapper('n', '<leader>=', ':wincmd =<CR>')

-- Kustomize
util.key_mapper('n', '<leader>kb', ':!kustomize build %:p:h<CR>')

-- NERDTree
vim.g.NERDTreeWinSize=35
vim.g.NERDTreeAutoCenter=1
vim.cmd([[
  let NERDTreeIgnore=['\~$', '\.pyc$', '__pycache__$', '.egg-info$']
]])
vim.g.NERDTreeDirArrowExpandable=''
vim.g.NERDTreeDirArrowCollapsible=''
vim.g.NERDTreeQuitOnOpen=1

-- UltiSnips
vim.g.UltiSnipsExpandTrigger = '<C-J>'
vim.g.UltiSnipsJumpForwardTrigger = '<c-j>'
vim.g.UltiSnipsJumpBackwardTrigger = '<c-k>'

-- CtrlP
vim.g.ctrlp_cmd = 'CtrlPBuffer'
util.key_mapper('n', '<c-f>', ':CtrlP<CR>')

-- Fugitive
util.key_mapper('n', '<leader>Gprb', ':Git pull --rebase<CR>')
