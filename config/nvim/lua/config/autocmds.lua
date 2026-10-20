-- Follow the current buffer's git repo so cwd-relative tools (telescope,
-- fugitive, :make) operate on the repo being edited. Files outside a repo
-- and special buffers (mini.files, telescope prompts, terminals) leave cwd alone.
vim.api.nvim_create_autocmd({"BufEnter"}, {
  group = vim.api.nvim_create_augroup("cwd_git_root", {clear = true}),
  callback = function(event)
    if vim.bo[event.buf].buftype ~= "" then
      return
    end
    local root = vim.fs.root(event.buf, ".git")
    if root and root ~= vim.fn.getcwd() then
      vim.api.nvim_set_current_dir(root)
    end
  end,
})
