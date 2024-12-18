return {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",

        -- see below for full list of optional dependencies 👇
    },
    notes_subdir = "inbox",
    new_notes_location = "notes_subdir",


    disable_frontmatter = true,
    templates = {
        subdir = "Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M:%S",
    },
    opts = {
        workspaces = {
            {
                name = "Main",
                path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Main",
            }
        },

        -- see below for full list of options 👇
    },
    mappings = {
        ["gf"] = {
            action = function()
                return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
        },
        ["<leader>ti"] = {
            action = function()
                return require("obsidian").util.toggle_checkbox()
            end,
            opts = { buffer = true },
        },
    },
    completion = {
        nvim_cmp = true,
        min_chars = 2,
    },
    ui = {
        -- Disable some things below here because I set these manually for all Markdown files using treesitter
        checkboxes = { },
        bullets = {  },
    },
}
