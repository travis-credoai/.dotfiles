-- keymaps
----------

local key_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end

vim.g.mapleader = ','

-- folding
key_mapper('n', '<space>', 'za')

-- navigation
key_mapper('n', '<leader>w', ':w<CR>')
key_mapper('n', '<leader><space>', ':set nohlsearch<CR>')
key_mapper('n', '<leader>w-', ':set nowrap<CR>')
key_mapper('n', '<leader>w=', ':set wrap<CR>')
key_mapper('n', '<leader>nt', ':NERDTreeToggle<CR>')
key_mapper('n', '<leader>nf', ':NERDTreeFind<CR>')
key_mapper('n', '<leader>nh', ':NERDTreeFocus<CR>')
key_mapper('n', '<c-j>', '<c-w><c-j>')
key_mapper('n', '<c-k>', '<c-w><c-k>')
key_mapper('n', '<c-l>', '<c-w><c-l>')
key_mapper('n', '<c-h>', '<c-w><c-h>')
key_mapper('n', '<leader>w=', ':set wrap<CR>')
key_mapper('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>')
key_mapper('n', '<leader>d[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
key_mapper('n', '<leader>d]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
key_mapper('n', '<leader>dd', '<cmd>lua vim.diagnostic.setloclist()<CR>')
vim.g.SimpylFold_docstring_preview=1
vim.g.NERDTreeWinSize=35
vim.g.NERDTreeAutoCenter=1
vim.cmd([[
  let NERDTreeIgnore=['\~$', '\.pyc$', '__pycache__$', '.egg-info$']
]])
vim.g.NERDTreeDirArrowExpandable=''
vim.g.NERDTreeDirArrowCollapsible=''
vim.g.ctrlp_cmd = 'CtrlPBuffer'
vim.g.UltiSnipsExpandTrigger = '<C-J>'
vim.g.UltiSnipsJumpForwardTrigger = '<c-j>'
vim.g.UltiSnipsJumpBackwardTrigger = '<c-k>'
key_mapper('n', '<c-f>', ':CtrlP<CR>')
