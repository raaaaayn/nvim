require('ryn')

require('onedark').load()

local cfg = vim.g.onedark_config

require('onedark').setup {
	style = 'dark',
	colors = {
		deus_orange = "#fe8019",
		deus_black = "#242a32",
		deus_red = "#d54e53",
		deus_green = "#98c379",
		deus_yellow = "#e5c07b",
		deus_blue = "#83a598",
		deus_purple = "#c678dd",
		deus_teal = "#70c0ba",
		deus_white = "#eaeaea",
		deus_bright_black = "#666666",
		deus_bright_red = "#ec3e45",
		deus_bright_green = "#90c966",
		deus_bright_yellow = "#edbf69",
		deus_bright_blue = "#73ba9f",
		deus_bright_purple = "#c858e9",
		deus_bright_teal = "#2bcec2",
		deus_bright_white = "#ffffff",
		deus_background = "#2c323b",
		deus_foreground = "#eaeaea",

		black = "#181a1f",
		bg0 = "#282c34",
		bg1 = "#31353f",
		bg2 = "#393f4a",
		bg3 = "#3b3f4c",
		bg_d = "#21252b",
		bg_blue = "#73b8f1",
		bg_yellow = "#ebd09c",
		fg = "#abb2bf",
		purple = "#c678dd",
		green = "#98c379",
		orange = "#d19a66",
		blue = "#61afef",
		yellow = "#e5c07b",
		cyan = "#56b6c2",
		red = "#e86671",
		grey = "#5c6370",
		light_grey = "#848b98",
		dark_cyan = "#2b6f77",
		dark_red = "#993939",
		dark_yellow = "#93691d",
		dark_purple = "#8a3fa0",
		diff_add = "#31392b",
		diff_delete = "#382b2c",
		diff_change = "#1c3448",
		diff_text = "#2c5372",

		my_fg = "#e1e3e4"
	},
	highlights = {
		-- ["@diff.add"] = colors.Green,
		-- ["@diff.delete"] = colors.Red,
		-- ["@error"] = colors.Fg,
		Directory = { fg = '$deus_green' },
		BufferCurrentSign = { fg = '$deus_green' },
		DiffviewFilePanelTitle = { fg = '$deus_green', fmt = "bold" },
		DiffviewFilePanelCounter = { fg = '$deus_bright_blue', fmt = "bold" },
		DiffviewFilePanelFileName = { fg = '$deus_foreground' },
		TelescopeMatching = { fg = '$deus_orange', fmt = "bold" },
		TelescopeNormal = { fg = '$deus_foreground' },
		TelescopeBorder = { fg = '$deus_foreground' },
		["@attribute.typescript"] = { fg = '$deus_green' },
		["@keyword"] = { fg = '$deus_red', fmt = cfg.code_style.keywords },
		["@keyword.conditional"] = { fg = '$deus_red', fmt = cfg.code_style.keywords },
		["@keyword.import"] = { fg = '$deus_red' },
		["@keyword.directive"] = { fg = '$deus_red' },
		["@keyword.exception"] = { fg = '$deus_red' },
		["@keyword.function"] = { fg = '$deus_red', fmt = cfg.code_style.functions },
		["@keyword.operator"] = { fg = '$deus_red', fmt = cfg.code_style.keywords },
		["@keyword.repeat"] = { fg = '$deus_red', fmt = cfg.code_style.keywords },
		["@function"] = { fg = '$deus_green', fmt = cfg.code_style.functions },
		["@function.builtin"] = { fg = '$deus_green', fmt = cfg.code_style.functions },
		["@function.macro"] = { fg = '$deus_green', fmt = cfg.code_style.functions },
		["@function.method"] = { fg = '$deus_green', fmt = cfg.code_style.functions },
		["@number"] = { fg = '$deus_purple' },
		["@number.float"] = { fg = '$deus_purple' },
		["@boolean"] = { fg = '$deus_purple' },
		["@variable"] = { fg = '$my_fg', fmt = cfg.code_style.variables },
	}
}
require('onedark').load()

-- reload lua files
local lua_dirs = vim.fn.glob("./lua/*", 0, 1)
for _, dir in ipairs(lua_dirs) do
	dir = string.gsub(dir, "./lua/", "")
	require("plenary.reload").reload_module(dir)
end

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
	group = yank_group,
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({
			higroup = 'IncSearch',
			timeout = 40,
		})
	end,
})
