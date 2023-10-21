-- LSP
local lspconfig = require('lspconfig')

-- npm i -g typescript typescript-language-server prettier
lspconfig.tsserver.setup({})

-- ruby gem install solargraph
lspconfig.solargraph.setup({})
lspconfig.rubocop.setup({})
