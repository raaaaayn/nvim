require("nvim-treesitter.configs").setup {
	ensure_installed = "all",
	sync_install = false,
	auto_install = true,

	ignore_install = { "javascript" },

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}



-- syntax highlighting for blade files
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.blade = {
	install_info = {
		url = "https://github.com/EmranMR/tree-sitter-blade",
		files = { "src/parser.c" },
		branch = "main",
	},
	filetype = "blade"
}

vim.api.nvim_create_augroup("BladeFiltypeRelated", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.blade.php",
  group = "BladeFiltypeRelated",
  callback = function()
    vim.bo.filetype = "blade"
  end,
})
