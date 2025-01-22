local util = require('lib/util')

vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = "yaml",
  callback = function(event) 
    local filepath = vim.api.nvim_buf_get_name(event.buf)

    if string.match(filepath, ".*gotk-.*") then
      print("ft::yaml special fluxcd content")
      vim.diagnostic.enable(false)
      vim.b.ale_linters = {}
      vim.b.ale_fix_on_save = 0
    elseif string.match(filepath, ".*templates.*") then
      print("ft::yaml special helm content")
      new_fixers = vim.deepcopy(vim.api.nvim_buf_get_var(event.buf, "ale_fixers"))
      idx = indexOf(new_fixers, "yamlfmt")
      if idx then
        table.remove(new_fixers, idx)
      end
      vim.b.ale_fixers = new_fixers
      vim.b.ale_fix_on_save = 1
    else
      vim.b.ale_fix_on_save = 1
    end

    yamllint_options = MakeYamllintOptions(event.buf)
    if yamllint_options then
      vim.b.ale_yaml_yamllint_options = yamllint_options
    end

    yamlfmt = MakeYamlfmtOptions(event.buf)
    if yamlfmt_options then
      vim.b.ale_yaml_yamlfmt_options = yamlfmt_options
    end
  end,
})
