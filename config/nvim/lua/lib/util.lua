local M = {}

M.key_mapper = function(mode, key, result, opts)
  local default_opts = { noremap = true, silent = true }
  local final_opts = vim.tbl_extend("force", default_opts, opts or {})
  vim.keymap.set(
    mode,
    key,
    result,
    final_opts
  )
end

function FindGitRootDir(bufnr)
  bufnr = bufnr or vim.fn.bufnr('%')
  local buf_path = vim.fn.expand('#' .. bufnr .. ':p:h')
  local original_dir = vim.fn.getcwd()
  -- vim.fn.chdir(buf_path) -- this may not be a valid filesystem path (eg fugitive Gedit)
  if vim.fn.isdirectory(buf_path) == 1 then
    local success, err = pcall(function()
      vim.fn.chdir(buf_path)
    end)
    if not success then
      print("Failed to change directory: " .. err)
      return nil
    end
    local git_root = vim.fn.system('git rev-parse --show-toplevel'):gsub('\n', '')
    vim.fn.chdir(original_dir)
    if vim.v.shell_error == 0 then
      -- print('Found git root for file: ' .. git_root)
      return git_root
    else
      return nil
    end
  else
    print("Invalid directory: " .. buf_path)
    return nil
  end
end

function SetGitRootDir()
  util_original_dir = vim.fn.getcwd()
  local git_root = FindGitRootDir()
  if git_root then
    vim.api.nvim_set_current_dir(git_root)
  end
end

function RevertOriginalDir()
  -- print('Reverting currunt dir after ALE fixing: ' .. util_original_dir)
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
  -- print('Looking for yamllint in ' .. root_dir)
  local filenames = {'.yamllint', '.yamllint.yaml', '.yamllint.yml'}

  for _, filename in ipairs(filenames) do
    filepath = root_dir .. '/' .. filename
    if vim.fn.filereadable(filepath) == 1 then
      -- print('Found yamllint ' .. filepath)
      return filepath
    end
  end

  return nil
end

function MakeYamllintOptions(bufnr)
  local git_root = FindGitRootDir(bufnr)
  options = ''
  local config = FindYamllintConfig(git_root)
  if config then
    options = options .. '-c ' .. config .. ' '
  end
  return options
end

function FindYamlfmtConfig(root_dir)
  root_dir = root_dir or vim.fn.getcwd()
  -- print('Looking for yamlfmt in ' .. root_dir)
  local filenames = {'.yamlfmt'}

  for _, filename in ipairs(filenames) do
    filepath = root_dir .. '/' .. filename
    if vim.fn.filereadable(filepath) == 1 then
      -- print('Found yamlfmt ' .. filepath)
      return filepath
    end
  end

  return nil
end

function MakeYamlfmtOptions(bufnr)
  local git_root = FindGitRootDir(bufnr)
  options = ''
  local config = FindYamlfmtConfig(git_root)
  if config then
    options = options .. '-conf ' .. config .. ' '
  end
  return options
end

function GitRepoHasPrettierrc(bufnr)
  local git_root = FindGitRootDir(bufnr)
  if not git_root then
    print("No git root")
    return false
  end
  local prettier_config_path = git_root .. "/.prettierrc"
  if uv.fs_stat(prettier_config_path) then
    print("Found .prettierrc")
    return true
  else
    print("No .prettierrc")
    return false
  end
end

-- under development
-- -----------------
-- Function to check if a file exists
local function file_exists(file)
  local f = io.open(file, "r")
  if f then
    io.close(f)
    return true
  else
    return false
  end
end

-- Function to close buffers with deleted files
local function close_buffers_with_deleted_files()
  -- Get a list of all buffers
  local buffers = vim.api.nvim_list_bufs()
  
  -- Iterate over each buffer
  for _, buf in ipairs(buffers) do
    -- Check if the buffer is loaded and has a file associated with it
    if vim.api.nvim_buf_is_loaded(buf) then
      local filename = vim.api.nvim_buf_get_name(buf)
      if filename ~= "" and not file_exists(filename) then
        -- Close the buffer if the file does not exist
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end
end

-- Command to trigger the function
vim.api.nvim_create_user_command('CloseDeletedBuffers', close_buffers_with_deleted_files, {})
-- -----------------
-- under development

M.saveTempSession = function()
  -- local session_name = GenerateUniqueSessionName()
  local session_name = '/tmp/session_' .. os.date("%Y%m%d_%H%M%S") .. '.vim'
  -- print('saved temp session: ' .. session_name)
  vim.cmd('mksession! ' .. session_name)
  vim.g.last_session = session_name
end

M.restoreTempSession = function()
  -- print('restored temp session: ' .. vim.g.last_session)
  vim.cmd('source ' .. vim.g.last_session)
end

return M
