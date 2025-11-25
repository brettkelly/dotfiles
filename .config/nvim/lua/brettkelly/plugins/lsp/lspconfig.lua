return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"mason-org/mason.nvim",
	},
	config = function()
		-- Get capabilities for all servers from nvim-cmp
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Disable diagnostic handler for PHP (too noisy)
		vim.lsp.handlers["textDocument/diagnostic"] = function() end

		-- Helper function to find LSP command dynamically
		local function find_lsp_cmd(cmd_name)
			local mason_bin = vim.fn.expand("~/.local/share/nvim/mason/bin/" .. cmd_name)
			if vim.fn.executable(mason_bin) == 1 then
				return mason_bin
			end
			if vim.fn.executable(cmd_name) == 1 then
				return cmd_name
			end
			local brew_paths = {
				"/opt/homebrew/bin/" .. cmd_name,
				"/usr/local/bin/" .. cmd_name,
			}
			for _, path in ipairs(brew_paths) do
				if vim.fn.executable(path) == 1 then
					return path
				end
			end
			return cmd_name
		end

		-- Configure servers using vim.lsp.config (Neovim 0.11+)
		vim.lsp.config("intelephense", {
			cmd = { find_lsp_cmd("intelephense"), "--stdio" },
			capabilities = capabilities,
			on_init = function(client)
				local original_supports_method = client.supports_method
				client.supports_method = function(method)
					if method == "textDocument/diagnostic" then
						return false
					end
					return original_supports_method(method)
				end
			end,
			filetypes = { "php" },
			settings = {
				intelephense = {
					stubs = {
						"apache",
						"bcmath",
						"bz2",
						"calendar",
						"Core",
						"composer",
						"curl",
						"date",
						"dom",
						"mysqli",
						"wordpress",
						"wordpress-globals",
						"woocommerce",
						"wp-cli",
						"standard",
						"gravityforms",
					},
					files = {
						maxSize = 5000000,
						associations = { "*.php", "*.phtml", "*.inc", "*.theme", "*.module" },
					},
					diagnostics = {
						enable = true,
						undefinedFunctions = true,
						undefinedConstants = true,
						undefinedClassConstants = true,
						undefinedMethods = true,
						undefinedProperties = true,
						undefinedTypes = true,
					},
					completion = {
						insertUseDeclaration = true,
						fullyQualifyGlobalConstantsAndFunctions = false,
						triggerParameterHints = true,
					},
					workspace = { root = true },
				},
			},
		})

		vim.lsp.config("phpactor", {
			capabilities = capabilities,
			filetypes = { "php" },
		})

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
				},
			},
		})

		vim.lsp.config("html", { capabilities = capabilities })
		vim.lsp.config("cssls", { capabilities = capabilities })

		vim.lsp.config("svelte", {
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
					end,
				})
			end,
		})

		vim.lsp.config("graphql", {
			capabilities = capabilities,
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})

		vim.lsp.config("emmet_ls", {
			capabilities = capabilities,
			filetypes = {
				"html",
				"typescriptreact",
				"javascriptreact",
				"css",
				"sass",
				"scss",
				"less",
				"svelte",
			},
		})

		vim.lsp.config("pyright", { capabilities = capabilities })
		vim.lsp.config("tailwindcss", { capabilities = capabilities })

		-- Enable all configured servers
		vim.lsp.enable({
			"intelephense",
			"phpactor",
			"lua_ls",
			"html",
			"cssls",
			"svelte",
			"graphql",
			"emmet_ls",
			"pyright",
			"tailwindcss",
		})

		-- LSP attach keymaps
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local keymap = vim.keymap.set

				keymap("n", "gR", "<cmd>Telescope lsp_references<CR>", { buffer = ev.buf, desc = "Show LSP references" })
				keymap("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to declaration" })
				keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { buffer = ev.buf, desc = "Show LSP definitions" })
				keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { buffer = ev.buf, desc = "Show LSP implementations" })
				keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { buffer = ev.buf, desc = "Show LSP type definitions" })
				keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "See available code actions" })
				keymap("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Smart rename" })
				keymap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { buffer = ev.buf, desc = "Show buffer diagnostics" })
				keymap("n", "<leader>d", vim.diagnostic.open_float, { buffer = ev.buf, desc = "Show line diagnostics" })
				keymap("n", "[d", vim.diagnostic.goto_prev, { buffer = ev.buf, desc = "Go to previous diagnostic" })
				keymap("n", "]d", vim.diagnostic.goto_next, { buffer = ev.buf, desc = "Go to next diagnostic" })
				keymap("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Show documentation for what is under cursor" })
				keymap("n", "<leader>rs", ":LspRestart<CR>", { buffer = ev.buf, desc = "Restart LSP" })
			end,
		})

		-- Configure diagnostics symbols
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end
	end,
}
