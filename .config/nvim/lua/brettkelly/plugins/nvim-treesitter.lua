return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "c","python", "php", "sql", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html","markdown","markdown_inline" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end,
    opts = {
        indent = { enable = true },
        highlight = { enable = true }
    }
 }
