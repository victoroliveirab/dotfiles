local status, wk = pcall(require, "which-key")
if not status then
  return
end

wk.setup {
  disable = {
    filetypes = { "TelescopePrompt" }
  }
}

wk.register({
  [";"] = {
    name = "telescope",
    f = "finder",
    r = "live grep",
    e = "diagnostics",
    t = "help tags",
    ["\\"] = "opened buffers",
    [";"] = "last used"
  },
})
