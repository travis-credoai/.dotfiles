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
        window = {
          position = "left",
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = {
              "toggle_node",
              nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            -- ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "cancel", -- close preview or floating neo-tree window
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["P"] = {  -- Read `# Preview Mode` for more information
              "toggle_preview",
              config = {
                use_float = true,
                use_snacks_image = true,
                use_image_nvim = true,
              },
            },
            ["l"] = "focus_preview",
            ["s"] = "open_vsplit",
            ["S"] = "open_split",
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ["w"] = "open_with_window_picker",
            -- ["c"] = "close_all_nodes",
            ["e"] = 'close_all_subnodes',
            ["E"] = 'expand_all_subnodes',
            ["z"] = "close_all_nodes",
            ["Z"] = "expand_all_nodes",
            -- ["Z"] = "expand_all_subnodes",
            ["a"] = {
              "add",
              -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "none", -- "none", "relative", "absolute"
              },
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ["d"] = "delete",
            ["r"] = "rename",
            ["b"] = "rename_basename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["<C-r>"] = "clear_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --   "copy",
            --   config = {
            --     show_path = "none" -- "none", "relative", "absolute"
            --   }
            -- }
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
            ["i"] = "show_file_details",
            -- ["i"] = {
            --   "show_file_details",
            --   -- format strings of the timestamps shown for date created and last modified (see `:h os.date()`)
            --   -- both options accept a string or a function that takes in the date in seconds and returns a string to display
            --   -- config = {
            --     --   created_format = "%Y-%m-%d %I:%M %p",
            --     --   modified_format = "relative", -- equivalent to the line below
            --     --   modified_format = function(seconds) return require('neo-tree.utils').relative_date(seconds) end
            --     -- }
            --   },
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
