local M = {}
local fn = vim.fn

--[[
for this setup to work it's necessary to have
- ruby
- solargraph gem

I use asdf-vm to install the language

And solargraph can be obtained through:
$ gem install solargraph

--]]

function M.setup(base)
  require("lspconfig")["solargraph"].setup(vim.tbl_extend("force", base,  {
    settings = {
      solargraph = {
        diagnostics = true
      }
    }
  }))
end

return M

