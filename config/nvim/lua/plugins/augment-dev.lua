return { 
  'haggishunk/augment.vim',
  dir = "~/code/haggishunk/augment.vim", 
  enabled = false,
  config = function()
    local g = vim.g
    g.augment_workspace_folders = {
      '/Users/travismattera/code/authlib/authlib',
      '/Users/travismattera/code/credo-ai/aws-infrastructure-live',
      '/Users/travismattera/code/credo-ai/azure-infrastructure-live',
      '/Users/travismattera/code/credo-ai/credo-backend/apps',
      '/Users/travismattera/code/credo-ai/credo-ui',
      '/Users/travismattera/code/credo-ai/credoai-gaia',
      '/Users/travismattera/code/credo-ai/credoai-gaia/src',
      '/Users/travismattera/code/credo-ai/credoai-integration-service',
      '/Users/travismattera/code/credo-ai/credoai-services-python',
      '/Users/travismattera/code/credo-ai/credoai_research/credoai_research',
      '/Users/travismattera/code/credo-ai/devtools',
      '/Users/travismattera/code/credo-ai/k8s-deploy',
      '/Users/travismattera/code/credo-ai/policy-packs',
      '/Users/travismattera/code/credo-ai/python-service-template',
      '/Users/travismattera/code/credo-ai/terraform-aws-service-catalog',
      '/Users/travismattera/code/credo-ai/terraform-azure-service-catalog',
      '/Users/travismattera/code/haggishunk/augment.vim',
    }

    -- Augment Chat Floating Window
    local function augment_chat_float()
      local buf = vim.api.nvim_create_buf(false, true)
      
      -- Buffer options
      vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
      vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')
      
      -- Window dimensions
      local width = math.floor(vim.o.columns * 0.8)
      local height = math.floor(vim.o.lines * 0.6)
      local row = math.floor((vim.o.lines - height) / 2)
      local col = math.floor((vim.o.columns - width) / 2)
      
      local opts = {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded'
      }
      
      local win = vim.api.nvim_open_win(buf, true, opts)
      
      -- Add instructions
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
        '# Augment Chat Question',
        '# Type your multiline question below.',
        '# Press <C-s> to send, <Esc> to cancel',
        '',
        ''
      })
      
      -- Position cursor
      vim.api.nvim_win_set_cursor(win, {5, 0})
      
      -- Buffer-local keymaps
      local function send_chat()
        local lines = vim.api.nvim_buf_get_lines(buf, 4, -1, false)
        local content = table.concat(vim.tbl_filter(function(line)
          return line:match('%S')
        end, lines), ' ')
        
        if content == '' then
          print('No content to send')
          return
        end
        
        vim.api.nvim_win_close(win, true)
        vim.cmd('Augment chat ' .. vim.fn.shellescape(content))
      end
      
      vim.keymap.set({'n', 'i'}, '<C-s>', send_chat, {buffer = buf})
      vim.keymap.set('n', '<Esc>', function() vim.api.nvim_win_close(win, true) end, {buffer = buf})
    end

    -- Create command and mapping
    vim.api.nvim_create_user_command('AugmentChatFloat', augment_chat_float, {})
    vim.keymap.set('n', '<leader>ac', ':Augment chat<CR>')
    vim.keymap.set('v', '<leader>ac', ":'<,'>Augment chat<CR>", { desc = 'Augment chat with selection' })
    vim.keymap.set('n', '<leader>af', augment_chat_float)
    vim.keymap.set('n', '<leader>at', ':Augment chat-toggle<CR>')

  end
}
