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

-- TypeScript/JavaScript
vim.lsp.config["ts_ls"] = {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
}
vim.lsp.enable("ts_ls")

-- vscode-langservers-extracted
vim.lsp.config["eslint"] = {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = {
    "javascript", "javascriptreact", "typescript", "typescriptreact",
    "json", "jsonc", "css",
  },
  root_markers = {
    "eslint.config.mjs", "eslint.config.js", "eslint.config.cjs",
    ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json",
    "package.json", ".git",
  },
  settings = {
    validate = "on",
    useESLintClass = false,
    experimental = { useFlatConfig = false },
    codeAction = {
      disableRuleComment = { enable = true, location = "separateLine" },
      showDocumentation = { enable = true },
    },
    codeActionOnSave = { enable = false, mode = "all" },
    format = true,
    quiet = false,
    onIgnoredFiles = "off",
    rulesCustomizations = {},
    run = "onType",
    problems = { shortenToSingleLine = false },
    nodePath = "",
    workingDirectory = { mode = "location" },
  },
  on_init = function(client)
    local workspace = client.workspace_folders and client.workspace_folders[1]
    if workspace then
      client.settings.workspaceFolder = {
        uri = workspace.uri,
        name = workspace.name,
      }
    end
  end,
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

-- Rust
vim.lsp.config["rust-analyzer"] = {
  cmd = { "rustup", "run", "stable", "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json" },
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = true,
      check = { command = "clippy" },
      cargo = { buildScripts = { enable = true } },
      procMacro = { enable = true },
    },
  },
}
vim.lsp.enable("rust-analyzer")
