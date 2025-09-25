vim.cmd("setlocal wrap linebreak")
vim.cmd("setlocal spell spelllang=en_us")
vim.opt_local.textwidth = 0
vim.opt_local.breakindent = true

-- Debug current settings after a delay
--vim.defer_fn(function()
--  print("Current wrap settings:")
--  print("wrap: " .. tostring(vim.wo.wrap))
--  print("linebreak: " .. tostring(vim.wo.linebreak))
--  print("textwidth: " .. vim.bo.textwidth)
--end, 500)

-- Configure nvim-cmp for Obsidian with reduced noise
local cmp_ok, cmp = pcall(require, 'cmp')
if cmp_ok then
	cmp.setup.buffer({
		sources = cmp.config.sources({
			{ name = "obsidian", keyword_length = 2 },
			{ name = "obsidian_new", keyword_length = 2 },
			{ name = "obsidian_tags", keyword_length = 2 },
			{ name = "path", keyword_length = 3 },
			-- Removed buffer, lsp, snippets to reduce noise
		}),
		completion = {
			keyword_length = 2, -- Require at least 2 characters before showing completions
		}
	})
end

-- Let obsidian handle <cr> mapping, use different key for list continuation
vim.keymap.set("i", "<M-CR>", function()
	local line = vim.api.nvim_get_current_line()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local col = cursor[2]
	local indent = line:match("^%s*") or ""

	-- Check if the line is a blank list item
	if line:match("^%s*%d+%.%s*$") and col >= #line then
		return "<CR>" .. indent
	elseif line:match("^%s*[-*]%s*$") and col >= #line then
		return "<CR>" .. indent
	elseif line:match("^%s*- %[%s*[x ]?%]%s*$") and col >= #line then
		return "<CR>" .. indent
	end

	-- Continue list if there's content
	if line:match("^%s*%d+%. %w") and col >= #line then
		local num_str = line:match("^%s*(%d+)%.")
		local num = num_str and (tonumber(num_str) + 1) or 1
		return "<CR>" .. indent .. num .. ". "
	elseif line:match("^%s*[-*] %w") and col >= #line then
		return "<CR>" .. indent .. "- "
	elseif line:match("^%s*- %[%s*[x ]?%] %w") and col >= #line then
		return "<CR>" .. indent .. "- [ ] "
	end

	return "<CR>" .. indent
end, { buffer = true, expr = true, silent = true })
