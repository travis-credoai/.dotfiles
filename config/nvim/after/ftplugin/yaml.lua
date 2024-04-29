vim.o.tabstop=2
vim.o.softtabstop=2
vim.o.shiftwidth=2

vim.api.nvim_buf_set_var(0, "ale_fixers", {
  "remove_trailing_lines",
  "trim_whitespace",
  "yamlfmt"})

vim.api.nvim_buf_set_var(0, "ale_linters", {"yamllint"})

vim.api.nvim_buf_set_var(0, "ale_fix_on_save", 1)

vim.api.nvim_create_autocmd({"BufRead"}, {
  pattern = {"*"},
  callback = function(event) 
    -- print("Yaml autocommand called for file: " .. event.file)
    if string.match(event.file, ".*gotk-.*") then
      -- print("SPECIAL FILE -- ignoring")
      vim.diagnostic.disable(0)
      vim.api.nvim_buf_set_var(0, "ale_fix_on_save", 0)
      vim.api.nvim_buf_set_var(0, "ale_linters", {})
    elseif string.match(event.file, ".*templates.*") then
      -- print("Yaml autocommand called for file: " .. event.file)
      new_fixers = vim.deepcopy(vim.api.nvim_buf_get_var(0, "ale_fixers"))
      idx = indexOf(new_fixers, "yamlfmt")
      if idx then
        table.remove(new_fixers, idx)
      end
      vim.diagnostic.disable(0)
      vim.api.nvim_buf_set_var(0, "ale_fixers", new_fixers)
    else
      -- print("Normal yaml file")
      vim.api.nvim_buf_set_var(0, "ale_fix_on_save", 1)
    end
  end,
})
