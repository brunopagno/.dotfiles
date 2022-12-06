local M = {}
local fn = vim.fn

--[[
for this setup to work it's necessary to have
- golang
- gopls
- GOPATH in the path

I use asdf-vm to install go

gopls can be installed by running:
$ go install golang.org/x/tools/gopls@latest

and the export path can be set by:
export PATH=$PATH:$(go env GOPATH)/bin

--]]

function M.setup(base)
  require("lspconfig")["gopls"].setup(vim.tbl_extend("force", base, {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true
        }
      }
    }
  }))
end

return M

