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
api.nvim_set_hl(0, "GitSignsDelete", { ctermfg = 167, ctermbg = 239, bg = "none", fg = "#fb4934" })

-- treesitter
r("plugin-config.nvim-treesitter")
api.nvim_set_hl(0, "@variable.builtin", { ctermfg = 203, fg = "#ff4090" })
api.nvim_set_hl(0, "@parameter", { link = "deusBlue" })
api.nvim_set_hl(0, "@field", { link = "deusBlue" })
api.nvim_set_hl(0, "@boolean", { ctermfg = 175, fg = "#c678dd", bold = true, italic = true })
api.nvim_set_hl(0, "@type", { ctermfg = 214, fg = "#fabd2f", bold = true, italic = true })
api.nvim_set_hl(0, "@variable", { ctermfg = 223, fg = "#ebdbb2" })

-- navic
vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, fg = "#FBC19D", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, fg = "#FECDD3", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, fg = "#A5B4FC", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, fg = "#BF7471", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, fg = "#DDD6FE", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = true, fg = "#BF7471", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, fg = "#A5B4FC", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, fg = "#D1D5DB", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, fg = "#B5E8B0", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, fg = "#98BC99", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, fg = "#B5E8B0", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = true, fg = "#DDD6FE", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = true, fg = "#E8D4B0", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = true, fg = "#99BBBD", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsString", { default = true, fg = "#BAE6FD", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = true, fg = "#D1D5DB", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = true, fg = "#9CA3AF", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, fg = "#fdb095", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsObject", { default = true, fg = "#FFFFFF", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsKey", { default = true, fg = "#E5E7EB", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsNull", { default = true, fg = "#DDD6FE", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = true, fg = "#BF7471", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = true, fg = "#FCA5A5", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = true, fg = "#FECDD3", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, fg = "#FBC19D", bold = true })
vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, fg = "#FECDD3", bold = true })
vim.api.nvim_set_hl(0, "NavicText", { default = true, fg = "#BAE6FD", bold = true })
vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, fg = "#f5b3b3", bold = true })

-- plugin reload
r("plugin-config.lualine")
r("plugin-config.todo-comments")
r("plugin-config.fidget")
r("plugin-config.telescope")
