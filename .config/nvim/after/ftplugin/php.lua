local function set_up_wordpress_functions()
	-- Create a buffer-local callback for when the server attaches
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			local bufnr = args.buf

			-- Only run for Intelephense
			if client and client.name == "intelephense" then
				-- Adjust diagnostic settings for WordPress development
				vim.diagnostic.config({
					-- Disable virtual_text for undefined functions in WordPress dev
					virtual_text = false,
					-- Show diagnostics in a floating window only when requested
					underline = true,
					update_in_insert = false,
					severity_sort = true,
				}, bufnr)

				-- Optionally filter out certain diagnostics for WordPress functions
				client.server_capabilities.diagnosticProvider = {
					-- This will prevent some false positive diagnostics
					filterDiagnostics = function(diagnostics)
						-- WordPress common functions that might be flagged falsely
						local wp_functions = {
							"add_filter",
							"add_action",
							"apply_filters",
							"do_action",
							"get_option",
							"update_option",
							"delete_option",
							"wp_enqueue_script",
							"wp_enqueue_style",
							"register_post_type",
							"register_taxonomy",
							-- Add more WordPress functions here
						}

						local filtered = {}
						for _, diagnostic in ipairs(diagnostics) do
							-- Simple filtering rule: skip undefined function errors for WordPress functions
							local should_keep = true

							-- Check if it's an undefined function diagnostic for a WP function
							if diagnostic.code == "P1005" then -- Intelephense undefined function code
								local message = diagnostic.message
								for _, wp_func in ipairs(wp_functions) do
									if message:match(wp_func) then
										should_keep = false
										break
									end
								end
							end

							if should_keep then
								table.insert(filtered, diagnostic)
							end
						end

						return filtered
					end,
				}

				-- Set buffer-local diagnostic severity levels
				vim.diagnostic.config({
					-- Make undefined function warnings instead of errors for WordPress dev
					severity_sort = true,
				}, bufnr)

				-- Inform user that WordPress mode is active
				vim.api.nvim_echo({ { "WordPress development mode enabled for Intelephense", "Normal" } }, false, {})
			end
		end,
		buffer = 0, -- Only for current buffer
	})
end

-- Detect if file is WordPress-related
local function is_wordpress_file()
	local filename = vim.fn.expand("%:p")

	-- Check if file is in a WordPress project
	local is_wp = false

	-- Check for WordPress functions in the current file
	local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	for _, line in ipairs(content) do
		if line:match("add_filter") or line:match("add_action") or line:match("wp_") or line:match("WP_") then
			is_wp = true
			break
		end
	end

	-- Check path for WordPress indicators
	if
		filename:match("wp%-")
		or filename:match("wordpress")
		or filename:match("plugin")
		or filename:match("themes")
		or filename:match("gravityforms")
	then
		is_wp = true
	end

	return is_wp
end

-- Only activate WordPress settings for WordPress files
if is_wordpress_file() then
	set_up_wordpress_functions()
end

-- Add common WordPress globals to avoid undefined variable warnings
vim.lsp.buf.execute_command({
	command = "intelephense.index.workspace", -- Reindex after configuration changes
})
