return {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPost", "BufNewFile" }, -- 仅在打开文件时加载
    config = function()
        vim.defer_fn(function ()
            require("hlchunk").setup({
                --chunk = { --函数框
                --    enable = true,
                --    notify = true, -- 进入代码块时通知
                --    use_treesitter = true, -- 使用 Treesitter 解析代码块
                --    style = "#806d9c", -- 高亮颜色（可换成其他颜色）
                --},
                indent = {
                    enable = true,
                    chars = { "│", "¦", "┆", "┊" }, -- 可视化字符
                    use_treesitter = true,
                },
                --line_num = {
                --    enable = true, -- 高亮当前函数行号
                --    style = "#E98800",
                --},
                blank = {
                    enable = false, -- 关闭空白字符高亮
                },
            })
        end, 100)
    end,
}
