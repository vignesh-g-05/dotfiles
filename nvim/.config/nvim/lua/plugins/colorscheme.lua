return {
	{
		"Mofiqul/dracula.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd.colorscheme("dracula")
		end,
	},
}
