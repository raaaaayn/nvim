local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

vim.diagnostic.config({
		-- float = { source = "always", border = border },
		virtual_text = false,
		signs = true,
})

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

local function lsp_keymaps(client, buffr)
	local bufopts = { noremap = true, silent = true, buffer = buffr }
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	-- vim.keymap.set("n", "tgd", tab split | vim.lsp.buf.definition(), bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "n[", vim.diagnostic.goto_prev, bufopts)
	vim.keymap.set("n", "n]", vim.diagnostic.goto_next, bufopts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
end

local servers = {
		bashls = true,
		eslint = true,
		-- graphql = true,
		html = true,
		pyright = true,
		vimls = true,
		yamlls = true,
		sumneko_lua = true,
		jdtls = true,
		-- dartls = true, -- handled by flutter-tools
		clangd = true,
		arduino_language_server = {
				cmd = {
						"arduino-language-server",
						"-cli-config",
						"/home/day/.arduino15/arduino-cli.yaml",
						"-fqbn", "arduino:avr:uno",
						"-cli", "arduino-cli",
						"-clangd", "clangd"
				}
		},
		sqlls = true,
		-- npm i -g vscode-langservers-extracted
		jsonls = true,
		-- yay -S phpactor
		phpactor = true,
		-- npm install -g intelephense
		intelephense = true,
		rust_analyzer = {
				cmd = { "rustup", "run", "nightly", "rust-analyzer" },
				-- cmd = { "rust-analyzer" },
		},
		cssls = true,
		tsserver = true,
		-- npm install -g @tailwindcss/language-server
		tailwindcss = true,
		-- npm install -g @astrojs/language-server
		astro = true
}

local setup_server = function(server, config)
	if not config then
		return
	end

	if type(config) ~= "table" then
		config = {}
	end

	config = vim.tbl_deep_extend("force", {
					on_attach = lsp_keymaps,
					flags = {
							debounce_text_changes = 150,
					},
			}, config)

	lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
	setup_server(server, config)
end

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
