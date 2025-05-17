return {
    ------------------------------
    --- Neovim 文件管理器插件 ----
    ------------------------------
    -- 快捷键	   作用
    -- o or <CR>  打开文件/目录
    -- a	      新建文件/目录
    -- d	      删除文件/目录
    -- r	      重命名文件/目录
    -- x	      剪切
    -- c	      复制
    -- p	      粘贴
    -- yy	      复制文件路径
    -- R	      刷新
    -- ?	      显示所有快捷键
    -- -- -- -- -- -- -- -- -- -- 

    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    config = function ()
        local function my_on_attach(bufnr)
            local api = require "nvim-tree.api"

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- 载入默认按键
            api.config.mappings.default_on_attach(bufnr)

            -- 自定义按键
            vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))   --打开上一级目录
            vim.keymap.set('n', '?',     api.tree.toggle_help,           opts('Help'))
        end

        --vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.opt.termguicolors = true

        require("nvim-tree").setup {
            on_attach = my_on_attach,
            view = {
                width = 30, -- 侧边栏宽度
                side = "right", -- 显示在右侧
                cursorline = true,  -- 高亮当前行
            },
            git = {
                enable = true, -- 启用 Git 状态
            },
            renderer = {
                icons = {
                    show = {
                        git = true,  -- 显示 Git 图标
                        folder = true,
                        file = true,
                    },
                },
            },
            update_focused_file = {
                enable = true,  --开启自动高亮
                update_cwd = true,  -- 进入文件时自动更新 nvim-tree 的目录
                ignore_list = {}, --可以设置不更新的文件类型
            },
        }
        vim.cmd [[
            highlight NvimTreeCursorLine guibg=#44475a
        ]]
    end
}
