vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("i", "jj", "<ESC>")

-- Move highlighted lines up and down
vim.keymap.set("v", "J", ":m'>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m'<-2<CR>gv=gv")

-- delete to the void register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.keymap.set('i', '<C-j>', '<C-j>', { noremap = true, expr = true })
vim.keymap.set('i', '<C-k>', '<C-k>', { noremap = true, expr = true })






















































