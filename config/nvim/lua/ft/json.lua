vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = {"json"},
  callback = function(event) 
    -- skip jq formatting when eslint and prettier is in effect
    if GitRepoHasPrettierrc then
      new_fixers = vim.deepcopy(vim.api.nvim_buf_get_var(0, "ale_fixers"))
      idx = indexOf(new_fixers, "jq")
      if idx then
        table.remove(new_fixers, idx)
      end
      vim.diagnostic.disable(0)
      vim.b.ale_fixers = new_fixers
    else
      -- print("Normal json file")
      vim.b.ale_fix_on_save = 1
    end
  end,
})
