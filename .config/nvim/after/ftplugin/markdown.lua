-- Enable auto-formatting
vim.opt_local.formatoptions:append("r") -- Auto-insert comment leader after <Enter>
vim.opt_local.formatoptions:append("o") -- Auto-insert comment leader after o/O
vim.opt_local.formatoptions:append("n") -- Recognize numbered lists

-- Checkbox behavior
vim.keymap.set("i", "<CR>", function()
    local line = vim.api.nvim_get_current_line()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local col = cursor[2]
    
    -- Check specifically for checkbox pattern
    local checkbox_pattern = "^%s*-%s*%[%s?%]%s*"
    
    if line:match(checkbox_pattern) then
        -- If the line is empty except for the checkbox, remove it
        if line:match(checkbox_pattern .. "$") then
            vim.api.nvim_set_current_line("")
            return "<CR>"
        end
        -- Otherwise, create a new checkbox
        local indent = line:match("^%s*")
        return "<CR>" .. indent .. "- [ ] "
    end
    
    return "<CR>"
end, { buffer = true, expr = true })
