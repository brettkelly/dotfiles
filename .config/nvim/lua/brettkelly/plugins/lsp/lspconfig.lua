return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim", -- Ensure this loads before lspconfig
		"mason-org/mason.nvim", -- Explicit dependency
	},
	config = function()
		-- Import lspconfig first
		local lspconfig = require("lspconfig")

		-- Get capabilities for all servers
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Manually setup each server we care about
		-- PHP with intelephense
		vim.lsp.handlers["textDocument/diagnostic"] = function() end
		lspconfig.intelephense.setup({
			cmd = { "/opt/homebrew/bin/intelephense", "--stdio" },
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

		lspconfig.phpactor.setup({
			capabilities = capabilities,
			filetypes = { "php" },
		})

		-- Lua
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
				},
			},
		})

		-- HTML, CSS, JS, TS
		lspconfig.html.setup({ capabilities = capabilities })
		lspconfig.cssls.setup({ capabilities = capabilities })
		-- lspconfig.tsserver.setup({ capabilities = capabilities })

		-- Svelte
		lspconfig.svelte.setup({
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

		-- GraphQL
		lspconfig.graphql.setup({
			capabilities = capabilities,
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})

		-- Emmet
		lspconfig.emmet_ls.setup({
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

		-- Python
		lspconfig.pyright.setup({ capabilities = capabilities })

		-- Tailwind CSS
		lspconfig.tailwindcss.setup({ capabilities = capabilities })

		-- LSP attach keymaps
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }
				local keymap = vim.keymap.set

				keymap(
					"n",
					"gR",
					"<cmd>Telescope lsp_references<CR>",
					{ buffer = ev.buf, desc = "Show LSP references" }
				)
				keymap("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to declaration" })
				keymap(
					"n",
					"gd",
					"<cmd>Telescope lsp_definitions<CR>",
					{ buffer = ev.buf, desc = "Show LSP definitions" }
				)
				keymap(
					"n",
					"gi",
					"<cmd>Telescope lsp_implementations<CR>",
					{ buffer = ev.buf, desc = "Show LSP implementations" }
				)
				keymap(
					"n",
					"gt",
					"<cmd>Telescope lsp_type_definitions<CR>",
					{ buffer = ev.buf, desc = "Show LSP type definitions" }
				)
				keymap(
					{ "n", "v" },
					"<leader>ca",
					vim.lsp.buf.code_action,
					{ buffer = ev.buf, desc = "See available code actions" }
				)
				keymap("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Smart rename" })
				keymap(
					"n",
					"<leader>D",
					"<cmd>Telescope diagnostics bufnr=0<CR>",
					{ buffer = ev.buf, desc = "Show buffer diagnostics" }
				)
				keymap("n", "<leader>d", vim.diagnostic.open_float, { buffer = ev.buf, desc = "Show line diagnostics" })
				keymap("n", "[d", vim.diagnostic.goto_prev, { buffer = ev.buf, desc = "Go to previous diagnostic" })
				keymap("n", "]d", vim.diagnostic.goto_next, { buffer = ev.buf, desc = "Go to next diagnostic" })
				keymap(
					"n",
					"K",
					vim.lsp.buf.hover,
					{ buffer = ev.buf, desc = "Show documentation for what is under cursor" }
				)
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
