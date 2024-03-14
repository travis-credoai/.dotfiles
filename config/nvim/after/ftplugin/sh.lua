vim.o.tabstop=4
vim.o.softtabstop=4
vim.o.shiftwidth=4

vim.api.nvim_buf_set_var(0, "ale_fixers", {
  "remove_trailing_lines",
  "trim_whitespace",
  "shfmt"})

vim.api.nvim_buf_set_var(0, "ale_linters", {"shellcheck"})

vim.api.nvim_buf_set_var(0, "ale_fix_on_save", 1)
vim.api.nvim_buf_set_var(0, "ale_sh_shellcheck_change_directory", 0)

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
