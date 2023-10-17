require("lualine").setup({
	-- options = { theme = 'horizon' }
	options = { theme = 'onedark' }
})
-- require("nvim-tree").setup()
require("flutter-tools").setup {
	lsp = {
		on_attach = function(client, buffr)
			local bufopts = { noremap = true, silent = true, buffer = buffr }
			vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
			vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
			vim.keymap.set({ "v", "n" }, "<leader>qf", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "n[", vim.diagnostic.goto_prev, bufopts)
			vim.keymap.set("n", "n]", vim.diagnostic.goto_next, bufopts)
			-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format({ async = true }), bufopts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
		end,
	}
} -- use defaults

require('live-server').setup()
