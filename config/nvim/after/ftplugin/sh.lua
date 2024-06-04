vim.o.tabstop=4
vim.o.softtabstop=4
vim.o.shiftwidth=4
vim.g.is_posix=1

vim.b.ale_fixers = {
  "remove_trailing_lines",
  "trim_whitespace",
  "shfmt"
}

vim.b.ale_linters = {"shellcheck"}

vim.b.ale_fix_on_save = 1
vim.b.ale_sh_shellcheck_change_directory = 0

vim.api.nvim_create_autocmd({"BufRead"}, {
  pattern = {"*.env"},
  callback = function(event)
    new_linters = vim.deepcopy(vim.b.ale_linters)
    idx = indexOf(new_linters, "shellcheck")
    if idx then
      table.remove(new_linters, idx)
    end
    -- print("sh autocommand called for file: " .. event.file)
    vim.diagnostic.disable(event.buf)
    vim.b.ale_linters = new_linters
  end,
})
