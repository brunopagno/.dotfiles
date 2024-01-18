-- Init

-- local sgr = vim.api.nvim_create_augroup("startup", {})
-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--   group = sgr,
--   callback = function(ev)
--     vim.api.nvim_del_augroup_by_id(sgr)
--
--     if vim.fn.isdirectory(ev.file) == 1 then
--       local startup_buf = vim.api.nvim_create_buf(false, true)
--
--       vim.api.nvim_buf_set_lines(startup_buf, 0, -1, false, {
--         "<leader>e to open the file explorer",
--         "<leader>p to open the file finder",
--       })
--       vim.api.nvim_set_current_buf(startup_buf)
--     end
--   end
-- })

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

    local win_opts = {
      relative = "editor",
      focusable = false,
      width = width,
      height = height,
      col = (ui.width / 2) - (width / 2),
      row = (ui.height / 2) - (height / 2),
      anchor = "NW",
      border = "single",
    }

    local fewin = vim.api.nvim_open_win(0, true, win_opts)
    vim.cmd("Explore")

    local febuf = vim.api.nvim_win_get_buf(fewin)

    local close_keys = { '<esc>', '<leader>e' }

    local fegr = vim.api.nvim_create_augroup("file_explorer", {})
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      group = fegr,
      callback = function(ev)
        vim.api.nvim_del_augroup_by_id(fegr)
        vim.api.nvim_win_set_buf(cur_win, ev.buf)
        vim.cmd("q")
      end
    })

    for _, key in ipairs(close_keys) do
      vim.api.nvim_buf_set_keymap(febuf, 'n', key,
        "<cmd>autocmd! file_explorer | q<cr>",
        { noremap = true, silent = true }
      )
    end
  end
)

vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25
vim.g.netrw_banner = 0

-- terminal
set("n", "<C-t>", function() show_splittermin() end)
set("t", "<esc>", "<c-\\><c-n>")
set("t", "<C-t>", function() hide_splittermin() end)
set("t", "<C-a>",
  function()
    local bufnr = vim.fn.bufnr("#")
    local filepath = vim.api.nvim_buf_get_name(bufnr)

    vim.fn.feedkeys(filepath)
  end
)

-- commands

local splittermin_name = "splittermin"

function show_splittermin()
  local buf = vim.fn.bufnr(splittermin_name)
  if buf == -1 then
    do_show_splittermin()
  else
    local win = vim.fn.bufwinnr(buf)

    if win == -1 then
      do_show_splittermin(buf)
    else
      vim.cmd(win .. "wincmd w")
      vim.cmd("startinsert")
    end
  end
end

function do_show_splittermin(buf)
  vim.cmd("split")
  vim.cmd("wincmd J")
  vim.cmd("resize 18")

  if buf then
    vim.cmd("buffer " .. buf)
  else
    vim.cmd("terminal")
    vim.cmd("file " .. splittermin_name)
  end

  vim.cmd("startinsert")
end

function hide_splittermin()
  local current = vim.fn.bufnr("%")

  if current == vim.fn.bufnr(splittermin_name) then
    vim.cmd("q")
  end
end

require("gatoguild.plugins")
