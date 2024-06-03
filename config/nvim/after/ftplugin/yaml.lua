vim.o.tabstop=2
vim.o.softtabstop=2
vim.o.shiftwidth=2

vim.b.ale_fixers = {
  "remove_trailing_lines",
  "trim_whitespace",
  "yamlfmt"
}

vim.b.ale_linters = {"yamllint"}

vim.b.ale_fix_on_save = 1

vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = {"yaml"},
  callback = function(event) 
    -- print("Yaml autocommand called for file: " .. event.file)
    if string.match(event.file, ".*gotk-.*") then
      -- print("SPECIAL FILE -- ignoring")
      vim.diagnostic.disable(0)
      vim.b.ale_fix_on_save = 0
      vim.b.ale_linters = {}
    elseif string.match(event.file, ".*templates.*") then
      -- print("Yaml autocommand called for file: " .. event.file)
      new_fixers = vim.deepcopy(vim.api.nvim_buf_get_var(0, "ale_fixers"))
      idx = indexOf(new_fixers, "yamlfmt")
      if idx then
        table.remove(new_fixers, idx)
      end
      vim.diagnostic.disable(0)
      vim.b.ale_fixers = new_fixers
    else
      -- print("Normal yaml file")
      vim.b.ale_fix_on_save = 1
    end

    yamllint_options = MakeYamllintOptions()
    if yamllint_options then
      vim.b.ale_yaml_yamllint_options = yamllint_options
    end

    yamlfmt = MakeYamlfmtOptions()
    if yamlfmt_options then
      vim.b.ale_yaml_yamlfmt_options = yamlfmt_options
    end
  end,
})
