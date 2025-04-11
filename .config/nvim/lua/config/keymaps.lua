-- 设置 Leader 键
vim.g.mapleader = ","  -- 设为逗号

local opts = { noremap = true, silent = true }

-- 窗口切换
vim.keymap.set("n", "<C-h>", "<C-W>h", opts)
vim.keymap.set("n", "<C-j>", "<C-W>j", opts)
vim.keymap.set("n", "<C-k>", "<C-W>k", opts)
vim.keymap.set("n", "<C-l>", "<C-W>l", opts)

vim.keymap.set("i", "<C-h>", "<Esc><C-W>h", opts)
vim.keymap.set("i", "<C-j>", "<Esc><C-W>j", opts)
vim.keymap.set("i", "<C-k>", "<Esc><C-W>k", opts)
vim.keymap.set("i", "<C-l>", "<Esc><C-W>l", opts)

-- 常用操作
vim.keymap.set("n", "w", ":w!<CR>", opts)  -- 强制保存
vim.keymap.set("n", "q", ":q<CR>", opts)  -- 退出
vim.keymap.set("n", "s", "%", opts)  -- 跳转到匹配的括号
vim.keymap.set("n", "f", "^", opts)  -- 跳转到行首
vim.keymap.set("n", ".", "$", opts)  -- 跳转到行尾
--vim.keymap.set("n", ";", "*", opts)  -- 搜索当前单词
vim.keymap.set("n", "'", ":noh<CR>", opts)  -- 取消搜索高亮

