vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj"})

keymap.set("n","<leader>nh", ":nohlsearch<CR>", { desc = "Clear search highlights", silent = true })
keymap.set("n","<ESC>", ":nohlsearch<CR>", { desc = "Clear search highlights", silnent = true })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- yank to system clipboard
keymap.set({"n","v"}, "<leader>y", [["+y]])

keymap.set("i", "<leader>bb", "{<CR><CR>}<ESC>ki<TAB>", { desc = "Curly braces" })

-- Obsidian
-- Open today's daily note
vim.keymap.set('n', '<leader>td', function()
    local today = os.date("%Y-%m-%d")
    local daily_path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Main/daily/" .. today .. ".md"
    local expanded_path = vim.fn.expand(daily_path)
    vim.cmd('edit ' .. expanded_path)
end, { desc = 'Jump to today\'s daily note' })

-- Search daily notes with telescope
vim.keymap.set('n', '<leader>fd', function()
    local daily_notes_path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Main/daily"
    require('telescope.builtin').find_files({
        prompt_title = "Daily Notes",
        cwd = vim.fn.expand(daily_notes_path),
        hidden = false,
        sorting_strategy = "descending",
        file_ignore_patterns  = {
            "^[^.]+$",  -- ignore files without extensions
            "%.%w+$",   -- ignore all files with extensions
            "!%.md$"    -- except .md files
        }
    })
end, { desc = 'Find daily notes' })
