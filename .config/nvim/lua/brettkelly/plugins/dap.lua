return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap-python",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-telescope/telescope-dap.nvim",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Set up UI
		dapui.setup()

		-- Automatically open/close the DAP UI when starting/stopping debugging
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- Python configuration
		require("dap-python").setup("python") -- Use your Python path here

		-- PHP configuration
		dap.adapters.php = {
			type = "executable",
			command = "node",
			args = { vim.fn.stdpath("data") .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js" },
		}

		dap.configurations.php = {
			{
				type = "php",
				request = "launch",
				name = "Listen for Xdebug",
				port = 9003,
				pathMappings = {
					["/var/www/html"] = "${workspaceFolder}",
				},
			},
		}

		-- Key mappings
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/Continue debugging" })
		vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate debugging" })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
		vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
		vim.keymap.set("n", "<leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Set conditional breakpoint" })
	end,
}
