-- Prevent adding comment on new line --
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove({ "r", "o" })
	end,
})

-- Format on Save --
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		require("conform").format()
	end,
})
