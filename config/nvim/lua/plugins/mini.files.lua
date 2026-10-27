return {
  'nvim-mini/mini.files', 
  enabled = true,
  version = '*',
  config =  function() 
    require('mini.files').setup{}

    local util = require('lib.util')
    util.key_mapper('n', '<leader>mr', ':lua MiniFiles.open()<CR>')
    util.key_mapper('n', '<leader>mb', function()
      local buf_name = vim.api.nvim_buf_get_name(0)
      local path = buf_name ~= "" and vim.uv.fs_stat(buf_name) and buf_name or nil
      MiniFiles.open(path)
    end, { desc = "MiniFiles at current buffer's file" })

    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        -- Make new window and set it as target
        local cur_target = MiniFiles.get_explorer_state().target_window
        if cur_target == nil then
          return
        end

        local new_target = vim.api.nvim_win_call(cur_target, function()
          vim.cmd(direction .. ' split')
          return vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target)

        -- Open the file/dir under the cursor into the freshly-created split.
        MiniFiles.go_in({ close_on_file = true })
      end

      -- Adding `desc` will result into `show_help` entries
      local desc = 'Split ' .. direction
      vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak keys to your liking
        map_split(buf_id, '<C-s>', 'belowright horizontal')
        map_split(buf_id, '<C-v>', 'belowright vertical')
        map_split(buf_id, '<C-t>', 'tab')
      end,
    })

  end,
}
