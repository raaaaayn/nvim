require("mason").setup()
require("mason-lspconfig").setup({
	automatic_installation = true,
})

require("telescope")

require("nvim-treesitter.configs").setup {
	ensure_installed = "all",
	sync_install = false,
	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	-- List of parsers to ignore installing (for "all")
	ignore_install = { "javascript" },

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		-- disable = { "c", "rust" },
		-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
		-- disable = function(lang, buf)
		--     local max_filesize = 100 * 1024 -- 100 KB
		--     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
		--     if ok and stats and stats.size > max_filesize then
		--         return true
		--     end
		-- end,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
}
-- local ft_to_parser = require"nvim-treesitter.parsers".filetype_to_parsername
-- ft_to_parser.ino = "c" -- using c parser for .ino

require("lualine").setup()
-- require("bufferline").setup{
-- 	options = {
-- 		separator_style = "padded_slant",
-- 		mode = "tabs",
-- 		diagnostics = "nvim_lsp",
-- 		show_buffer_icons = false, -- disable filetype icons for buffers
-- 		show_buffer_default_icon = false, -- whether or not an unrecognised filetype should show a default icon
-- 		show_buffer_close_icons = false,
-- 		show_close_icon = false,
-- 	}
-- }
require("lualine").setup({
	-- options = { theme = 'horizon' }
	options = { theme = 'onedark' }
})
require("nvim-tree").setup()
require("flutter-tools").setup {
	lsp = {
		on_attach = function(client, buffr)
			local bufopts = { noremap = true, silent = true, buffer = buffr }
			vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
			vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
			vim.keymap.set("n", "n[", vim.diagnostic.goto_prev, bufopts)
			vim.keymap.set("n", "n]", vim.diagnostic.goto_next, bufopts)
			vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, bufopts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
		end,
	}
} -- use defaults

require('live-server').setup()
