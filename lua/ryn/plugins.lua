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
			tag = 'nightly'               -- optional, updated every week. (see issue #1193)
		}                               --NerdTree alternative

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
		-- use('jose-elias-alvarez/null-ls.nvim')

		-- Autocomplete symbols
		use 'onsails/lspkind.nvim'

		-- Flutter tools
		use { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim' }

		-- Live server
		use 'barrett-ruth/live-server.nvim'

		-- Themes
		use 'ajmwagar/vim-deus'
		use 'fratajczak/one-monokai-vim'
		use 'navarasu/onedark.nvim'
		use { "catppuccin/nvim", as = "catppuccin" }

		use {
			'nvim-lualine/lualine.nvim',
			requires = { 'kyazdani42/nvim-web-devicons', opt = true }
		}

		-- use("theprimeagen/harpoon")

		-- Util
		use 'mattn/emmet-vim'      --emmet
		--use 'jiangmiao/auto-pairs' -- closes brackets
		use 'airblade/vim-gitgutter' -- shows git changes in files

		use {
			"NeogitOrg/neogit",
			dependencies = {
				"nvim-lua/plenary.nvim", -- required
				"sindrets/diffview.nvim", -- optional - Diff integration

				-- Only one of these is needed, not both.
				"nvim-telescope/telescope.nvim", -- optional
				"ibhagwan/fzf-lua",          -- optional
			},
			config = function()
				require('neogit').setup()
			end
		}
		use {
			"sindrets/diffview.nvim",
			config = function()
				require('diffview').setup(
					{
						view = {
							-- Configure the layout and behavior of different types of views.
							-- Available layouts:
							--  'diff1_plain'
							--    |'diff2_horizontal'
							--    |'diff2_vertical'
							--    |'diff3_horizontal'
							--    |'diff3_vertical'
							--    |'diff3_mixed'
							--    |'diff4_mixed'
							-- For more info, see ':h diffview-config-view.x.layout'.
							default = {
								layout = "diff3_mixed",
							},
							merge_tool = {
								-- Config for conflicted files in diff views during a merge or rebase.
								layout = "diff3_mixed",
							},
						},
					}
				)
			end
		}

		use {
			'akinsho/git-conflict.nvim',
			tag = "*",
			config = function()
				require('git-conflict').setup()
			end
		}                        --  merge conflict resolver
		use 'tpope/vim-commentary' -- makes commenting easy
		use 'tpope/vim-abolish'
		use 'tpope/vim-fugitive' -- git add remove commit push rebase etc all without ever having to leave vim
		use 'tpope/vim-rhubarb'  -- GBrowse for github
		use {                    -- Review Pull Requests
			'pwntester/octo.nvim',
			requires = {
				'nvim-lua/plenary.nvim',
				'nvim-telescope/telescope.nvim',
				'nvim-tree/nvim-web-devicons',
			},
			config = function()
				require "octo".setup()
			end
		}
		use 'idanarye/vim-merginal'
		use 'diepm/vim-rest-console' -- very much like vscode rest extension, make http requests from vim
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
		use {
			"folke/zen-mode.nvim",
			opts = {
				plugins = {
					tmux = { enabled = false }, -- disables the tmux statusline
					alacritty = {
						enabled = true,
						font = "14", -- font size
			},
		}
			}
		}
		use {
			"folke/trouble.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" }
		}
	end,

})
