-- Lua
vim.lsp.config["luals"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
}
vim.lsp.enable("luals")

vim.lsp.config["stylua"] = {
	cmd = { "stylua", "--lsp" },
	filetypes = { "lua" },
	root_markers = { ".stylua.toml", "stylua.toml", ".editorconfig" },
}
vim.lsp.enable("stylua")

-- TypeScript/JavaScript
vim.lsp.config["tsserver"] = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	root_markers = { "package.json", ".git" },
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false

		vim.api.nvim_buf_create_user_command(bufnr, "OrganizeImports", function()
			vim.lsp.buf.code_action({
				context = {
					only = { "source.organizeImports" },
					diagnostics = {},
				},
				apply = true,
			})
		end, { desc = "Organize imports" })
	end,
}
vim.lsp.enable("tsserver")

-- vscode-langservers-extracted
vim.lsp.config["eslint"] = {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	workspace_required = true,
	root_dir = function(bufnr, on_dir)
		local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", ".git" }
		on_dir(vim.fs.root(bufnr, root_markers))
	end,
	settings = {
		validate = "on",
		packageManager = nil,
		experimental = {
			useFlatConfig = false,
		},
		format = true,
		quiet = false,
		run = "onType",
		problems = {
			shortenToSingleLine = false,
		},
		nodePath = ".",
		workingDirectory = { mode = "auto" },
	},
}
vim.lsp.enable("eslint")

-- Ruby
vim.lsp.config["ruby-lsp"] = {
	cmd = { "ruby-lsp" },
	filetypes = { "ruby", "eruby" },
	root_markers = { ".git", ".rubocop.yml", "Gemfile" },
	settings = {
		ruby = {
			formatter = "auto",
		},
	},
}
vim.lsp.enable("ruby-lsp")
