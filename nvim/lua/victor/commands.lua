-- Open .env file
vim.keymap.set("n", "<leader>oe", function()
  local cwd = vim.fn.getcwd()
  local possible_files = {
    ".env.development.local",
    ".env.local",
    ".env.development",
    ".env",
    ".env.sample"
  }
  ---@type string?
  local filename
  for _, f in ipairs(possible_files) do
    local fsize = vim.fn.getfsize(string.format("%s/%s", cwd, f))
    if fsize ~= -1 then
      filename = f
      break
    end
  end
  if not filename then
    error("No .env or variant found", 2)
  end
  vim.cmd(string.format(":e %s", filename))
end, { desc = "Open: Env File" })

-- Open package file
vim.keymap.set("n", "<leader>op", function()
  local cwd = vim.fn.getcwd()
  local possible_files = {
    "package.json",
    "go.mod",
    "requirements.txt",
    "Cargo.toml",
    "mix.exs",
  }
  ---@type string?
  local filename
  for _, f in ipairs(possible_files) do
    local fsize = vim.fn.getfsize(string.format("%s/%s", cwd, f))
    if fsize ~= -1 then
      filename = f
      break
    end
  end
  if not filename then
    error("No .env or variant found", 2)
  end
  vim.cmd(string.format(":e %s", filename))
end, { desc = "Open: Package File" })
