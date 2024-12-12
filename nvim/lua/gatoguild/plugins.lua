local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- general dependencies
	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"javascript",
				"typescript",
				"ruby",
			},
			highlight = {
				enable = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	-- ui and theme
	{
		"jacoborus/tender.vim",
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tender]])
		end,
	},
	{
		"crispgm/nvim-tabline",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional
		config = true,
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		config = function()
			local indentscope = require("mini.indentscope")
			indentscope.setup({
				draw = {
					delay = 0,
					animation = indentscope.gen_animation.none(),
				},
				symbol = "│",
			})
		end,
	},

	-- finder and search
	{
		"stevearc/oil.nvim",
		opts = {
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				["<C-h>"] = false,
				["<C-l>"] = false,
			},
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { "node_modules/.*", ".git/.*" },
				},
				pickers = {
					find_files = {
						hidden = true,
					},
					buffers = {
						mappings = {
							i = {
								["<c-x>"] = actions.delete_buffer,
							},
						},
					},
				},
			})
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			lspconfig.ts_ls.setup({})
			lspconfig.ruby_lsp.setup({})
			-- lspconfig.solargraph.setup({})
		end,
	},
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				eruby = { "erb_lint" },
				typescript = { "eslint_d" },
				javascript = { "eslint_d" },
			}

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "eslint_d" },
					typescript = { "eslint_d" },
					ruby = { "rubocop" },
				},
			})
		end,
	},

	-- autocompletions
	{ "L3MON4D3/LuaSnip" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-buffer" },
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<c-space>"] = cmp.mapping.complete(),
					["<c-e>"] = cmp.mapping.abort(),
					["<c-s>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},

	-- git
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},
})
