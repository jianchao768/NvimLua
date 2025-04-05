return {
    -------------------
    ---函数名称列表 ---
    --- <C-v> 再垂直分屏中跳转
    --- <C-s> 再水平分屏中跳转
    --- p 跳转函数，但是光标不过去
    -------------------
    "stevearc/aerial.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
    config = function()
        require("aerial").setup({
            attach_mode = "global", --独立窗口，不设置的话会绑定在某个buffer上
            open_automatic = false, --是否自动打开
            close_on_select = false, -- 选择后不关闭窗口

            layout = {
                max_width = { 40, 0.2 }, -- 最大宽度40列或窗口20%
                min_width = 20,
                default_direction = "left",
                resize_to_content = true, -- 根据符号数量自动调整窗口大小
            },

            show_guides = true, -- 显示缩进线
            nerd_font = "auto", -- 用NerdFont补充 

            backends = { "treesitter", "lsp" }, -- 同时使用 treesitter 和 lsp
            update_events = "TextChanged,InsertLeave", --自动更新符号

            filter_kind = { --显示的符号类型
                "Class",
                "Constructor",
                "Enum",
                "Function",
                "Interface",
                "Module",
                "Method",
                "Struct",
            },

            highlight_on_hover = true, -- 悬停高亮
            highlight_mode = "split_width", -- 只显示最后一个窗口的函数
            highlight_on_jump = 300, --跳转到符号时，高亮300ms
        })

        -- 绑定快捷键
        vim.keymap.set("n", "<leader>t", "<cmd>AerialToggle!<CR>", { noremap = true, silent = true })
    end
}
