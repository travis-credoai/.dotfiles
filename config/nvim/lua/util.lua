util_original_dir = vim.fn.getcwd()

function SetGitRootDir()
  util_original_dir = vim.fn.getcwd()
  local git_root = vim.fn.system('git rev-parse --show-toplevel'):gsub('\n', '')
  if vim.v.shell_error == 0 then
    vim.api.nvim_set_current_dir(git_root)
  end
end

function RevertOriginalDir()
  vim.api.nvim_set_current_dir(util_original_dir)
end

vim.api.nvim_create_autocmd({"User"}, {
  pattern = {"ALEFixPre"},
  callback = SetGitRootDir,
})

vim.api.nvim_create_autocmd({"User"}, {
  pattern = {"ALEFixPost"},
  callback = RevertOriginalDir,
})

function indexOf(tbl, value)
    for index, val in ipairs(tbl) do
        if val == value then
            return index
        end
    end
    return nil -- Value not found
end
