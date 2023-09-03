local colorscheme = "tokyonight"

local activate_colorscheme = function(scheme)
	vim.cmd("colorscheme " .. scheme)
end

local ok, _ = pcall(activate_colorscheme, colorscheme)

if not ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
