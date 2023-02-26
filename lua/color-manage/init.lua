local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local Color23 = {}
Color23.__index = Color23
function Color23:new(opts)
	opts = opts or {}
	local obj = setmetatable({}, self)
	return obj
end

function Color23:start(opts)
	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "Change Color Theme",
			finder = finders.new_table({
				results = self.colors,
				entry_maker = function(entry)
					return {
						value = entry,
						display = function(tbl)
							return tbl.value[1] .. " " .. tbl.value[2]
						end,
						-- use for sorting
						ordinal = entry[2],
						colorname = entry[2],
					}
				end,
			}),
			attach_mappings = function(prompt_bufnr, map)
				map(
					"n",
					"<cr>",
					-- anonymous function
					-- function()
					-- 	actions.close(prompt_bufnr)
					-- 	local selection = action_state.get_selected_entry()
					-- 	self:loadColorScheme(selection.colorname)
					-- end
					(function()
						local load_color = function()
							actions.close(prompt_bufnr)
							local selection = action_state.get_selected_entry()
							-- load colorscheme
							self:loadColorScheme(selection.colorname)
						end
						return load_color
					end)()
				)
				return true
			end,
		})
		:find()
end

Color23.caseList = {
	["deus"] = function()
		vim.cmd("highlight clear")
		if vim.fn.exists("syntax_on") then
			vim.cmd("syntax reset")
		end
		vim.cmd("syntax clear")
		vim.o.background = "dark"
		vim.g.deus_termcolors = 256
		local colorscheme = "deus"
		local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
		if not status_ok then
			vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
			return
		end
		vim.g.deus_termcolors = 256

		local function set_editor_hl()
			vim.api.nvim_set_hl(0, "NormalFloat", { ctermfg = 223, ctermbg = 235, fg = "#ebdbb2", bg = "#2c323b" })
			vim.api.nvim_set_hl(0, "NonText", { ctermfg = 142, fg = "grey50", bold = true })
			vim.api.nvim_set_hl(0, "Cursor", { bold = true })
			vim.api.nvim_set_hl(0, "SignColumn", { ctermbg = "none", bg = "none" })
			vim.api.nvim_set_hl(0, "VertSplit", { ctermfg = 245, fg = "#928374", bold = true })
			vim.api.nvim_set_hl(0, "Directory", { ctermfg = 142, fg = "#98c379", bold = true })
			vim.api.nvim_set_hl(0, "MoreMsg", { ctermfg = 214, fg = "#fabd2f", bold = true })
			vim.api.nvim_set_hl(0, "Question", { ctermfg = 208, fg = "#fe8019", bold = true })
			vim.api.nvim_set_hl(0, "MatchParen", { ctermbg = 241, bg = "#665c54", bold = true })
			vim.api.nvim_set_hl(
				0,
				"CursorLineNr",
				{ ctermfg = 208, ctermbg = 239, bg = "#242a32", fg = "#fe8019", bold = true }
			)

			vim.api.nvim_set_hl(0, "SpecialKey", { ctermfg = 208, fg = "#fe8019", bold = true })
			vim.api.nvim_set_hl(
				0,
				"Search",
				{ ctermbg = 214, ctermfg = 235, bg = "#B5E8B0", fg = "#808080", bold = true }
			)
			vim.api.nvim_set_hl(0, "Visual", { ctermbg = 241, bg = "#665c54", reverse = true, bold = true })

			vim.api.nvim_set_hl(0, "SpellLocal", {
				undercurl = true,
				ctermbg = 214,
				ctermfg = 235,
				bg = "#B5E8B0",
				fg = "Grey",
				bold = true,
				sp = "#B5E8B0",
			})
			-- #ffa6ff
			vim.api.nvim_set_hl(0, "SpellRare", {
				undercurl = true,
				ctermbg = 214,
				ctermfg = 235,
				bg = "#ff0000",
				fg = "#f5f5f5",
				bold = true,
				sp = "#ff0000",
			})
		end

		local function set_gitsigns_hl()
			vim.api.nvim_set_hl(0, "GitSignsAdd", { ctermfg = 142, ctermbg = 239, bg = "none", fg = "#98c379" })
			vim.api.nvim_set_hl(0, "GitSignsChange", { ctermfg = 108, ctermbg = 239, bg = "none", fg = "#B5E8B0" })
			vim.api.nvim_set_hl(0, "GitSignsDelete", { ctermfg = 167, ctermbg = 239, bg = "none", fg = "#fb4934" })
		end
		local function set_nvimtree_hl()
			vim.api.nvim_set_hl(0, "NvimTreeNormal", { fg = "#928374", bold = true })
			vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#928374", bold = true })
			vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = "#928374", bold = true })
			vim.api.nvim_set_hl(0, "NvimTreeOpenedFile", { fg = "#50de60", bold = true })
			vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", { fg = "#98c379", bold = true })
			vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#98c379", bold = true })
			vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#8094b4", bold = true })
			vim.api.nvim_set_hl(0, "NvimTreeSymlink", { fg = "#00d0c0", bold = true })
			vim.api.nvim_set_hl(0, "NvimTreeImageFile", { fg = "#bb0099", bold = true })
			vim.api.nvim_set_hl(0, "NvimTreeExecFile", { fg = "#50de60", bold = true })
			vim.api.nvim_set_hl(0, "NvimTreeSpecialFile", { fg = "#fe8019", underline = true, bold = true })
			vim.api.nvim_set_hl(0, "NvimTreeBookmark", { fg = "#50de60", bold = true })
			vim.api.nvim_set_hl(0, "NvimTreeLiveFilterPrefix", { fg = "#bb0099", bold = true })
			vim.api.nvim_set_hl(0, "NvimTreeLiveFilterValue", { bold = true })
			vim.api.nvim_set_hl(0, "NvimTreeWindowPicker", { fg = "#ededed", bg = "#4493c8", bold = true })
			vim.api.nvim_set_hl(0, "NvimTreeFileIgnored", { fg = "#928374", bold = true })
			vim.api.nvim_set_hl(0, "NvimTreeGitIgnored", { fg = "#928374", bold = true })
			vim.api.nvim_set_hl(0, "BufferlineCustomeNvimtree", { fg = "#928374", bg = "#181B20", bold = true })
			vim.api.nvim_set_hl(0, "BufferLineOffsetSeparator", { fg = "#181B20", bg = "#181B20", bold = true })
		end
		local function set_navic_hl()
			-- navic
			vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, fg = "#98c379", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, fg = "#bb0099", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, fg = "#A5B4FC", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, fg = "#BAE6FD", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, fg = "#DDD6FE", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = true, fg = "#ffa6ff", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, fg = "#ebdbb2", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, fg = "#D1D5DB", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, fg = "#B5E8B0", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, fg = "#fe8019", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, fg = "#fe8019", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = true, fg = "#B5E8B0", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = true, fg = "#E8D4B0", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = true, fg = "#99BBBD", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsString", { default = true, fg = "#BAE6FD", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = true, fg = "#D1D5DB", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = true, fg = "#fff073", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, fg = "#fdb095", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsObject", { default = true, fg = "#BAE6FD", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsKey", { default = true, fg = "#c678dd", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsNull", { default = true, fg = "#DDD6FE", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = true, fg = "#bb0099", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = true, fg = "#FCA5A5", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = true, fg = "#FECDD3", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, fg = "#FBC19D", bold = true })
			vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, fg = "#ffa6ff", bold = true })
			vim.api.nvim_set_hl(0, "NavicText", { default = true, fg = "#B5E8B0", bold = true })
			vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, fg = "#B5E8B0", bold = true })
		end
		local function set_notify_hl()
			vim.api.nvim_set_hl(0, "NotifyERRORTitle", { ctermfg = 167, fg = "#ff0000", bold = true })
			vim.api.nvim_set_hl(0, "NotifyERRORIcon", { ctermfg = 167, fg = "#ff0000", bold = true })
			vim.api.nvim_set_hl(0, "NotifyERRORBorder", { ctermfg = 167, fg = "#ff0000", bold = true })
			vim.api.nvim_set_hl(0, "NotifyWARNTitle", { ctermfg = 208, fg = "#fe8019", bold = true })
			vim.api.nvim_set_hl(0, "NotifyWARNIcon", { ctermfg = 208, fg = "#fe8019", bold = true })
			vim.api.nvim_set_hl(0, "NotifyWARNBorder", { ctermfg = 208, fg = "#fe8019", bold = true })
			vim.api.nvim_set_hl(0, "NotifyINFOTitle", { ctermfg = 142, fg = "#B5E8B0", bold = true })
			vim.api.nvim_set_hl(0, "NotifyINFOIcon", { ctermfg = 142, fg = "#B5E8B0", bold = true })
			vim.api.nvim_set_hl(0, "NotifyINFOBorder", { ctermfg = 142, fg = "#B5E8B0", bold = true })
		end
		local function set_indenline_hl()
			vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#ebdbb2", bg = "none" })
			vim.api.nvim_set_hl(
				0,
				"IndentBlanklineSpaceCharBlankline",
				{ ctermfg = 142, fg = "#928374", nocombine = true }
			)
			vim.api.nvim_set_hl(0, "IndentBlanklineSpaceChar", { ctermfg = 142, fg = "#928374", nocombine = true })
			vim.api.nvim_set_hl(0, "IndentBlanklineChar", { ctermfg = 142, fg = "#928374", nocombine = true })
		end
		local function set_lsp_hl()
			vim.api.nvim_set_hl(0, "LspReferenceText", { fg = "#B5E8B0" })
			vim.api.nvim_set_hl(0, "LspReferenceRead", { fg = "#B5E8B0" })
			vim.api.nvim_set_hl(0, "LspReferenceWrite", { fg = "#B5E8B0" })
			vim.api.nvim_set_hl(0, "LspCodeLens", { fg = "#928374" })
			vim.api.nvim_set_hl(0, "LspCodeLensSeparator", { fg = "LightGrey" })
			vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { fg = "#ffa6ff" })
			vim.api.nvim_set_hl(0, "DiagnosticError", { ctermfg = 1, fg = "Red", bold = true })
			vim.api.nvim_set_hl(0, "DiagnosticWarn", { ctermfg = 3, fg = "Orange", bold = true })
			vim.api.nvim_set_hl(0, "DiagnosticInfo", { ctermfg = 4, fg = "#add8e6", bold = true })
			vim.api.nvim_set_hl(0, "DiagnosticHint", { ctermfg = 7, fg = "#d3d3d3", bold = true })
			vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { standout = true, strikethrough = true, sp = "Red" })
			vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { standout = true, sp = "Orange" })
		end
		set_editor_hl()
		set_lsp_hl()
		set_gitsigns_hl()
		set_notify_hl()
		set_indenline_hl()
		set_nvimtree_hl()
		set_navic_hl()

		local terminal_colors = {
			terminal_color_0 = "#2C323B",
			terminal_color_1 = "#a80000",
			terminal_color_2 = "#50de60",
			terminal_color_3 = "#fe8019",
			terminal_color_4 = "#83a598",
			terminal_color_5 = "#bb0099",
			terminal_color_6 = "#00d0c0",
			terminal_color_7 = "#928374",
			terminal_color_8 = "#3c3836",
			terminal_color_9 = "#fb4934",
			terminal_color_10 = "#98C379",
			terminal_color_11 = "#fabd2f",
			terminal_color_12 = "#2bff99",
			terminal_color_13 = "#C678DD",
			terminal_color_14 = "#8ec07c",
			terminal_color_15 = "#c0c0c0",
		}
		for k, v in pairs(terminal_colors) do
			vim.g[k] = v
		end
	end,
	["everforest"] = function()
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

		-- editor
		vim.api.nvim_set_hl(0, "NormalFloat", { ctermfg = 223, ctermbg = 237, fg = "#d3c6aa", bg = "#2C323B" })
		vim.api.nvim_set_hl(0, "NormalNC", { fg = "#F9FAFB", bg = "#2C323B" })
		vim.api.nvim_set_hl(0, "Normal", { ctermfg = 223, fg = "#d3c6aa", bg = "#2C323B" })
		vim.api.nvim_set_hl(0, "NonText", { ctermfg = 142, fg = "grey50", bold = true })
		vim.api.nvim_set_hl(0, "FloatBorder", { ctermfg = 245, ctermbg = 237, fg = "#d3c6aa", bg = "none" })
		vim.api.nvim_set_hl(0, "CursorLineNr", { ctermfg = 108, fg = "#83c092", bold = true })
		-- don't display the colorcolumn
		vim.cmd("highlight clear ColorColumn")
		-- ------
		-- syntax
		vim.api.nvim_set_hl(0, "Function", { ctermfg = 142, fg = "#a7c080", bold = true })
		-- navic
		vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, fg = "#FBC19D", bold = true })
		vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, fg = "#FECDD3", bold = true })
		vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, fg = "#A5B4FC", bold = true })
		vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, fg = "#BF7471", bold = true })
		vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, fg = "#DDD6FE", bold = true })
		vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = true, fg = "#BF7471", bold = true })
		vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, fg = "#ebdbb2", bold = true })
		vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, fg = "#D1D5DB", bold = true })
		vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, fg = "#B5E8B0", bold = true })
		vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, fg = "#fe8019", bold = true })
		vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, fg = "#fe8019", bold = true })
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
		vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, fg = "#ffa6ff", bold = true })
		vim.api.nvim_set_hl(0, "NavicText", { default = true, fg = "#ff4090", bold = true })
		vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, fg = "#f5b3b3", bold = true })
		-- todo-comments
		vim.cmd([[
    highlight TodoFgTODO guifg=#add8e6
    highlight TodoBgTODO gui=bold guifg=#2c323b guibg=#add8e6
    ]])
	end,
	["tundra"] = function()
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
		-- editor
		-- ------------------------------
		vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#F9FAFB", bg = "#2C323B" })
		vim.api.nvim_set_hl(0, "NormalNC", { fg = "#F9FAFB", bg = "#2C323B" })
		vim.api.nvim_set_hl(0, "Normal", { fg = "#F9FAFB", bg = "#2C323B" })
		vim.api.nvim_set_hl(0, "NonText", { ctermfg = 142, fg = "grey50", bold = true })
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#bae6fd", bg = "none", bold = true })
		vim.api.nvim_set_hl(0, "VertSplit", { bg = "none", ctermbg = "none", fg = "#bae6fd", bold = true })
		vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#b5e8b0", fg = "#6b7280", bold = true })
		-- don't display the colorcolumn
		vim.cmd("highlight clear ColorColumn")
		-- ------------------------------
		-- dashboard
		vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#bae6fd", bold = true })
		vim.api.nvim_set_hl(0, "DashboardCenter", { fg = "#bae6fd", bold = true })
		vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#bae6fd", bold = true })
		-- lualine
		vim.api.nvim_set_hl(0, "lualine_a_normal", { fg = "#F7F7F7", bg = "#f3a0a0", bold = true })
		vim.api.nvim_set_hl(0, "lualine_b_normal", { fg = "#f3a0a0", bg = "#000000", bold = true })
		-- bufferline
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
	end,
}
function Color23:loadColorScheme(colorscheme)
	if self.caseList[colorscheme] then
		self.caseList[colorscheme]()
	else
		print("Color23:loadColorScheme: no " .. colorscheme)
	end
end

Color23.colors = {
	{ "🥮", "deus" },
	{ "🥮", "everforest" },
	{ "🥮", "tundra" },
}

-- test
-- local abc = Color23:new({})
-- abc:start({})

return Color23
