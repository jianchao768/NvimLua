return {
    {
        "folke/tokyonight.nvim",
    },
    {
        -------------------------
        --- Neovim 右侧滚动条 ---
        -------------------------
        "petertriho/nvim-scrollbar",
        dependencies = { "tokyonight.nvim" },
        config = function()
            local colors = require("tokyonight.colors").setup()
            require("scrollbar").setup({
                handle = {
                    --color = colors.bg_highlight,
                    color = colors.terminal_black,
                },
                marks = {
                    Search = { color = colors.orange },
                    Error = { color = colors.error },
                    Warn = { color = colors.warning },
                    Info = { color = colors.info },
                    Hint = { color = colors.hint },
                    Misc = { color = colors.purple },
                },
                -- 建议添加的额外配置（可选）
                excluded_filetypes = { "prompt", "TelescopePrompt", "noice" },
                handlers = {
                    cursor = true,  -- 显示光标位置
                    gitsigns = true -- 集成 gitsigns
                }
            })
        end,

    }
}
