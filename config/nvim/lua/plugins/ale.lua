-- return {
--   "w0rp/ale",
--   ft = {
--     "sh", "zsh", "bash", "c", "cpp", "cmake", "elixir", "hcl", "html",
--     "markdown", "python", "racket", "vim", "tex", "yaml", "yml", "json",
--     "smarty", "dockerfile",
--   },
--   cmd = "ALEEnable",
--   config = function()
--     vim.cmd([[ALEEnable]])
--   end,
-- }

return {
  'dense-analysis/ale',
  config = function()
    vim.cmd([[ALEEnable]])
    -- Configuration goes here.
    -- local g = vim.g

    -- g.ale_ruby_rubocop_auto_correct_all = 1

    -- g.ale_linters = {
    --   ruby = {'rubocop', 'ruby'},
    --   lua = {'lua_language_server'}
    -- }
  end
}
