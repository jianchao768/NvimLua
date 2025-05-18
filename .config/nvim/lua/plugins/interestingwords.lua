return {
    "Mr-LLLLL/interestingwords.nvim",
    keys = {"m"},
    config = function()
        require("interestingwords").setup({
            colors = {
                '#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF',
                '#FF9EBB', '#B5EAD7', '#C7CEEA', '#FFFACD', '#E6E6FA', '#D5AAFF'
            },
            search_count = true,         -- 显示当前词是第几个
            navigation = true,           -- 启用 n/N 跳转
            scroll_center = false,        -- 跳转后居中
            --search_key = ";",    -- 添加/搜索 当前词
            --cancel_search_key = "'", -- 移除当前词
            color_key = "m",     -- 为当前词指定颜色
            cancel_color_key = "M", -- 取消当前颜色标记
            select_mode = "loop",      -- random or loop

            -- 跳到下一个高亮词
            vim.keymap.set("n", "<C-n>", function()
                local ok = require("interestingwords").NavigateToWord(true)
                if not ok then
                    print("No interesting words")
                end
            end, { desc = "Next interesting word" }),

            -- 跳到上一个高亮词
            vim.keymap.set("n", "<C-p>", function()
                local ok = require("interestingwords").NavigateToWord()
                if not ok then
                    print("No interesting words")
                end
            end, { desc = "Previous interesting word" }),

        })
    end,
}
