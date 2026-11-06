-- #####################################
-- LSP configuration
-- #####################################

local servers = {
  luals = {
    install = "mise use -g lua-language-server",
    config = {
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          workspace = { library = { vim.env.VIMRUNTIME } },
        },
      },
    },
  },

  ruby_lsp = {
    install = "gem install ruby-lsp",
    config = {
      cmd = { "ruby-lsp" },
      filetypes = { "ruby", "eruby" },
      root_markers = { "Gemfile", ".rubocop", ".git" },
      settings = {
        ruby = {
          formatter = "auto",
        },
      },
    },
  },

  -- TypeScript 7's native (Go) compiler ships its own language server
  tsc = {
    install = "mise use -g npm:typescript@7",
    config = {
      cmd = { "tsc", "--lsp", "--stdio" },
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
    },
  },

  eslint = {
    install = "mise use -g npm:vscode-langservers-extracted",
    config = {
      cmd = { "vscode-eslint-language-server", "--stdio" },
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "jsonc", "css", },
      root_markers = {
        "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs", "eslint.config.ts",
        ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json", "package.json", ".git",
      },
      settings = {
        validate = "on",
        run = "onType",
        format = true,
        quiet = false,
        nodePath = "",
        onIgnoredFiles = "off",
        rulesCustomizations = {},
        workingDirectory = { mode = "location" },
        problems = { shortenToSingleLine = false },
        codeAction = {
          disableRuleComment = { enable = true, location = "separateLine" },
          showDocumentation = { enable = true },
        },
        experimental = { useFlatConfig = false },
      },
    },
  },
}

-- #####################################
-- auto install lang servers
-- #####################################
local missing = {}
for name, server in pairs(servers) do
  vim.lsp.config(name, server.config)
  if vim.fn.executable(server.config.cmd[1]) == 1 then
    vim.lsp.enable(name)
  else
    table.insert(missing, name)
  end
end

-- install one at a time: concurrent `mise use -g` runs race on the global config
local function install_next()
  local name = table.remove(missing, 1)
  if not name then
    return
  end
  local command = servers[name].config.cmd[1]
  vim.notify("installing " .. name)
  vim.system({ "sh", "-c", servers[name].install }, { text = true }, function(out)
    vim.schedule(function()
      if out.code ~= 0 then
        vim.notify(("failed to install %s:\n%s"):format(name, out.stderr or ""), vim.log.levels.ERROR)
      elseif vim.fn.executable(command) == 0 then
        vim.notify(("installed %s, but %s is not on PATH"):format(name, command), vim.log.levels.WARN)
      else
        vim.notify("installed " .. name)
        vim.lsp.enable(name)
      end
      install_next()
    end)
  end)
end
install_next()

-- #####################################
-- native completion
-- #####################################
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not (client and client:supports_method("textDocument/completion")) then
      return
    end
    vim.lsp.completion.enable(true, client.id, ev.buf)
    vim.bo[ev.buf].complete = "o"
    vim.bo[ev.buf].autocomplete = true
  end,
})
