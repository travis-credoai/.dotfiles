vim.api.nvim_create_autocmd({"BufRead"}, {
  pattern = {"*env"},
  callback = function(event)
    new_linters = vim.deepcopy(vim.api.nvim_buf_get_var(0, "ale_linters"))
    idx = indexOf(new_linters, "shellcheck")
    if idx then
      table.remove(new_linters, idx)
    end
    -- print("sh autocommand called for file: " .. event.file)
    vim.diagnostic.disable(0)
    vim.api.nvim_buf_set_var(0, "ale_linters", new_linters)
  end,
})
