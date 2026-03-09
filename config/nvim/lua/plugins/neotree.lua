return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    enabled = true,
    depends = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- "nvim-tree/nvim-web-devicons", -- optional, but recommended
      "antosha417/nvim-lsp-file-operations",
    },
    opts = function(_, opts)
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end
      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
    end,
    config = function()
      require('neo-tree').setup({
        filesystem = {
          commands = {
            avante_add_files = function(state)
              local node = state.tree:get_node()
              local filepath = node:get_id()
              local relative_path = require('avante.utils').relative_path(filepath)

              local sidebar = require('avante').get()

              local open = sidebar:is_open()
              -- ensure avante sidebar is open
              if not open then
                require('avante.api').ask()
                sidebar = require('avante').get()
              end

              sidebar.file_selector:add_selected_file(relative_path)

              -- remove neo tree buffer
              if not open then
                sidebar.file_selector:remove_selected_file('neo-tree filesystem [1]')
              end
            end,
          },
          window = {
            mappings = {
              ['oa'] = 'avante_add_files',
            },
          },
        },
      })
      local util = require('lib.util')
      util.key_mapper('n', '<leader>nf', ':Neotree reveal<CR>')
      util.key_mapper('n', '<leader>nh', ':Neotree focus<CR>')
      util.key_mapper('n', '<leader>nt', ':Neotree toggle<CR>')
      -- util.key_mapper('n', '<leader>ob', function()
      --   vim.cmd('NERDTreeFocus')
      --   vim.defer_fn(function()
      --     vim.api.nvim_feedkeys(':OpenBookmark ', 'n', false)
      --   end, 100)
      -- end, {})
    end,
  },
}
