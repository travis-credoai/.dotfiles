vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
  end,
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig = require('lspconfig')
lsputil = require('lspconfig/util')

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

-- terraform
------------
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
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
-- lspconfig.pylsp.setup{
--   capabilities = capabilities,
--   settings = {
--     -- https://github.com/python-lsp/python-lsp-server
--     pylsp = {
--       plugins = {
--         pycodestyle = {
--           ignore = {'W391'},
--           maxLineLength = 100
--         },
--         yapf = {
--           based_on_style = 'pep8',
--           spaces_before_comment = '4'
--         }
--       }
--     }
--   }
-- }

lspconfig.pyright.setup{
  on_init = function(client) 
    client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
  end,
  capabilities = capabilities,
  settings = { }
}

-- yaml
-------

lspconfig.yamlls.setup{
  capabilities = capabilities,
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

-- don't run yamlls on helm template yamls
vim.api.nvim_create_autocmd({"BufRead"}, {
  pattern = {"*/templates/**/*.yaml"},
  callback = function() 
    vim.diagnostic.disable(0)
  end,
})

-- golang
---------

require('go').setup()
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

vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.go"},
  callback = function() 
    vim.lsp.buf.format({async=true})
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end,
})

-- elixir
---------
lspconfig.elixirls.setup{
  capabilities = capabilities,
  cmd = {"/opt/homebrew/opt/elixir-ls/bin/elixir-ls"},
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
