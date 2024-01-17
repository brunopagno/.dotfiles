-- Options

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.ruler = true
vim.opt.signcolumn = "yes"
vim.opt.showtabline = 2
vim.opt.mouse = "nv"
vim.opt.termguicolors = true

vim.opt.backup = false
vim.opt.swapfile = false

-- Keymap

local opts = { noremap = true, silent = true }

local function set(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = " "

set("n", "<leader>w-", "<cmd>split<cr>")
set("n", "<leader>w\\", "<cmd>vsplit<cr>")
set("n", "<leader>/", "<cmd>noh<cr>")
set("n", "<leader>z", "<cmd>set wrap!<cr>")

-- navigation
set("n", "<up>", "<cmd>wincmd k<cr>")
set("n", "<down>", "<cmd>wincmd j<cr>")
set("n", "<left>", "<cmd>wincmd h<cr>")
set("n", "<right>", "<cmd>wincmd l<cr>")

-- resize
set({ "t", "n" }, "<M-up>", "<cmd>resize +10<cr>")
set({ "t", "n" }, "<M-down>", "<cmd>resize -10<cr>")
set("n", "<M-right>", "<cmd>vertical resize +10<cr>")
set("n", "<M-left>", "<cmd>vertical resize -10<cr>")

-- copy to clipboard
set("v", "<leader>y", '"+y')

-- move lines
set("n", "<s-up>", "<cmd>m-2<cr>")
set("n", "<s-down>", "<cmd>m+<cr>")

-- Telescope
set("n", "<leader>p", "<cmd>Telescope find_files<cr>")
set("n", "<leader>F", "<cmd>Telescope live_grep<cr>")

-- LSP
set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<cr>")
set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
set("n", "<f2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
set("n", "<f4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")

-- file navigation
set("n", "<leader>e",
  function()
    local cur_win = vim.api.nvim_get_current_win()

    local ui = vim.api.nvim_list_uis()[1]

    local width = ui.width - 50
    local height = ui.height - 10

    local opts = {
      relative = "editor",
      width = width,
      height = height,
      col = (ui.width / 2) - (width / 2),
      row = (ui.height / 2) - (height / 2),
      anchor = "NW",
      border = "rounded",
    }

    local win = vim.api.nvim_open_win(0, true, opts)
    vim.cmd("Explore")

    local buf = vim.api.nvim_get_current_buf()
    local close_keys = { '<esc>', '<leader>e' }

    local fegr = vim.api.nvim_create_augroup("file_explorer", { clear = true })
    vim.api.nvim_create_autocmd({"BufEnter"}, {
      command = "lua set_buffer_and_close(" .. win .. ", " .. buf .. ")",
    })

    for _, key in ipairs(close_keys) do
      vim.api.nvim_buf_set_keymap(buf, 'n', key, '<cmd>q<cr>', { noremap = true, silent = true })
    end
  end
)

function set_buffer_and_close(win, buf)
  vim.api.nvim_win_set_buf(win, buf)
  vim.cmd("autocmd! file_explorer")
  vim.cmd("q")
end

vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25
vim.g.netrw_banner = 0

-- terminal
set("n", "<C-t>", function() show_split("term") end)
set("t", "<esc>", "<c-\\><c-n>")
set("t", "<C-t>", function() hide_split("term") end)
set("t", "<C-a>",
  function()
    local bufnr = vim.fn.bufnr("#")
    local filepath = vim.api.nvim_buf_get_name(bufnr)
    
    vim.fn.feedkeys(filepath)
  end
)

-- commands
local TERM_NAME = "splittermin"

local fixed_splits = {
  term = {
    name = "splittermin",
    size = 18,
    pos = "bottom",
    cmd = function() vim.cmd("terminal") end,
    show = function() vim.cmd("startinsert") end,
  },
}

function show_split(key)
  local split = fixed_splits[key]

  local buf = vim.fn.bufnr(split.name)
  if buf == -1 then
    do_show(split)
  else
    local win = vim.fn.bufwinnr(buf)

    if win == -1 then
      do_show(split, buf)
    else
      vim.cmd(win .. "wincmd w")
      if split.show then
        split.show()
      end
    end
  end
end

function do_show(split, buf)
  if split.pos == "left" then
    vim.cmd("vsplit")
    vim.cmd("wincmd h")
    vim.cmd("vertical resize " .. split.size)
  else
   vim.cmd("split")
   vim.cmd("wincmd j")
   vim.cmd("resize " .. split.size)
  end

  if buf then
    vim.cmd("buffer " .. buf)
  else
    split.cmd()
    vim.cmd("file " .. split.name)
  end

  if split.show then
    split.show()
  end
end

function hide_split(key)
  local split = fixed_splits[key]
  local current = vim.fn.bufnr("%")

  if current == vim.fn.bufnr(split.name) then
    vim.cmd("q")
  end
end

require("gatoguild.plugins")

