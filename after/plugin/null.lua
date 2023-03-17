local null_ls = require("null-ls");

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
		sources = {
				require("null-ls").builtins.formatting.prettierd.with({
						extra_filetypes = { "astro" },
				})
		},
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format()
						end,
				})
			end
		end,
})