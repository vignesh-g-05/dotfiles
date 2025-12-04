return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "dracula",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "neo-tree", "Avante" },
				always_divide_middle = true,
			},

			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							local icons = {
								n = "󱐋 ",
								i = "󰏫 ",
								v = "󰈈 ",
								V = "󱣿 ",
								[""] = "󰡭 ",
								c = " ",
								R = " ",
							}
							local icon = icons[vim.fn.mode()] or " "
							return icon .. str
						end,
					},
				},

				lualine_b = { "branch" },

				lualine_c = {
					{
						"filename",
						file_status = true,
						path = 0,
					},
				},

				lualine_x = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
						colored = false,
						update_in_insert = false,
						always_visible = false,
					},
					{
						"diff",
						colored = false,
						symbols = { added = " ", modified = " ", removed = " " },
					},
					"encoding",
					"filetype",
				},

				lualine_y = { "location" },
				lualine_z = { "progress" },
			},

			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { { "location", padding = 0 } },
				lualine_y = {},
				lualine_z = {},
			},

			tabline = {},
			extensions = { "fugitive" },
		})
	end,
}
