require('ryn/plugins') -- plugins download
require('pluginssetup/setup') -- plugins config
require('ryn/settings') -- vim settings
require('ryn/keymaps') -- keymaps
require('lsp/ls-setup') -- setting up language servers

-- reload lua files
local lua_dirs = vim.fn.glob("./lua/*", 0, 1)
for _, dir in ipairs(lua_dirs) do
	dir = string.gsub(dir, "./lua/", "")
	require("plenary.reload").reload_module(dir)
end
