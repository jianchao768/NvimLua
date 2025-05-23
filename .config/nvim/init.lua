--[[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║██║   ██║██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝╚██████╔╝██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝     ╚═╝
        My Neovim Lua Configuration
]]

require("config.default")
require("config.keymaps")
require("config.autocmd")

vim.opt.rtp:prepend("~/.config/nvim/lib/lazy.nvim-11.17.1")
require("lazy").setup({
    -- 颜色图标
    require("plugins.colorscheme"),
    require("plugins.nvim-web-devicons"),

    -- 文件树和tag表、FZF
    require("plugins.nvim-tree"),
    --require("plugins.aerial"), --bug贼多
    require("plugins.tagbar"),
    require("plugins.indent"),
    require("plugins.fzf"),
    require("plugins.bufferline"),

    -- 高亮和git提示
    --require("plugins.nvim-treesitter"), --暂时不好用
    require("plugins.gitsigns"),
    require("plugins.vim-cpp-highlight"),
    require("plugins.interestingwords"),

    -- LSP
    require("lsp.mason"),
    require("lsp.lspconfig"),
    require("lsp.nvim-cmp"),
    require("plugins.fidget"),

    -- 右侧滚动条，高亮当前单词
    require("plugins.nvim-scrollbar"),
    require("plugins.vim-illuminate"),
    require("plugins.editor"),

    --{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },  -- 状态栏
},{
    install = { missing = false,},  -- 禁止自动安装缺失的插件
    checker = { enabled = false,},  -- 禁止自动更新检测
    change_detection = { enabled = false,}, -- 禁用监听文件变化
    rocks = { hererocks = false,},  -- 禁用 hererocks
})

