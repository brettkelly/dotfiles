return {
	{ "nuvic/flexoki-nvim", name = "flexoki" },
	"Mofiqul/dracula.nvim",
	priority = 1000,
	config = function()
		vim.cmd("colorscheme flexoki")
	end,
}
