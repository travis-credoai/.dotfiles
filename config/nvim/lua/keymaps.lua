local util = require('util')

vim.g.mapleader = ','

-- folding
util.key_mapper('n', '<space>', 'za')
vim.g.SimpylFold_docstring_preview=1

-- navigation
key_mapper('n', '<c-h>', '<c-w><c-h>')
key_mapper('n', '<c-j>', '<c-w><c-j>')
key_mapper('n', '<c-k>', '<c-w><c-k>')
key_mapper('n', '<c-l>', '<c-w><c-l>')
key_mapper('n', '<leader><space>', ':set nohlsearch<CR>')
key_mapper('n', '<leader>rf', '<cmd>lua vim.lsp.buf.rename()<CR>')
key_mapper('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
key_mapper('n', '<leader>ds', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
key_mapper('n', '<leader>d[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
key_mapper('n', '<leader>d]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
key_mapper('n', '<leader>dd', '<cmd>lua vim.diagnostic.setloclist()<CR>')
key_mapper('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>')
key_mapper('n', '<leader>nf', ':NERDTreeFind<CR>')
key_mapper('n', '<leader>nh', ':NERDTreeFocus<CR>')
key_mapper('n', '<leader>nt', ':NERDTreeToggle<CR>')
key_mapper('n', '<leader>w', ':w<CR>')
key_mapper('n', '<leader>w-', ':set nowrap<CR>')
key_mapper('n', '<leader>w=', ':set wrap<CR>')
key_mapper('n', '<leader>oo', ':only<CR>')
key_mapper('n', '<leader>=', ':wincmd =<CR>')

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
