require('plugins')
require('colorbuddy').colorscheme('the-vapors')

-- treesitter
-------------

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "rust", "yaml", "vim", "python", "dockerfile", "go", "mermaid", "markdown", "terraform", "hcl", "typescript", "toml" },
  auto_install = false,
  highlight = {
    enable = true,
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  matchup = {
    enable = true,              -- mandatory, false will disable the whole extension
    disable = { "c", "ruby" },  -- optional, list of language that will be disabled
    -- [options]
  },
}

-- hack to get tfvars read by treesitter as tf files
local ft_to_parser = require"nvim-treesitter.parsers".filetype_to_parsername
ft_to_parser["terraform-vars"] = "terraformls"

-- completion
-------------

local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

-- lsp
------
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig = require('lspconfig')
lsputil = require('lspconfig/util')

-- terraform
lspconfig.terraformls.setup{
  capabilities = capabilities,
  filetypes = {"terraform", "terraform-vars"}
}
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = function() 
    vim.lsp.buf.format({async=true})
  end
})

-- python
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
lspconfig.pylsp.setup{
  capabilities = capabilities,
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

-- golang
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md
lspconfig.gopls.setup{
  capabilities = capabilities,
  cmd = {"gopls", "serve"},
  filetypes = {"go", "gomod"},
  root_dir = lsputil.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

-- general
----------

vim.o.showcmd = true
vim.o.lazyredraw = true
vim.o.laststatus = 2
vim.o.noshowmode = true
vim.o.timeoutlen = 2000
vim.o.ttimeoutlen = 100
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.wildmenu = true
vim.o.showmatch = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.scrolloff = 4
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
