return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			json = { "prettierd", "prettier" },
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)

		local map = require("utils.keymap").map
		local getOptions = require("utils.keymap").getOptions

		map("n", "<leader>cf", function()
			require("conform").format()
		end, getOptions("[C]ode [F]ormat"))
	end,
}
