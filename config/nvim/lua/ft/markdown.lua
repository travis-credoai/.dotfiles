vim.api.nvim_create_autocmd( 'FileType', {
  pattern = 'markdown',
  callback = function(args)
    vim.treesitter.start(args.buf, 'markdown')
    vim.bo[args.buf].syntax = 'on'  -- only if additional legacy syntax is needed
  end
})
