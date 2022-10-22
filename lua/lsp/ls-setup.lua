local lspconfig = require("lspconfig")

vim.diagnostic.config({
	-- float = { source = "always", border = border },
	virtual_text = false,
	signs = true,
})

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

local function lsp_keymaps(client, buffr)
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	-- vim.api.nvim_create_autocmd("CursorHold", {
	-- 	buffer = bufnr,
	-- 	callback = function()
	-- 		local opts = {
	-- 			focusable = false,
	-- 			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
	-- 			border = 'rounded',
	-- 			source = 'always',
	-- 			prefix = ' ',
	-- 			scope = 'cursor',
	-- 		}
	-- 		vim.diagnostic.open_float(nil, opts)
	-- 	end
	-- })
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "n[", vim.diagnostic.goto_prev, bufopts)
	vim.keymap.set("n", "n]", vim.diagnostic.goto_next, bufopts)
	vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, bufopts)
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

	clangd = {
		cmd = {
			"clangd",
			"--background-index",
			"--suggest-missing-includes",
			"--clang-tidy",
			"--header-insertion=iwyu",
		},
		-- Required for lsp-status
		init_options = {
			clangdFileStatus = true,
		},
		handlers = nvim_status and nvim_status.extensions.clangd.setup() or nil,
	},

	rust_analyzer = {
		cmd = { "rustup", "run", "nightly", "rust-analyzer" },
		-- cmd = { "rust-analyzer" },
	},

	cssls = true,
	tsserver = true,
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

require("null-ls").setup({
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.formatting()<CR>")

      -- format on save
      vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")
    end

    if client.server_capabilities.documentRangeFormattingProvider then
      vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")
    end
  end,
})

require("prettier").setup({
  bin = 'prettier', -- or `'prettierd'` (v0.22+)
    cli_options = {
    arrow_parens = "always",
    bracket_spacing = true,
    bracket_same_line = false,
    embedded_language_formatting = "auto",
    end_of_line = "lf",
    html_whitespace_sensitivity = "css",
    -- jsx_bracket_same_line = false,
    jsx_single_quote = false,
    print_width = 80,
    prose_wrap = "preserve",
    quote_props = "as-needed",
    semi = true,
    single_attribute_per_line = false,
    single_quote = false,
    tab_width = 2,
    trailing_comma = "es5",
    use_tabs = false,
    vue_indent_script_and_style = false,
  },
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
})
