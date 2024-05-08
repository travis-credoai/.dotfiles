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

vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = {"yaml"},
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

    yamllint_options = MakeYamllintOptions()
    if yamllint_options then
      vim.api.nvim_buf_set_var(0, "ale_yaml_yamllint_options", yamllint_options)
    end

    yamlfmt = MakeYamlfmtOptions()
    if yamlfmt_options then
      vim.api.nvim_buf_set_var(0, "ale_yaml_yamlfmt_options", yamlfmt_options)
    end
  end,
})
