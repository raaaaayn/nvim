require('ryn/plugins') -- plugins download
require('lsp/ls-setup') -- setting up language servers
require('pluginssetup/setup') -- plugins config
require('ryn/settings') -- vim settings
require('ryn/keymaps') -- keymaps

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
