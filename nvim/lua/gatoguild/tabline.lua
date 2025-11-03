vim.o.tabline = "%!v:lua.CustomTabLine()"
function _G.CustomTabLine()
	local s = ""
	local sep = "│"
	local tab_count = vim.fn.tabpagenr("$")
	for i = 1, vim.fn.tabpagenr("$") do
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
