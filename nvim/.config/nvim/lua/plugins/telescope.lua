local map = require("utils.keymap").map
local getOptions = require("utils.keymap").getOptions

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-fzf-native.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	build = "make",
	cond = function()
		return vim.fn.executable("make") == 1
	end,
	config = function()
		local actions = require("telescope.actions")

		require("telescope").setup({
			defaults = {
				layout_config = { width = 0.9, height = 0.9 },
				sorting_strategy = "ascending",
				prompt_prefix = "  ",
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
					n = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
			},
		})

		require("telescope").load_extension("ui-select")

		map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", getOptions("[F]ind [F]iles"))
		map("n", "<leader>ft", "<cmd>Telescope live_grep<CR>", getOptions("[F]ind [T]ext"))
		map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", getOptions("[F]ind [B]uffer"))
		map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", getOptions("[F]ind [H]elp"))
	end,
}
