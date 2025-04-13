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
		"rebelot/kanagawa.nvim",
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme kanagawa-dragon]])
		end,
	},
	{
		"echasnovski/mini.indentscope",
		version = "*",
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
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			winopts = {
				preview = {
					layout = "vertical",
				},
			},
			file_ignore_patterns = {
				"vendor",
			},
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
			},
		},
	},

	-- LSP
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
					go = { "goimports", "gofmt" },
					sql = { "sql_formatter" },
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
					["<c-y>"] = cmp.mapping.confirm({ select = true }),
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

	-- copiloto
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_filetypes = { ["*"] = false }
		end,
	},
})
