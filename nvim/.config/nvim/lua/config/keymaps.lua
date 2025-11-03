-- Set leader key --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = require("utils.keymap").map
local getOptions = require("utils.keymap").getOptions

-- Disable the spacebar key's default behavior in Normal and Visual modes --
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- File operaions
map("n", "<C-s>", "<cmd> w <CR>", getOptions()) -- Save file
map("n", "<C-q>", "<cmd> q <CR>", getOptions()) -- Quit file
map("n", "<C-S>", ":wa<CR>", getOptions()) -- Save all

-- clear highlights --
map("n", "<Esc>", ":noh<CR>", getOptions())

-- delete single character without copying into register --
map("n", "x", '"_x', getOptions())

-- Vertical scroll and center --
map("n", "<C-d>", "<C-d>zz", getOptions())
map("n", "<C-u>", "<C-u>zz", getOptions())

-- Find and center --
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Resize with arrows --
map("n", "<Up>", ":resize -2<CR>", getOptions())
map("n", "<Down>", ":resize +2<CR>", getOptions())
map("n", "<Left>", ":vertical resize -2<CR>", getOptions())
map("n", "<Right>", ":vertical resize +2<CR>", getOptions())

-- Increment/decrement numbers --
map("n", "<leader>+", "<C-a>", getOptions())
map("n", "<leader>-", "<C-x>", getOptions())

-- Window management --
map("n", "<leader>wv", "<C-w>v", getOptions("[W]indow [V]ertical split"))
map("n", "<leader>wh", "<C-w>s", getOptions("[W]indow [H]orizontal split"))
map("n", "<leader>we", "<C-w>=", getOptions("[W]indow [E]qual split"))
map("n", "<leader>wc", ":close<CR>", getOptions("[W]indow [C]lose split"))

-- Navigate between splits --
map("n", "<C-k>", ":wincmd k<CR>", getOptions())
map("n", "<C-j>", ":wincmd j<CR>", getOptions())
map("n", "<C-h>", ":wincmd h<CR>", getOptions())
map("n", "<C-l>", ":wincmd l<CR>", getOptions())

-- Toggles --
map("n", "<leader>tlw", "<cmd>set wrap!<CR>", getOptions("[T]oggle [L]ine [W]rap"))

-- Move text up and down --
map({ "n", "v" }, "<A-j>", ":m .+1<CR>==", getOptions())
map({ "n", "v" }, "<A-k>", ":m .-2<CR>==", getOptions())

-- Duplicate Text --
map({ "n", "v" }, "<A-J>", "yyp", getOptions())
map({ "n", "v" }, "<A-K>", "yyP", getOptions())

-- Copy and Paste --
map({ "n", "v" }, "<leader>y", '"+y')
map({ "n", "v" }, "<leader>p", '"+p')

-- Save and load session --
map("n", "<leader>ss", ":mksession! .session.vim<CR>", { noremap = true, silent = false, desc = "[S]ession [S]ave" })
map("n", "<leader>sl", ":source .session.vim<CR>", { noremap = true, silent = false, desc = "[S]ession [L]oad" })

-- Indendation --
map({ "n", "v" }, "<", "<gv", getOptions())
map({ "n", "v" }, ">", ">gv", getOptions())

-- Rename --
map("n", "<leader>rw", ":%s/<C-r><C-w>//gI<Left><Left><Left>", getOptions("[R]ename [W]ord"))

-- Add blank line and move cursor there --
vim.keymap.set(
	"n",
	"<leader>o",
	":call append(line('.'), '') | normal! j<CR>",
	{ desc = "Add line below (stay in normal mode)" }
)
vim.keymap.set(
	"n",
	"<leader>O",
	":call append(line('.') - 1, '') | normal! k<CR>",
	{ desc = "Add line above (stay in normal mode)" }
)
