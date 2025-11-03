local map = require("utils.keymap").map
local getOptions = require("utils.keymap").getOptions

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("nvim-tree").setup({
			view = {
				width = 30,
			},
		})
		map({ "n", "i", "v" }, "<leader>e", ":NvimTreeToggle<CR>", getOptions())
		map({ "n", "i", "v" }, "<leader>ef", ":NvimTreeFocus<CR>", getOptions("[E]xplorer [F]ocus"))
	end,
}
