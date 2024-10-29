local lspcap = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
local lsputil = require('lspconfig/util')
local util = require('lib.util')

-- general
-- -------
local function lsp_formatting_on_save(client, bufnr)
  -- Enable formatting on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
end

local function lsp_org_imports_on_save(client, bufnr)
  -- Enable formatting on save
  -- print(vim.inspect(client.server_capabilities))
  if client.server_capabilities.codeActionProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspOrgImports", { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
      end,
    })
  end
end

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

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client.supports_method('textDocument') then
      util.key_mapper('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf })
      util.key_mapper("n", "gpD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>")
      util.key_mapper("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>")
      util.key_mapper("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>")
      util.key_mapper("n", "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>")
      util.key_mapper("n", "gQ", "<cmd>lua require('goto-preview').close_all_win()<CR>")
      util.key_mapper('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
      util.key_mapper('n', '<leader>gds', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
      util.key_mapper('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
      util.key_mapper('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
      util.key_mapper('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
      util.key_mapper('n', '<leader>cf', '<cmd>lua vim.lsp.buf.format({async=true})<CR>')
    end
    if client.supports_method('textDocument/rename') then
      util.key_mapper('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    end
    if client.supports_method('textDocument/implementation') then
      util.key_mapper('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
      util.key_mapper("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
    end
  end,
})

-- terraform
------------
lspconfig.terraformls.setup{
  capabilities = lspcap,
  filetypes = {"terraform", "terraform-vars"}
}
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = function() 
    vim.lsp.buf.format({async=true})
  end
})

-- python
---------

-- https://github.com/neovim/nvim-lspconfig/issues/500
local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return lsputil.path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({'*', '.*'}) do
    local match = vim.fn.glob(lsputil.path.join(workspace, pattern, 'pyvenv.cfg'))
    if match ~= '' then
      return lsputil.path.join(lsputil.path.dirname(match), 'bin', 'python')
    end
  end

  -- Find and use virtualenv via poetry in workspace directory.
  local match = vim.fn.glob(lsputil.path.join(workspace, 'poetry.lock'))
  if match ~= '' then
    local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
    return lsputil.path.join(venv, 'bin', 'python')
  end

  -- Fallback to system Python.
  return exepath('python3') or exepath('python') or 'python'
end

-- disable completion in pylsp but retain formatting
-- https://github.com/sublimelsp/LSP-pylsp/blob/master/README.md#running-alongside-lsp-pyright
lspcap.completionProvider = false
lspcap.definitionProvider = false
lspcap.documentHighlightProvider = false
lspcap.documentSymbolProvider = false
lspcap.hoverProvider = false
lspcap.referencesProvider = false
lspcap.renameProvider = false
lspcap.signatureHelpProvider = false

local function on_attach_pylsp(client, bufnr)
    lsp_formatting_on_save(client, bufnr)
end
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
-- https://github.com/python-lsp/python-lsp-server
lspconfig.pylsp.setup{
  capabilities = lspcap,
  on_init = function(client) 
    client.config.settings.pylsp.plugins.jedi.environment = get_python_path(client.config.root_dir)
  end,
  on_attach = on_attach_pylsp,
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
          enabled = true,
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

-- vim.api.nvim_create_autocmd({"BufWritePre"}, {
--   pattern = {"*.py"},
--   callback = function() 
--     vim.lsp.buf.format({async=true})
--     -- vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
--   end,
-- })

local function on_attach_pyright(client, bufnr)
    set_omnifunc(client, bufnr)
    -- lsp_org_imports_on_save(client, bufnr)
    -- Call additional setup functions here
end
-- https://packagecontrol.io/packages/LSP-pyright
lspconfig.pyright.setup{
  on_attach = on_attach_pyright,
  -- the code to get_python_path is not needed 
  -- on_init = function(client) 
  --   client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
  -- end,
  capabilities = lspcap,
  settings = { }
}

-- yaml
-------

lspconfig.yamlls.setup{
  capabilities = lspcap,
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/kustomization.json"] = "/kustomization.yaml",
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://json.schemastore.org/chart.json"] = "/Chart.yaml",
      }
    }
  }
}

-- golang
---------

require('go').setup()
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md
lspconfig.gopls.setup{
  capabilities = lspcap,
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

vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.go"},
  callback = function() 
    vim.lsp.buf.format({async=true})
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end,
})

-- typescript
---------
lspconfig.ts_ls.setup{
  capabilities = lspcap,
}


-- elixir
---------
lspconfig.elixirls.setup{
  capabilities = lspcap,
  cmd = { os.getenv("ELIXIR_LS_PATH") .. "/elixir-ls" or "/usr/bin" .. "/elixir-ls" },
  settings = {
  }
}

-- tilt
-------
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
  pattern = {"Tiltfile"},
  callback = function()
    vim.bo.filetype = "tiltfile"
    vim.bo.syntax = "starlark"
  end,
})
lspconfig.tilt_ls.setup{}

-- helm
-------
lspconfig.helm_ls.setup {
  settings = {
    ['helm-ls'] = {
      yamlls = {
        path = "yaml-language-server",
        -- path = "/opt/homebrew/bin/yaml-language-server",
      }
    }
  }
}
