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
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
}
vim.lsp.enable("luals")

-- TypeScript/JavaScript
vim.lsp.config["tsserver"] = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	root_markers = { "package.json", ".git" },
	on_attach = function(client, bufnr)
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
