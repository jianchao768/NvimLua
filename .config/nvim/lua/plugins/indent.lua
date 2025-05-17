return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local ibl = require("ibl")

        ibl.setup({
            indent = {
                char = { "│", "¦", "┆", "┊" }, -- 可视化字符
            },
            scope = {
                enabled = true,
                show_start = false,
                show_end = false,
                highlight = { "Function", "Label" }, -- 可按需定制高亮
            },
            exclude = {
                filetypes = { "help", "startify", "dashboard", "lazy", "neogitstatus", "NvimTree", "Trouble",},
                buftypes = { "terminal", "nofile" },
            },
        })
    end,
}
