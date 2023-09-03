local ok, comment = pcall(require, "Comment")
if not ok then
  return
end

comment.setup({
  toggler = {
    line = "<C-/>",
    block = "<C-b>",
  },
  opleader = {
    line = "<C-/>",
    block = "<C-b>",
  },
  mappings = {
    basic = true,
    extra = false,
  },
  pre_hook = function(ctx)
    return require("ts_context_commentstring.internal").calculate_commentstring()
  end,
})
