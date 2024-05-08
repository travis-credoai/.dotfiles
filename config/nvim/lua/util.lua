util_original_dir = vim.fn.getcwd()

function FindGitRootDir(bufnr)
  bufnr = bufnr or vim.fn.bufnr('%')
  local buf_path = vim.fn.expand('#' .. bufnr .. ':p:h')
  local original_dir = vim.fn.getcwd()
  vim.fn.chdir(buf_path)
  local git_root = vim.fn.system('git rev-parse --show-toplevel'):gsub('\n', '')
  vim.fn.chdir(original_dir)
  if vim.v.shell_error == 0 then
    print('Found git root for file: ' .. git_root)
    return git_root
  else
    return nil
  end
end

function SetGitRootDir()
  util_original_dir = vim.fn.getcwd()
  local git_root = FindGitRootDir()
  if git_root then
    print('Setting currunt dir before ALE fixing: ' .. git_root)
    vim.api.nvim_set_current_dir(git_root)
  end
end

function RevertOriginalDir()
  print('Reverting currunt dir after ALE fixing: ' .. util_original_dir)
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
