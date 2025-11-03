-- General Behavior --
vim.o.mouse = "a" -- Enable mouse support in all modes
vim.o.clipboard = "unnamedplus" -- Sync system clipboard (copy/paste between OS and Neovim)
vim.o.swapfile = false -- Disable swap files
vim.o.backup = false -- Disable backup files
vim.o.undofile = true -- Enable persistent undo even after closing file
vim.o.hidden = true -- Allow switching buffers without saving
vim.o.errorbells = false -- Disable annoying error sounds
vim.o.updatetime = 300 -- Faster completion and cursor hold events
vim.o.timeoutlen = 400 -- Faster key sequence timeout
vim.o.encoding = "utf-8" -- Always use UTF-8
vim.o.fileencoding = "utf-8" -- Default file encoding
vim.o.filetype = "on"
vim.cmd("filetype plugin on")

-- Interface & Display --
vim.o.number = true -- Show line numbers
vim.o.relativenumber = true -- Show relative line numbers
vim.o.cursorline = true -- Highlight the current line
vim.o.signcolumn = "yes" -- Always show sign column (avoid text shifting)
vim.o.termguicolors = true -- Enable 24-bit color support
vim.o.wrap = false -- Don’t wrap long lines
vim.o.scrolloff = 8 -- Keep cursor 8 lines from screen edge
vim.o.sidescrolloff = 8 -- Same horizontally
vim.o.showmode = false -- Don’t show mode (statusline plugin will handle it)
vim.o.laststatus = 3 -- Global statusline across all windows
vim.o.pumheight = 10 -- Limit popup menu height
vim.o.showcmd = false -- Don’t show command in last line

-- Indentation & Tabs --
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.shiftwidth = 4 -- Indent by 4 spaces
vim.o.tabstop = 4 -- Display a tab as 4 spaces
vim.o.smartindent = true -- Smart autoindenting for new lines
vim.o.autoindent = true -- Copy indent from current line when starting new one
vim.o.breakindent = true -- Maintain indent when wrapping lines

-- Search --
vim.o.ignorecase = true -- Ignore case when searching
vim.o.smartcase = true -- Case-sensitive if uppercase in search
vim.o.incsearch = true -- Show matches while typing
vim.o.hlsearch = true -- Highlight all matches

-- Splits & Navigation --
vim.o.splitbelow = true -- New splits open below current window
vim.o.splitright = true -- New vertical splits open to the right
vim.o.scrollbind = false -- Don’t sync scrolling between splits

-- Completion & Editing --
vim.o.completeopt = "menuone,noselect" -- Better completion behavior
vim.o.wildmenu = true -- Command-line completion menu
vim.o.wildmode = "longest:full,full" -- Command-line tab completion mode
vim.o.virtualedit = "block" -- Allow cursor to move freely in visual block mode

-- UI & Visuals --
vim.o.title = true -- Show file name in terminal title
vim.o.synmaxcol = 240 -- Limit syntax highlight to 240 columnsvim.fn.stdpath('data')
vim.o.conceallevel = 0 -- Show markup (e.g. Markdown syntax symbols)
vim.o.cmdheight = 1 -- more space in the neovim command line for displaying messages

-- Backup & Undo --
-- base path: ~/.local/share/nvim/
vim.o.backupdir = vim.fn.stdpath("data") .. "/backup//" -- Store backups here
vim.o.directory = vim.fn.stdpath("data") .. "/swap//" -- Swap files path
vim.o.undodir = vim.fn.stdpath("data") .. "/undo//" -- Undo history path
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles") -- separate vim plugins from neovim in case vim still in use

-- Diable default file tree --
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
