-- Soft wrapping settings
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.textwidth = 120
vim.opt_local.breakindent = true

-- Clear and set formatoptions correctly
vim.opt_local.formatoptions = vim.opt_local.formatoptions - { "a", "o" } -- Remove problematic flags
vim.opt_local.formatoptions = vim.opt_local.formatoptions + { "t", "r", "n" } -- Add list continuation

-- Disable all automatic indentation
vim.opt_local.autoindent = false
vim.opt_local.smartindent = false
vim.opt_local.cindent = false
vim.opt_local.indentexpr = "" -- No indent expression

-- Custom Enter key behavior with string return
vim.keymap.set("i", "<CR>", function()
	local line = vim.api.nvim_get_current_line()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local col = cursor[2] -- Cursor column (0-based)
	local indent = line:match("^%s*") or "" -- Capture current indentation

	-- Check if the line is a blank list item
	if line:match("^%s*%d+%.%s*$") and col >= #line then
		-- Blank numbered list: e.g., "7. "
		return "<CR>" .. indent
	elseif line:match("^%s*[-*]%s*$") and col >= #line then
		-- Blank bullet list: e.g., "- "
		return "<CR>" .. indent
	elseif line:match("^%s*- %[%s*[x ]?%]%s*$") and col >= #line then
		-- Blank checkbox list: e.g., "- [ ] "
		return "<CR>" .. indent
	end

	-- Continue list if there’s content
	if line:match("^%s*%d+%. %w") and col >= #line then
		-- Numbered list: e.g., "1. asdf"
		local num_str = line:match("^%s*(%d+)%.")
		local num = num_str and (tonumber(num_str) + 1) or 1
		return "<CR>" .. indent .. num .. ". "
	elseif line:match("^%s*[-*] %w") and col >= #line then
		-- Bullet list: e.g., "- asdf"
		return "<CR>" .. indent .. "- "
	elseif line:match("^%s*- %[%s*[x ]?%] %w") and col >= #line then
		-- Checkbox list: e.g., "- [ ] asdf"
		return "<CR>" .. indent .. "- [ ] "
	end

	-- For non-list lines or anything else, just insert a new line with same indent
	return "<CR>" .. indent
end, { buffer = true, expr = true, silent = true })
