local colorscheme = "everforest"

local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
  vim.notify("colorscheme " .. colorscheme .. " was not found")
  return
else
  vim.opt.background = 'dark'
  vim.g.everforest_background = 'soft'
  vim.g.everforest_better_performance = 1
end

