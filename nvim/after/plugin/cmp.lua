local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expan(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<c-space>'] = cmp.mapping.complete(),
    ['<c-e>'] = cmp.mapping.abort(),
    ['<cr>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'nvim_lsp' },
  }),
})
