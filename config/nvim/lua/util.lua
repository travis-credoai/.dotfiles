local M = {}

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

M.key_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
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

function FindYamllintConfig(root_dir)
  root_dir = root_dir or vim.fn.getcwd()
  local filenames = {'.yamllint', '.yamllint.yaml', '.yamllint.yml'}

  for _, filename in ipairs(filenames) do
    filepath = root_dir .. '/' .. filename
    if vim.fn.filereadable(filepath) == 1 then
      return filepath
    end
  end

  return nil
end

function MakeYamllintOptions()
  local git_root = FindGitRootDir(0)
  options = ''
  local config = FindYamllintConfig(git_root)
  if config then
    options = options .. '-c ' .. config .. ' '
  end
  return options
end

function FindYamlfmtConfig(root_dir)
  root_dir = root_dir or vim.fn.getcwd()
  local filenames = {'.yamlfmt'}

  for _, filename in ipairs(filenames) do
    filepath = root_dir .. '/' .. filename
    if vim.fn.filereadable(filepath) == 1 then
      return filepath
    end
  end

  return nil
end

function MakeYamlfmtOptions()
  local git_root = FindGitRootDir(0)
  options = ''
  local config = FindYamlfmtConfig(git_root)
  if config then
    options = options .. '-conf ' .. config .. ' '
  end
  return options
end

return M
