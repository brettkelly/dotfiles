return {
	"preservim/vim-pencil",
	ft = { "markdown", "text", "tex" },
	config = function()
		-- Basic setup
		vim.g["pencil#wrapModeDefault"] = "soft" -- 'soft' for soft line breaks

		-- Auto-enable for specific filetypes
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "markdown", "text", "tex" },
			callback = function()
				vim.cmd("PencilSoft") -- Use soft line wrapping

				-- Set width to 90 characters
				vim.b.pencil_textwidth = 90
			end,
		})
	end,
}
