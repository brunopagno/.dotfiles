-- #####################################
-- LSP configuration
-- #####################################

local servers = {
  lua_ls = { bin = "lua-language-server", install = "mise use -g lua-language-server" },
  ruby_lsp = { bin = "ruby-lsp", install = "gem install ruby-lsp" },
  tsc = { bin = "tsc", install = "mise use -g npm:typescript@7" }, -- TS 7 native (Go) server
  eslint = { bin = "vscode-eslint-language-server", install = "mise use -g npm:vscode-langservers-extracted" },
}

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { library = { vim.env.VIMRUNTIME } },
    },
  },
})

vim.lsp.config("eslint", {
  filetypes = {
    "javascript", "javascriptreact", "typescript", "typescriptreact",
    "json", "jsonc", "css",
  },
})

-- #####################################
-- auto install lang servers
-- #####################################
local missing = {}
for name, server in pairs(servers) do
  if vim.fn.executable(server.bin) == 1 then
    vim.lsp.enable(name)
  elseif vim.fn.executable(server.install:match("^%S+")) == 1 then
    table.insert(missing, name)
  end
end

-- install one at a time: concurrent `mise use -g` runs race on the global config
local function install_next()
  local name = table.remove(missing, 1)
  if not name then
    return
  end
  local server = servers[name]
  vim.notify("installing " .. name)
  vim.system({ "sh", "-c", server.install }, { text = true }, function(out)
    vim.schedule(function()
      if out.code ~= 0 then
        vim.notify(("failed to install %s:\n%s"):format(name, out.stderr or ""), vim.log.levels.ERROR)
      elseif vim.fn.executable(server.bin) == 0 then
        vim.notify(("installed %s, but %s is not on PATH"):format(name, server.bin), vim.log.levels.WARN)
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
