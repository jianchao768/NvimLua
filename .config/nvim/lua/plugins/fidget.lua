return {
    ------------------------------------------
    --- Neovim LSP 状态指示器，显示LSP进度 ---
    ------------------------------------------
    --- BUG:打开后，会使配的这个功能失效：当nvim-tree是最后一个窗口时，自动退出
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    config = function()
        require("fidget").setup({
            integration = {
                ["nvim-tree"] = false -- 让 fidget.nvim 不影响 nvim-tree
            },
            progress = {
                suppress_on_insert = true, --进入插入模式不显示进度
                ignore_done_already = true, -- **忽略已经完成的任务**
                display = {
                    done_icon = "✔", -- 任务完成时的图标
                    --progress_icon = "⏳", -- 任务进行中的图标
                },
            },
            notification = {
                window = {
                    winblend = 100, -- 透明度（0 = 不透明, 100 = 完全透明）
                    border = "none", -- 边框样式
                },
            },
        })
    end
}

