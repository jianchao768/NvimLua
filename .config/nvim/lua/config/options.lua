vim.o.termguicolors = true           -- 启用 24-bit 颜色支持
vim.o.ttyfast = true                 -- 提高终端输入响应速度

vim.o.autochdir = false              -- 是否自动切换工作目录为当前文件所在目录
vim.o.exrc = true                    -- 允许加载当前目录的 `.nvimrc` 或 `.exrc`
vim.o.secure = false                 -- 允许 `.exrc` 执行某些命令
vim.o.autoread = true                -- 文件被外部修改后，自动加载
vim.bo.autoread = true
vim.opt.clipboard = "unnamedplus"    -- 

vim.opt.shiftwidth = 2               -- 自动缩进的空格数
vim.opt.tabstop = 4                  -- Tab 显示的空格数
vim.o.smarttab = true                -- 使用智能 Tab
vim.opt.expandtab = true             -- Tab 转空格
vim.opt.smartindent = true

vim.opt.number = true                -- 启用行号
-- vim.opt.relativenumber = true     -- 显示相对行号
vim.o.cursorline = true              -- 高亮当前行
vim.wo.wrap = false                  -- 默认禁用换行
-- vim.wo.linebreak = true           -- 如果启用换行时在单词边界断开
-- vim.o.signcolumn = "yes"          -- 始终显示标记列（避免 LSP 诊断抖动）

vim.o.scrolloff = 4                  -- 光标上下留 4 行缓冲
vim.o.sidescrolloff = 10             -- 左右保留列数
vim.opt.mouse = "a"                  -- 启用鼠标支持

-- 搜索大小写不敏感
vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.whichwrap:append "<>[]hl"

vim.opt.completeopt = { "menu", "menuone", "noselect" } -- cmp 推荐配置
vim.opt.pumheight = 10               -- 补全弹出菜单高度
vim.opt.timeoutlen = 500             -- 键盘映射等待时间（ms）
vim.opt.updatetime = 100             -- CursorHold 等事件触发速度
vim.opt.showcmd = false              -- 不显示输入命令
vim.opt.showmode = false             -- 不显示 --INSERT-- 等模式信息

vim.opt.list = true                  -- 显示特殊字符
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

--vim.g.loaded_netrw = 1             --打开会导致fzf_projects切换后不自动打开文件树
--vim.g.loaded_netrwPlugin = 1       --打开会导致fzf_projects切换后不自动打开文件树
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.diff_translations = 0

-- 文件类型检测
vim.cmd("filetype plugin indent on")

-- vim.opt.timeoutlen = 300  -- leader超时时间 可以让leader快捷键响应更快
vim.o.tags = "./tags;,tags;"


-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH
