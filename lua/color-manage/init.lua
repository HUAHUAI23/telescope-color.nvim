local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
-- local ext_config = {
-- 	colors = {
-- 		{ "🥮", "deus", "deus.lua" },
-- 		{ "", "xxx", "xxx.lua" },
-- 	},
-- 	colorDir = "xxxxx",
-- }

local Color23 = {}
Color23.__index = Color23
function Color23:new(opts)
	opts = opts or {}
	local obj = setmetatable({
		colorDir = opts.colorDir or vim.fn.stdpath("data") .. "/colorDir",
	}, self)
	return obj
end
function Color23:start(opts)
	opts = opts or {}
	-- the cwd value should be the same with where the preview file located if not the preview module wouldn't work
	opts.cwd = opts.cwd or vim.fn.stdpath("data") .. "/colorDir"
	opts.colorDir = opts.colorDir or vim.fn.stdpath("data") .. "/colorDir"
	pickers
		.new(opts, {
			prompt_title = "Manage Color Theme",
			finder = finders.new_table({
				-- results = ext_config.colors,
				results = opts.colors,
				entry_maker = function(entry)
					return {
						value = entry,
						display = function(tbl)
							return tbl.value[1] .. " " .. tbl.value[2]
						end,
						cwd = opts.cwd,
						ordinal = entry[2],
						filename = entry[3],
					}
				end,
			}),
			previewer = conf.file_previewer(opts),
			sorter = conf.file_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				map(
					"n",
					"<cr>",
					(function()
						local load_color = function()
							actions.close(prompt_bufnr)
							local selection = action_state.get_selected_entry()
							print(vim.pretty_print(selection))
							-- source colorscheme
							vim.api.nvim_cmd(
								vim.api.nvim_parse_cmd("source " .. opts.colorDir .. "/" .. selection["filename"], {}),
								{}
							)
						end
						return load_color
					end)()
				)
				map(
					"n",
					"d",
					(function()
						local delete_color = function()
							actions.close(prompt_bufnr)
							local selection = action_state.get_selected_entry()
							-- delete color file
							vim.cmd([[!rm ]] .. opts.colorDir .. "/" .. selection["filename"])
						end
						return delete_color
					end)()
				)
				return true
			end,
		})
		:find()
end

-- 	colors = {
-- 		{ "🥮", "deus", "deus.lua" },
-- 		{ "", "xxx", "xxx.lua" },
-- 	},
-- 	colorDir = "xxxxx",

return Color23
