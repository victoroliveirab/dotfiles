local ok, requests = pcall(require, "requests")
if not ok then
	return
end

requests.setup({
	default_queries = {
		"results:3",
		"gender:male",
		"password:upper,lower,9-16",
		"nat:br",
		"exc:picture",
	},
	default_url = "https://randomuser.me/api/",
	keymap = "<leader>r",
})
