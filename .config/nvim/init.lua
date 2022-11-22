require('plugins')
require('colorbuddy').colorscheme('the-vapors')

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    ensure_installed = { "c", "lua", "rust" },
    auto_install = true,
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
  }
}

require'nvim-treesitter.configs'.setup {
  matchup = {
    enable = true,              -- mandatory, false will disable the whole extension
    disable = { "c", "ruby" },  -- optional, list of language that will be disabled
    -- [options]
  },
}

require'lspconfig'.terraformls.setup{}
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = vim.lsp.buf.formatting_sync,
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
require'lspconfig'.pylsp.setup{
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 100
        }
      }
    }
  }
}

vim.o.showcmd = true
vim.o.lazyredraw = true
vim.o.laststatus = 2
vim.o.noshowmode = true
vim.o.timeoutlen = 2000
vim.o.ttimeoutlen = 100
vim.o.number = false
vim.o.cursorline = true
vim.o.wildmenu = true
vim.o.showmatch = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.clipboard = 'unnamed'
vim.o.tags = './.tags,.tags,./tags,tags'
vim.o.noswapfile = true
vim.o.hidden = true
vim.o.history = 100
vim.o.foldenable = true
vim.o.foldmethod = 'marker'
vim.o.foldlevelstart = 0
vim.o.foldnestmax = 4
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.ambiwidth='single'
vim.o.expandtab = true
vim.o.textwidth=0
vim.wo.signcolumn = 'number'
vim.wo.wrap = false

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
vim.g.SimpylFold_docstring_preview=1
vim.g.NERDTreeWinSize=35
vim.g.NERDTreeAutoCenter=1
-- vim.g.NERDTreeIgnore="['\.pyc$', '^__pycache__$']"
vim.g.NERDTreeDirArrowExpandable=''
vim.g.NERDTreeDirArrowCollapsible=''
vim.g.ctrlp_cmd = 'CtrlPBuffer'
key_mapper('n', '<c-f>', ':CtrlP<CR>')
