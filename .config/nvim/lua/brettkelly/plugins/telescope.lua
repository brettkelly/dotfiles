return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				file_ignore_patterns = {
					"^.git/", -- Git directory
					"^node_modules/", -- Node modules if you have any
					"^.DS_Store", -- Mac files
					"%.jpg$",
					"%.jpeg$",
					"%.png$",
					"%.gif$",
					"%.pdf$",
					"%.obsidian/", -- Ignore Obsidian config files
				},
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
				},
				cache_picker = {
					num_pickers = 5,
					limit_entries = 1000,
				},
				hidden = true,
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
				pickers = {
					find_files = {
						hidden = true,
						no_ignore = true,
						follow = true,
						find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		-- keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Show available keymaps" })
		keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "Show available keymaps" })

		keymap.set("n", "<leader>ff", function()
			print(vim.fn.getcwd()) -- This will show the current working directory
			require("telescope.builtin").find_files({
				hidden = true,
				no_ignore = true,
				follow = true,
			})
		end, { desc = "Find files" })

		-- DAP

		telescope.load_extension("dap")
		keymap.set("n", "<leader>dcc", "<cmd>Telescope dap commands<cr>", { desc = "DAP commands" })
		keymap.set("n", "<leader>dcb", "<cmd>Telescope dap list_breakpoints<cr>", { desc = "DAP list breakpoints" })
		keymap.set("n", "<leader>dcv", "<cmd>Telescope dap variables<cr>", { desc = "DAP variables" })
		keymap.set("n", "<leader>dcf", "<cmd>Telescope dap frames<cr>", { desc = "DAP frames" })
	end,
}
