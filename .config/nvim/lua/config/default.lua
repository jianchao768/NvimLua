vim.o.termguicolors = true  -- 启用 24-bit 颜色支持
vim.o.ttyfast = true      -- 提高终端输入响应速度

vim.o.autochdir = false   -- 是否自动切换工作目录为当前文件所在目录
vim.o.exrc = true         -- 允许加载当前目录的 `.nvimrc` 或 `.exrc`
vim.o.secure = false      -- 允许 `.exrc` 执行某些命令
vim.o.autoread = true     -- 文件被外部修改后，自动加载
vim.bo.autoread = true

vim.opt.tabstop = 4       -- Tab 显示的空格数
vim.opt.shiftwidth = 4    -- 自动缩进的空格数
vim.o.smarttab = true     -- 使用智能 Tab
vim.opt.expandtab = true  -- Tab 转空格
vim.opt.smartindent = true

vim.opt.number = true     -- 启用行号
-- vim.opt.relativenumber = true -- 显示相对行号
vim.o.cursorline = true  -- 高亮当前行
vim.wo.wrap = false       -- 默认禁用换行
-- vim.wo.linebreak = true   -- 如果启用换行时在单词边界断开
-- vim.o.signcolumn = "yes"   -- 始终显示标记列（避免 LSP 诊断抖动）

vim.o.scrolloff = 4  -- 光标上下留 4 行缓冲
vim.opt.mouse = "a" -- 启用鼠标支持

-- 搜索大小写不敏感
vim.o.ignorecase = true
vim.o.smartcase = true

-- 文件类型检测
vim.cmd("filetype plugin indent on")

