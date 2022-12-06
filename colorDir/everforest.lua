local api = vim.api

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.g.everforest_background = "soft"
vim.g.everforest_better_performance = 1
vim.g.everforest_enable_italic = 1
vim.g.everforest_disable_italic_comment = 1
vim.g.everforest_transparent_background = 1
vim.g.everforest_diagnostic_text_highlight = 1
vim.g.everforest_diagnostic_line_highlight = 1
vim.g.everforest_diagnostic_virtual_text = "colored"
local colorscheme = "everforest"
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
api.nvim_set_hl(0, "NormalFloat", { ctermfg = 223, ctermbg = 237, fg = "#d3c6aa", bg = "#2C323B" })
api.nvim_set_hl(0, "NormalNC", { fg = "#F9FAFB", bg = "#2C323B" })
api.nvim_set_hl(0, "Normal", { ctermfg = 223, fg = "#d3c6aa", bg = "#2C323B" })
api.nvim_set_hl(0, "NonText", { ctermfg = 142, fg = "grey50", bold = true })
api.nvim_set_hl(0, "FloatBorder", { ctermfg = 245, ctermbg = 237, fg = "#d3c6aa", bg = "none" })

api.nvim_set_hl(0, "CursorLineNr", { ctermfg = 108, fg = "#83c092", bold = true })

-- don't display the colorcolumn
vim.cmd("highlight clear ColorColumn")
-- ------

-- syntax
api.nvim_set_hl(0, "Function", { ctermfg = 142, fg = "#a7c080", bold = true })

-- plugin reload
r("plugin-config.lualine")
r("plugin-config.todo-comments")
r("plugin-config.fidget")
r("plugin-config.nvim-treesitter")
r("plugin-config.telescope")

-- todo-comments
vim.cmd([[
    highlight TodoFgTODO guifg=#add8e6
    highlight TodoBgTODO gui=bold guifg=#2c323b guibg=#add8e6
    ]])
