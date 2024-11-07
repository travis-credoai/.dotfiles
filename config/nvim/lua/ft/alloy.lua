vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = {"alloy"},
  callback = function(event) 
    print('do it for alloy files')
    vim.bo.indentexpr = "v:lua.require('lib.util').getLineIndent()"
  end,
})
