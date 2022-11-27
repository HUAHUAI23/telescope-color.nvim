local api = vim.api

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.g.deus_termcolors = 256
local colorscheme = "deus"
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

-- r("plugin-config.bufferline")

-- editor
api.nvim_set_hl(0, "NonText", { ctermfg = 142, fg = "grey50", bold = true })
api.nvim_set_hl(0, "NormalFloat", { ctermfg = 223, ctermbg = 239, fg = "#ebdbb2", bg = "#242a32" })
api.nvim_set_hl(0, "Normal", { ctermfg = 223, ctermbg = 235, fg = "#ebdbb2", bg = "#2C323B" })

api.nvim_set_hl(0, "SignColumn", { ctermbg = "none", bg = "none" })
-- api.nvim_set_hl(0, "VertSplit", { bg = "none", ctermbg = "none", ctermfg = 246, fg = "#a89984" })
api.nvim_set_hl(0, "VertSplit", { bg = "#2C323B", ctermbg = "none", ctermfg = 246, fg = "#ebdbb2" })
api.nvim_set_hl(0, "CursorLineNr", { ctermfg = 208, ctermbg = 239, bg = "#242a32", fg = "#fe8019", bold = true })

-- ------
-- gitsigns
api.nvim_set_hl(0, "deusGreenSign", { ctermfg = 142, ctermbg = 239, bg = "none", fg = "#98c379" })
api.nvim_set_hl(0, "deusAquaSign", { ctermfg = 108, ctermbg = 239, bg = "none", fg = "#8ec07c" })

-- plugin reload
r("plugin-config.lualine")
r("plugin-config.todo-comments")
r("plugin-config.fidget")
r("plugin-config.nvim-treesitter")
r("plugin-config.telescope")
