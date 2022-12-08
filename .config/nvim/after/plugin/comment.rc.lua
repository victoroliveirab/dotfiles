require('Comment').setup({
  toggler = {
    line = '<C-_>',
    block = '<C-b>',
  },
  opleader = {
    line = '<C-_>',
    block = '<C-b>',
  },
  mappings = {
    basic = true,
    extra = false,
  },
  pre_hook = function(ctx)
    return require('ts_context_commentstring.internal').calculate_commentstring()
  end,
})
