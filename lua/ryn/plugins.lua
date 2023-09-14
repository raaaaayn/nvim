local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup({
				function(use)
					-- Treesitter
					use(
							{
									'nvim-treesitter/nvim-treesitter',
									run = ':TSUpdate',
							}
					)
					-- Treesitter playground
					use 'nvim-treesitter/playground'

					-- Telescope
					use 'nvim-lua/popup.nvim'
					use 'nvim-lua/plenary.nvim'
					use 'nvim-telescope/telescope.nvim'
					use 'kyazdani42/nvim-web-devicons' --File type icons
					use {
							'kyazdani42/nvim-tree.lua',
							requires = {
									'kyazdani42/nvim-web-devicons', -- optional, for file icons
							},
							tag = 'nightly' -- optional, updated every week. (see issue #1193)
					} --NerdTree alternative

					-- Faster telescope search algorithm
					use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

					use {
							'VonHeikemen/lsp-zero.nvim',
							branch = 'v1.x',
							requires = {
									-- LSP Support
									{ 'neovim/nvim-lspconfig' },
									{ 'williamboman/mason.nvim' },
									{ 'williamboman/mason-lspconfig.nvim' },

									-- Autocompletion
									{ 'hrsh7th/nvim-cmp' },
									{ 'hrsh7th/cmp-nvim-lsp' },
									{ 'hrsh7th/cmp-buffer' },
									{ 'hrsh7th/cmp-path' },
									{ 'saadparwaiz1/cmp_luasnip' },
									{ 'hrsh7th/cmp-nvim-lua' },

									-- Snippets
									{ 'L3MON4D3/LuaSnip' },
									{ 'rafamadriz/friendly-snippets' },
							}
					}

					-- use("github/copilot.vim")

					-- LSP auto format
					use('jose-elias-alvarez/null-ls.nvim')

					-- Autocomplete symbols
					use 'onsails/lspkind.nvim'

					-- Flutter tools
					use { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim' }

					-- Live server
					use 'barrett-ruth/live-server.nvim'

					-- Themes
					use 'ajmwagar/vim-deus'
					use 'fratajczak/one-monokai-vim'
					use 'joshdick/onedark.vim'
					use { "catppuccin/nvim", as = "catppuccin" }

					use {
							'nvim-lualine/lualine.nvim',
							requires = { 'kyazdani42/nvim-web-devicons', opt = true }
					}

					use("theprimeagen/harpoon")

					-- Util
					use 'mattn/emmet-vim' --emmet
					--use 'jiangmiao/auto-pairs' -- closes brackets
					use 'tpope/vim-commentary' -- makes commenting easy
					use 'airblade/vim-gitgutter' -- shows git changes in files
					use { 'akinsho/git-conflict.nvim', tag = "*", config = function()
						require('git-conflict').setup()
					end } --  merge conflict resolver
					use 'tpope/vim-fugitive' --git add remove commit push rebase etc all without ever having to leave vim
					use 'idanarye/vim-merginal'
					use 'diepm/vim-rest-console' --very much like vscode rest extension, make http requests from vim
					use({
							"iamcco/markdown-preview.nvim",
							run = "cd app && npm install",
							setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
							ft = { "markdown" },
					}) -- vim markdown preview
					use { 'norcalli/nvim-colorizer.lua', config = function()
						require 'colorizer'.setup()
					end }
					--use 'Yggdroot/indentLine' --shows line indents
					-- use({ 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }) -- pretty buffer tabs
				end,
		})
