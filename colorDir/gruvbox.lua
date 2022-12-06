vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end
vim.o.background = "dark"
require("gruvbox").setup({
	transparent_mode = false,
})
local colorscheme = "gruvbox"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
	return
end

local r
if pcall(require, "plenary") then
	local reload = require("plenary.reload").reload_module

	r = function(name)
		reload(name)
		return require(name)
	end
end

-- don't display the colorcolumn
vim.cmd("highlight clear ColorColumn")

-- plugin reload
r("plugin-config.lualine")
r("plugin-config.todo-comments")
r("plugin-config.fidget")
r("plugin-config.nvim-treesitter")
r("plugin-config.telescope")
