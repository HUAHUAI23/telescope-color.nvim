local Color23 = require("color-manage")
local color231
local opts = {}
return require("telescope").register_extension({
	setup = function(ext_config, config)
		-- access extension config and user config
		ext_config = ext_config or {}
		config = config or {}
		config.colorDir = ext_config.colorDir or vim.fn.stdpath("data") .. "/colorDir"
		config.cwd = ext_config.colorDir or vim.fn.stdpath("data") .. "/colorDir"
		config.colors = ext_config.colors
		color231 = Color23:new(ext_config)
		for key, value in pairs(config) do
			opts[key] = value
		end
	end,
	exports = {
		color23 = function()
			color231:start(opts)
		end,
	},
})
