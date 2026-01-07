-- Dart/Flutter buffer settings
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true

-- Dart uses 80 character line width by default
-- vim.opt_local.colorcolumn = "80"

-- Treesitter-based folding (useful for large widget trees)
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt_local.foldenable = false
vim.opt_local.foldlevel = 99
