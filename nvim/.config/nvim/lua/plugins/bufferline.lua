return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"moll/vim-bbye",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- vim.opt.linespace = 8

		require("bufferline").setup({
			options = {
				mode = "buffers", -- set to "tabs" to only show tabpages instead
				themable = false, -- allows highlight groups to be overriden i.e. sets highlights as default
				numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
				close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
				right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
				left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
				middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
				-- buffer_close_icon = '󰅖',
				buffer_close_icon = "✗",
				-- buffer_close_icon = '✕',
				close_icon = "",
				path_components = 1, -- Show only the file name without the directory
				modified_icon = "●",
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 30,
				max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
				tab_size = 21,
				diagnostics = false,
				diagnostics_update_in_insert = false,
				color_icons = true,
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
				separator_style = "slant", -- | "slant" | "thick" | "thin" | { 'any', 'any' },
				enforce_regular_tabs = true,
				always_show_bufferline = true,
				show_tab_indicators = false,
				indicator = {
					-- icon = '▎', -- this should be omitted if indicator style is not 'icon'
					style = "none", -- Options: 'icon', 'underline', 'none'
				},
				icon_pinned = "󰐃",
				minimum_padding = 1,
				maximum_padding = 5,
				maximum_length = 15,
				sort_by = "insert_at_end",
			},
			highlights = {
				separator = {},
				buffer_selected = {
					italic = true,
				},
				-- separator_selected = {},
				-- tab_selected = {},
				-- background = {},
				-- indicator_selected = {},
				-- fill = {},
			},
		})

		-- Keymaps
		local map = require("utils.keymap").map
		local getOptions = require("utils.keymap").getOptions
		map("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", {})
		map("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})
		map("n", "<leader>bc", ":bdelete<CR>", getOptions("[B]uffer [D]elete"))
		map("n", "<leader>bu", "<cmd>e #<CR>", getOptions("[B]uffer [U]ndo delete"))
		map("n", "<leader>bp", "<cmd>BufferLineTogglePin<CR>", getOptions("[B]uffer [P]in"))
		map("n", "<leader>ba", "<cmd>BufferLineCloseOthers<CR>", getOptions("[B]uffer [A]ll close"))
		map("n", "<leader>bd", "<cmd>bufdo bdelete<CR>", getOptions("[B]uffer [D]estroy all"))
	end,
}
