local map = vim.keymap.set

local getOptions = function(desc)
	if not desc then
		return { noremap = true, silent = true }
	end
	return { noremap = true, silent = true, desc = desc }
end

return {
	map = map,
	getOptions = getOptions,
}
