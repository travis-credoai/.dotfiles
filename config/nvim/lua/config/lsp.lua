local lspcap = require('cmp_nvim_lsp').default_capabilities()
local util = require('lib.util')

-- general
-- -------

local format_group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
local org_imports_group = vim.api.nvim_create_augroup("LspOrgImports", { clear = true })

-- ref https://github.com/neovim/nvim-lspconfig?tab=readme-ov-file#configuration
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc' -- this may be extraneous for neovim >=v0.8.1
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local opts = { buffer = ev.buf }
    if client:supports_method('textDocument') then
      util.key_mapper('n', '<leader>gd', vim.lsp.buf.definition, opts)
      util.key_mapper('n', '<leader>gds', vim.lsp.buf.document_symbol, opts)
      util.key_mapper('n', '<leader>gr', vim.lsp.buf.references, opts)
      util.key_mapper('n', '<leader>gs', vim.lsp.buf.signature_help, opts)
      -- util.key_mapper({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
      util.key_mapper('n', '<leader>ci', function()
        print('organizing imports')
        vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
      end, opts)
      util.key_mapper('n', '<leader>cf', function()
        print('formatting')
        vim.lsp.buf.format({async=true})
      end, opts)
    end
    if client.supports_method('textDocument/rename') then
      util.key_mapper('n', '<leader>rn', vim.lsp.buf.rename, opts)
    end
    if client.supports_method('textDocument/implementation') then
      util.key_mapper('n', '<leader>gi', vim.lsp.buf.implementation, opts)
      util.key_mapper("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", opts)
    end
  end,
})

-- diagnostic
-- ---------
vim.diagnostic.config({
  virtual_text = {
    prefix = '●', -- You can choose any prefix symbol
    source = "always", -- This shows the source of the diagnostic
  },
  float = {
    source = "always", -- This shows the source in hover windows
  },
})

-- general
-- -------

-- vim.lsp.config('*', {
--   root_markers = { '.git' },
--   capabilities = {
--     textDocument = {
--       semanticTokens = {
--         multilineTokenSupport = true,
--       }
--     }
--   }
-- })

-- terraform
------------
vim.lsp.config.terraformls = {
  capabilities = lspcap,
  filetypes = {"terraform", "terraform-vars"}
}
vim.lsp.enable('terraformls')

vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = function() 
    vim.lsp.buf.format({async=true})
  end
})

-- python
---------

vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_group,
  pattern = { "*.py" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = org_imports_group,
--   pattern = { "*.py" },
--   callback = function()
--     vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
--   end,
-- })

-- [deprecated]
-- -- https://github.com/neovim/nvim-lspconfig/issues/500
-- local function get_python_path(workspace)
--   -- Use activated virtualenv.
--   if vim.env.VIRTUAL_ENV then
--     return vim.lsp.config.util.path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
--   end

--   -- Find and use virtualenv in workspace directory.
--   for _, pattern in ipairs({'*', '.*'}) do
--     local match = vim.fn.glob(vim.lsp.config.util.path.join(workspace, pattern, 'pyvenv.cfg'))
--     if match ~= '' then
--       return vim.lsp.config.util.path.join(vim.lsp.config.util.path.dirname(match), 'bin', 'python')
--     end
--   end

--   -- Find and use virtualenv via poetry in workspace directory.
--   local match = vim.fn.glob(vim.lsp.config.util.path.join(workspace, 'poetry.lock'))
--   if match ~= '' then
--     local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
--     return vim.lsp.config.util.path.join(venv, 'bin', 'python')
--   end

--   -- Fallback to system Python.
--   return exepath('python3') or exepath('python') or 'python'
-- end

-- pylsp
---------

-- disable completion in pylsp but retain formatting
-- https://github.com/sublimelsp/LSP-pylsp/blob/master/README.md#running-alongside-lsp-pyright
local lspcap_pylsp = require('cmp_nvim_lsp').default_capabilities()
lspcap_pylsp.completionProvider = false
lspcap_pylsp.definitionProvider = false
lspcap_pylsp.documentHighlightProvider = false
lspcap_pylsp.documentSymbolProvider = false
lspcap_pylsp.hoverProvider = false
lspcap_pylsp.referencesProvider = false
lspcap_pylsp.renameProvider = false
lspcap_pylsp.signatureHelpProvider = false

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
-- https://github.com/python-lsp/python-lsp-server
vim.lsp.config.pylsp = {
  capabilities = lspcap_pylsp,
  root_markers = { 'pyproject.toml', '.git' },
  -- root_dir = function(filename, bufnr)
  --   vim.fs.root(bufnr, {'pyproject.toml', '.git'})
  -- end,
  settings = {
    pylsp = {
      cmd = {"pylsp", "-vvv"},
      plugins = {
        autopep8 = {
          enabled = false
        },
        flake8 = {
          enabled = false
        },
        jedi_completion = {
          enabled = false
        },
        jedi_definition = {
          enabled = false
        },
        jedi_hover = {
          enabled = false
        },
        jedi_references = {
          enabled = false
        },
        jedi_signature_help = {
          enabled = false
        },
        jedi_symbols = {
          enabled = false
        },
        pycodestyle = {
          enabled = false,
          ignore = {'W391'},
          maxLineLength = 100
        },
        pydocstyle = {
          enabled = false,
        },
        pyflakes = {
          enabled = false,
        },
        pylint = {
          enabled = false,
        },
        pylsp_black = {
          enabled = false,
        },
        pylsp_black = {
          enabled = false,
        },
        pylsp_mypy = {
          enabled = false,
        },
        -- https://github.com/python-lsp/python-lsp-ruff?tab=readme-ov-file#configuration
        ruff = {
          enabled = true,
          formatEnabled = true,
        },
        yapf = {
          enabled = false,
          based_on_style = 'pep8',
          spaces_before_comment = '4'
        },
      }
    }
  }
}
vim.lsp.enable('pylsp')

-- pylsp
---------

-- https://packagecontrol.io/packages/LSP-pyright
vim.lsp.config.pyright = {
  capabilities = lspcap,
  settings = {}
}
vim.lsp.enable('pyright')

-- yaml
-------

vim.lsp.config.yamlls = {
  capabilities = lspcap,
  on_attach = function(client, bufnr)
    local filepath = vim.api.nvim_buf_get_name(bufnr)
    print('processing ' .. filepath)
    if string.match(filepath, ".*templates.*") then
      util.disableDiagnosticNamespacesByPattern('yamlls', bufnr)
    end
  end,
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/kustomization.json"] = "/kustomization.yaml",
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://json.schemastore.org/chart.json"] = "/Chart.yaml",
        ["./schema/crd/helmrelease.helm.toolkit.fluxcd.io_v2.json"] = "/templates/*.yaml",
      }
    }
  }
}
vim.lsp.enable('yamlls')

-- golang
---------

require('go').setup()
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md
vim.lsp.config.gopls = {
  capabilities = lspcap,
  cmd = {"gopls", "serve"},
  filetypes = {"go", "gomod"},
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}
vim.lsp.enable('gopls')

vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_group,
  pattern = { "*.go" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = org_imports_group,
  pattern = { "*.go" },
  callback = function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end,
})


-- typescript
---------
vim.lsp.config.ts_ls = {
  capabilities = lspcap,
  root_markers = { 'package.json', '.git' },
  -- on_attach = function(client, bufnr)
  --   lsp_formatting_on_save(client, bufnr)
  -- end,
}
vim.lsp.enable('ts_ls')

vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_group,
  pattern = { "*.ts", "*.tsx" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- elixir
---------
vim.lsp.config.elixirls = {
  capabilities = lspcap,
  cmd = { os.getenv("ELIXIR_LS_PATH") .. "/elixir-ls" or "/usr/bin" .. "/elixir-ls" },
}
vim.lsp.enable('elixirls')

vim.api.nvim_create_autocmd("BufWritePre", {
  group = format_group,
  pattern = { "*.ex", "*.exs" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- tilt
-------
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
  pattern = {"Tiltfile"},
  callback = function()
    vim.bo.filetype = "tiltfile"
    vim.bo.syntax = "starlark"
  end,
})
vim.lsp.config.tiltls = {}
vim.lsp.enable('tilt_ls')

-- helm
-------
vim.lsp.config.helm_ls = {
  settings = {
    ['helm-ls'] = {
      yamlls = {
        path = "yaml-language-server",
        -- path = "/opt/homebrew/bin/yaml-language-server",
      }
    }
  }
}
vim.lsp.enable('helm_ls')
