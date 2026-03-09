return {
  "preservim/nerdtree",
  enabled = false,
  config = function()
    local util = require('lib.util')
    util.key_mapper('n', '<leader>nf', ':NERDTreeFind<CR>')
    util.key_mapper('n', '<leader>nh', ':NERDTreeFocus<CR>')
    util.key_mapper('n', '<leader>nt', ':NERDTreeToggle<CR>')
    util.key_mapper('n', '<leader>ob', function()
      vim.cmd('NERDTreeFocus')
      vim.defer_fn(function()
        vim.api.nvim_feedkeys(':OpenBookmark ', 'n', false)
      end, 100)
    end, {})
  end
}
