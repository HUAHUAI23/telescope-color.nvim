vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end
vim.opt.background = "dark"
require("nvim-tundra").setup({
	transparent_background = true,
	plugins = {
		lsp = true,
		treesitter = true,
		cmp = true,
		context = true,
		dbui = true,
		gitsigns = true,
		telescope = true,
	},
	syntax = {
		booleans = { bold = true, italic = true },
		comments = { bold = true, italic = true },
		conditionals = {},
		constants = { bold = true },
		fields = {},
		functions = { bold = true },
		keywords = {},
		loops = {},
		numbers = { bold = true },
		operators = { bold = true },
		punctuation = {},
		strings = { italic = true },
		types = { italic = true },
	},
})

local colorscheme = "tundra"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
	return
end
local reload_module = function(module_name, starts_with_only)
	-- Default to starts with only
	if starts_with_only == nil then
		starts_with_only = true
	end

	-- TODO: Might need to handle cpath / compiled lua packages? Not sure.
	-- more info: https://github.com/nvim-lua/plenary.nvim/blob/master/lua/plenary/reload.lua
	local matcher
	if not starts_with_only then
		matcher = function(pack)
			return string.find(pack, module_name, 1, true)
		end
	else
		local module_name_pattern = vim.pesc(module_name)
		matcher = function(pack)
			return string.find(pack, "^" .. module_name_pattern)
		end
	end

	-- Handle impatient.nvim automatically.
	local luacache = (_G.__luacache or {}).cache

	for pack, _ in pairs(package.loaded) do
		if matcher(pack) then
			package.loaded[pack] = nil

			if luacache then
				luacache[pack] = nil
			end
		end
	end
end

local r = function(module_name, config_path, starts_with_only)
	reload_module(module_name, starts_with_only)
	local ok, _ = pcall(require, config_path or module_name)
	if not ok then
		print("Error loading " .. config_path or module_name)
		return
	end
end

-- plugin reload
r("bufferline", "plugin-config.bufferline")
r("lualine", "plugin-config.lualine")
r("todo-comments", "plugin-config.todo-comments")
r("fidget", "plugin-config.fidget")
r("telescope", "plugin-config.telescope")
-- vim.cmd([[
--     highlight FidgetTitle ctermbg=None guibg=None
--     highlight FidgetTask guibg=None guifg=#111827
--     ]])

-- vim.cmd([[
--     highlight clear FidgetTitle
--     highlight clear FidgetTask
--     ]])
-- vim.cmd([[
--     highlight FidgetTitle ctermbg=None guibg=None guifg=#bae6fd gui=bold
--     highlight FidgetTask ctermbg=None guibg=None guifg=#111827 gui=bold
--     ]])

-- transparent background
-- api.nvim_set_hl(0, "NormalFloat", { fg = "#F9FAFB", bg = "none" })
-- api.nvim_set_hl(0, "NormalNC", { fg = "#F9FAFB", bg = "none" })
-- api.nvim_set_hl(0, "Normal", { fg = "#F9FAFB", bg = "none" })
--
-- api.nvim_set_hl(0, "Folded", { fg = "#6B7280", bg = "none" })
-- api.nvim_set_hl(0, "StatusLine", { fg = "#E5E7EB", bg = "none" })
-- api.nvim_set_hl(0, "StatusLineNC", { fg = "#F9FAFB", bg = "none" })
-- api.nvim_set_hl(0, "WinBar", { ctermfg = 142, fg = "#bae6fd", bg = "none", bold = true })
-- api.nvim_set_hl(0, "WinBarNC", { ctermfg = 142, fg = "#bae6fd", bg = "none", bold = true })

-- editor
-- ------------------------------
vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#F9FAFB", bg = "#2C323B" })
vim.api.nvim_set_hl(0, "NormalNC", { fg = "#F9FAFB", bg = "#2C323B" })
vim.api.nvim_set_hl(0, "Normal", { fg = "#F9FAFB", bg = "#2C323B" })
vim.api.nvim_set_hl(0, "NonText", { ctermfg = 142, fg = "grey50", bold = true })

-- api.nvim_set_hl(0, "FloatBorder", { fg = "#f3a0a0", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#bae6fd", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "VertSplit", { bg = "none", ctermbg = "none", fg = "#bae6fd", bold = true })
-- api.nvim_set_hl(0, "VertSplit", { bg = "none", ctermbg = "none", fg = "#f3a0a0", bold = true })

-- api.nvim_set_hl(0, "CursorLine", { bg = "#f3a0a0", fg = "#6b7280", bold = true })
-- api.nvim_set_hl(0, "CursorLine", { bg = "#f3a0a0", fg = "#FFFFFF", bold = true })
-- api.nvim_set_hl(0, "CursorLine", { bg = "#f3a0a0" })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#b5e8b0", fg = "#6b7280", bold = true })
-- don't display the colorcolumn
vim.cmd("highlight clear ColorColumn")

-- ----------------------------------
-- dashboard
-- api.nvim_set_hl(0, "DashboardHeader", { fg = "#f5b3b3", bold = true })
-- api.nvim_set_hl(0, "DashboardCenter", { fg = "#f5b3b3", bold = true })
-- api.nvim_set_hl(0, "DashboardFooter", { fg = "#f5b3b3", bold = true })
vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#bae6fd", bold = true })
vim.api.nvim_set_hl(0, "DashboardCenter", { fg = "#bae6fd", bold = true })
vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#bae6fd", bold = true })

-- lualine
vim.api.nvim_set_hl(0, "lualine_a_normal", { fg = "#F7F7F7", bg = "#f3a0a0", bold = true })
vim.api.nvim_set_hl(0, "lualine_b_normal", { fg = "#f3a0a0", bg = "#000000", bold = true })

-- bufferline
-- api.nvim_set_hl(0, "BufferLineCloseButton", { fg = "#f3a0a0", bold = true })
vim.api.nvim_set_hl(0, "BufferLineTabClose", { fg = "#f3a0a0", bold = true })
vim.api.nvim_set_hl(0, "BufferLineSeparator", { fg = "#f3a0a0", bold = true })
vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = "#f3a0a0", bold = true, italic = true })
vim.api.nvim_set_hl(0, "BufferLineCloseButtonSelected", { fg = "#f3a0a0", bold = true })

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

-- cmp
-- sunset
-- #355c7d #725a7a #c56c86 #ff7582 #E5958e #fdb095
--
