-- Options

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
-- vim.opt.ruler = true
vim.opt.signcolumn = "yes"
vim.opt.showtabline = 2
vim.opt.mouse = "nv"

vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }
vim.opt.autocompletedelay = 100

-- vim.opt.backup = false
vim.opt.swapfile = false

vim.diagnostic.config({
  float = { source = true },
})

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>/", "<cmd>noh<cr>")

-- copy to clipboard
vim.keymap.set("v", "<leader>y", '"+y')

-- navigation
vim.keymap.set("n", "<C-k>", "<cmd>wincmd k<cr>")
vim.keymap.set("n", "<C-j>", "<cmd>wincmd j<cr>")
vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<cr>")
vim.keymap.set("n", "<C-h>", "<cmd>wincmd h<cr>")
vim.keymap.set("n", "<leader>vs", "<cmd>vsplit<cr>")
vim.keymap.set("n", "<leader>ss", "<cmd>split<cr>")
vim.keymap.set("n", "<leader>tt", "<cmd>wincmd T<cr>")
vim.keymap.set("n", "<leader>tc", "<cmd>tabc<cr>")
vim.keymap.set("n", "<C-M-l>", "<cmd>tabn<cr>")
vim.keymap.set("n", "<C-M-h>", "<cmd>tabp<cr>")

-- buffers
vim.keymap.set("n", "<leader>q", "<cmd>bd<cr>")
vim.keymap.set("n", "<leader>cfp", "<cmd>call setreg('+', expand('%:.'))<cr>")

-- search and find
vim.keymap.set("n", "<leader>p", "<cmd>FzfLua files<cr>")
vim.keymap.set("n", "<leader>,", "<cmd>FzfLua buffers<cr>")
vim.keymap.set("n", "<leader>F", "<cmd>FzfLua live_grep<cr>")

-- format, LSP and lint
vim.keymap.set({ "n", "v" }, "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end)
-- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
-- vim.keymap.set("n", "<f2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
-- vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>")
vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
-- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
vim.keymap.set("i", "<C-space>", function() vim.lsp.completion.get() end)


-- file navigation
vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>")


-- #####################################
-- tabline
-- #####################################

vim.o.tabline = "%!v:lua.CustomTabLine()"
function _G.CustomTabLine()
	local s = ""
	local sep = "│"
	local tab_count = vim.fn.tabpagenr("$")
	for i = 1, tab_count do
		local winnr = vim.fn.tabpagewinnr(i)
		local buflist = vim.fn.tabpagebuflist(i)
		local bufnr = buflist[winnr]
		local name = vim.fn.bufname(bufnr)
		local fname = name ~= "" and vim.fn.fnamemodify(name, ":t") or "[No Name]"
		local modified = vim.fn.getbufvar(bufnr, "&modified") == 1 and "+ " or ""
		if i == vim.fn.tabpagenr() then
			s = s .. "%#TabLineSel#"
			s = s .. " " .. modified .. "[" .. fname .. "] "
		else
			s = s .. "%#TabLine#"
			s = s .. " " .. modified .. fname .. " "
		end
		if tab_count > 1 and i < tab_count then
			s = s .. sep
		end
	end
	s = s .. "%#TabLineFill#"
	return s
end

-- #####################################
-- LSP
-- #####################################

require("lsp")

-- #####################################
-- plugins
-- #####################################

vim.pack.add({
  -- ui
  "https://github.com/echasnovski/mini.icons",
  "https://github.com/echasnovski/mini.indentscope",

  -- files and search
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/ibhagwan/fzf-lua",

  -- git
  "https://github.com/lewis6991/gitsigns.nvim",
})

require("mini.icons").setup()

local indentscope = require("mini.indentscope")
indentscope.setup({
  draw = { delay = 0, animation = indentscope.gen_animation.none() },
  symbol = "│",
})

require("oil").setup({
  view_options = { show_hidden = true },
  keymaps = { ["<C-h>"] = false, ["<C-l>"] = false },
})

require("fzf-lua").setup({
  winopts = { preview = { layout = "vertical" } },
  file_ignore_patterns = { "vendor" },
  keymap = { fzf = { ["ctrl-q"] = "select-all+accept" } },
})

-- vim.cmd([[colorscheme default]])
