return {
	"rcarriga/nvim-notify",
	opts = {
		render = "compact",
		stages = "fade_in_slide_out",
		timeout = 2000,
		top_down = false,
		level = vim.log.levels.WARN,
	},
	config = function(_, opts)
		local notify = require("notify")
		notify.setup(opts)
		vim.notify = notify
	end,
}
