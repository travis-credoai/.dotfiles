return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require('telescope').setup({
      defaults = {
        layout_strategy = 'vertical',
        layout_config = { height = 0.95 },
      }
    })
    local util = require('lib.util')
    local builtin = require('telescope.builtin')
    util.key_mapper('n', '<leader>fb', '<cmd>:lua require("telescope.builtin").buffers({sort_mru = true, sort_lastused = true})<cr>', {})
    util.key_mapper('n', '<leader>ff', builtin.find_files, {})
    util.key_mapper('n', '<leader>fg', builtin.live_grep, {})
    util.key_mapper('n', '<leader>fh', builtin.help_tags, {})
    util.key_mapper('n', '<leader>fj', builtin.jumplist, {})
    util.key_mapper('n', '<leader>fr', builtin.registers, {})
    util.key_mapper('n', '<leader>ft', builtin.treesitter, {})
    util.key_mapper('n', '<leader>fT', builtin.tags, {})
    util.key_mapper('n', '<leader>fld', builtin.lsp_definitions, {})
    util.key_mapper('n', '<leader>fldt', builtin.lsp_type_definitions, {})
    util.key_mapper('n', '<leader>flds', builtin.lsp_document_symbols, {})
    util.key_mapper('n', '<leader>flr', builtin.lsp_references, {})
    util.key_mapper('n', '<leader>fli', builtin.lsp_incoming_calls, {})
    util.key_mapper('n', '<leader>flo', builtin.lsp_outgoing_calls, {})
  end
}
