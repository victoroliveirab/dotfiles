local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

local cmp_sources = {
	{ name = "nvim_lsp" },
	{ name = "nvim_lua" },
	{ name = "luasnip" },
	-- Must be above buffer otherwise common names such as header can appear duplicate
	{ name = "css-utils" },
	{ name = "buffer" },
	{ name = "path" },
}

if string.find(vim.fn.getcwd(), "css.go.to.definition.example.projects") then
	cmp_sources = {
		cmp_sources[4],
	}
end

print(vim.fn.getcwd())
print(vim.inspect(cmp_sources))

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
	formatting = {
		format = require("lspkind").cmp_format({
			maxwidth = 50,
			-- ellipsis_char = "",
			ellipsis_char = "...",
		}),
	},
	sources = cmp_sources,
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		documentation = cmp.config.window.bordered(),
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
})
