return {
    ------------------------------------------
    ----------  Neovim MARK 插件   -----------
    ------------------------------------------
    "winter233/neomark.nvim",
    keys = function()
        return {
            "m",
        }
    end,
    config = function()
        -- 插件加载后再设置其他快捷键
        local map = vim.keymap.set
        map("n", "m", function() require("neomark").toggle() end, {desc = "Mark/Unmark word under cursor"})
        map("n", "<leader>mc", function() require("neomark").clear() end, { desc = "Unmark all words" })
        map("n", "<c-p>", function() require("neomark").prev({ recursive = true }) end, { desc = "Jump to prev marked word" })
        map("n", "<c-n>", function() require("neomark").next({ recursive = true }) end, { desc = "Jump to next marked word" })
        map("n", "<leader>[", function() require("neomark").prev({ recursive = true, any = true }) end, { desc = "Jump to prev any marked word" })
        map("n", "<leader>]", function() require("neomark").next({ recursive = true, any = true }) end, { desc = "Jump to next any marked word" })

        require("neomark").setup({
            colors = {
                '#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF',
                '#FF9EBB', '#B5EAD7', '#C7CEEA', '#FFFACD', '#E6E6FA', '#D5AAFF'
            },
        })

    end,
}
