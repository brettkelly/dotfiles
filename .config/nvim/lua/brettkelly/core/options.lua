vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- Turn off search highlights when entering insert mode
vim.api.nvim_create_autocmd({'InsertEnter','CursorMoved'}, {
  callback = function()
    vim.cmd('nohlsearch')
  end
})

-- Markdown 
vim.api.nvim_create_autocmd('FileType', {
    pattern = "markdown",
    callback = function()
        -- Enable auto-formatting
        vim.opt_local.formatoptions:append("r") -- Auto-insert comment leader after <Enter>
        vim.opt_local.formatoptions:append("o") -- Auto-insert comment leader after o/O
        vim.opt_local.formatoptions:append("n") -- Recognize numbered lists
        vim.opt_local.formatoptions:append("j") -- Remove comment leader when joining lines
        
        -- Set list indent settings
        vim.opt_local.autoindent = true
        vim.opt_local.smartindent = true
        
        -- Enhance list behavior
        vim.opt_local.comments = "b:*,b:-,b:+,n:>"
        vim.opt_local.commentstring = "<!-- %s -->"
    end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Local mappings for lists
    vim.keymap.set("i", "<CR>", function()
      local line = vim.api.nvim_get_current_line()
      local cursor = vim.api.nvim_win_get_cursor(0)
      local col = cursor[2]
      
      -- Check if we're in a list
      if line:match("^%s*[-*+]%s") or line:match("^%s*%d+%.%s") then
        -- If the line is empty except for the list marker, remove it
        if line:match("^%s*[-*+]%s*$") or line:match("^%s*%d+%.%s*$") then
          vim.api.nvim_set_current_line("")
          return "<CR>"
        end
        return "<CR>" .. line:match("^%s*[-%*%+%d%.]+ ")
      end
      return "<CR>"
    end, { buffer = true, expr = true })
  end,
})
