return {
	"akinsho/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim",
		"mfussenegger/nvim-dap",
	},
	config = function()
		local flutter_tools = require("flutter-tools")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		flutter_tools.setup({
			ui = {
				border = "rounded",
				notification_style = "native",
			},
			decorations = {
				statusline = {
					app_version = true,
					device = true,
					project_config = false,
				},
			},
			debugger = {
				enabled = true,
				run_via_dap = true,
				exception_breakpoints = {},
				register_configurations = function(paths)
					local dap = require("dap")
					dap.configurations.dart = {
						{
							type = "dart",
							request = "launch",
							name = "Launch Flutter App",
							dartSdkPath = paths.dart_sdk,
							flutterSdkPath = paths.flutter_sdk,
							program = "${workspaceFolder}/lib/main.dart",
							cwd = "${workspaceFolder}",
						},
						{
							type = "dart",
							request = "attach",
							name = "Attach to Flutter Process",
							dartSdkPath = paths.dart_sdk,
							flutterSdkPath = paths.flutter_sdk,
							cwd = "${workspaceFolder}",
						},
					}
				end,
			},
			fvm = true,
			widget_guides = {
				enabled = true,
			},
			closing_tags = {
				highlight = "Comment",
				prefix = "// ",
				enabled = true,
			},
			dev_log = {
				enabled = true,
				notify_errors = true,
				open_cmd = "tabedit",
			},
			dev_tools = {
				autostart = false,
				auto_open_browser = false,
			},
			outline = {
				open_cmd = "30vnew",
				auto_open = false,
			},
			lsp = {
				color = {
					enabled = true,
					background = true,
					foreground = false,
					virtual_text = true,
					virtual_text_str = "■",
				},
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					local opts = { buffer = bufnr, silent = true }

					vim.keymap.set("n", "<leader>Fs", "<cmd>FlutterRun<CR>",
						vim.tbl_extend("force", opts, { desc = "Flutter: Start/Run" }))
					vim.keymap.set("n", "<leader>Fd", "<cmd>FlutterDevices<CR>",
						vim.tbl_extend("force", opts, { desc = "Flutter: Select Device" }))
					vim.keymap.set("n", "<leader>Fe", "<cmd>FlutterEmulators<CR>",
						vim.tbl_extend("force", opts, { desc = "Flutter: Select Emulator" }))
					vim.keymap.set("n", "<leader>Fr", "<cmd>FlutterReload<CR>",
						vim.tbl_extend("force", opts, { desc = "Flutter: Hot Reload" }))
					vim.keymap.set("n", "<leader>FR", "<cmd>FlutterRestart<CR>",
						vim.tbl_extend("force", opts, { desc = "Flutter: Hot Restart" }))
					vim.keymap.set("n", "<leader>Fq", "<cmd>FlutterQuit<CR>",
						vim.tbl_extend("force", opts, { desc = "Flutter: Quit" }))
					vim.keymap.set("n", "<leader>Fl", "<cmd>FlutterDevLog<CR>",
						vim.tbl_extend("force", opts, { desc = "Flutter: Dev Log" }))
					vim.keymap.set("n", "<leader>Fo", "<cmd>FlutterOutlineToggle<CR>",
						vim.tbl_extend("force", opts, { desc = "Flutter: Toggle Outline" }))
					vim.keymap.set("n", "<leader>Fp", "<cmd>FlutterPubGet<CR>",
						vim.tbl_extend("force", opts, { desc = "Flutter: Pub Get" }))
					vim.keymap.set("n", "<leader>FP", "<cmd>FlutterPubUpgrade<CR>",
						vim.tbl_extend("force", opts, { desc = "Flutter: Pub Upgrade" }))
					vim.keymap.set("n", "<leader>Ft", "<cmd>FlutterDevTools<CR>",
						vim.tbl_extend("force", opts, { desc = "Flutter: Open DevTools" }))
					vim.keymap.set("n", "<leader>Fc", "<cmd>FlutterCopyProfilerUrl<CR>",
						vim.tbl_extend("force", opts, { desc = "Flutter: Copy Profiler URL" }))
					vim.keymap.set("n", "<leader>Fv", "<cmd>FlutterVisualDebug<CR>",
						vim.tbl_extend("force", opts, { desc = "Flutter: Visual Debug Toggle" }))
				end,
				settings = {
					showTodos = true,
					completeFunctionCalls = true,
					renameFilesWithClasses = "prompt",
					enableSnippets = true,
					updateImportsOnRename = true,
				},
			},
		})

		require("telescope").load_extension("flutter")

		vim.keymap.set("n", "<leader>Ff", "<cmd>Telescope flutter commands<CR>",
			{ desc = "Flutter: Telescope Commands" })
	end,
}
