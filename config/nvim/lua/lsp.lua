vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
  end,
})
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
        },
        yapf = {
          based_on_style = 'pep8',
          spaces_before_comment = '4'
        }
      }
    }
  }
}

-- yaml
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
