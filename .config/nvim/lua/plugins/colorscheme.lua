return {
    -----------------------------
    --- 颜色主题插件 ------------
    -----------------------------
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                terminal_colors = true, -- add neovim terminal colors
                undercurl = false,
                underline = true,
                bold = true,
                italic = {
                    strings = false,
                    emphasis = false,
                    comments = false,
                    operators = false,
                    folds = false,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {
                    ["@variable"] = { link = "Normal" },
                    ["@field"] = { link = "Normal" },
                    ["@property"] = { link = "Normal" },
                    ["@parameter"] = { link = "Normal" },
                    ["@constant"] = { link = "Normal" },
                    ["@type"] = { link = "Type" },
                    ["@function"] = { link = "Function" },
                },
                dim_inactive = false,
                transparent_mode = false,
            })
            vim.cmd("colorscheme gruvbox")
        end,
    },
    {
        "morhetz/gruvbox",
        lazy = false,
        priority = 1000,
        config = function()
            -- 设置一些 gruvbox 变量（必须在 colorscheme 调用前设置）
            vim.g.gruvbox_contrast_dark = "medium"  -- 可选: 'soft', 'medium', 'hard'
            vim.g.gruvbox_italic = 0
            vim.g.gruvbox_bold = 0
            vim.g.gruvbox_transparent_bg = 0

            -- 加载主题
            --vim.cmd("colorscheme gruvbox")
        end
    },
    {
        "sainnhe/gruvbox-material",
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_background = "soft" -- 可选: 'soft', 'medium', 'hard'
            vim.g.gruvbox_material_foreground = "mix" -- 可选: 'material', 'mix', 'original'
            vim.g.gruvbox_material_enable_italic = 0
            vim.g.gruvbox_material_disable_italic_comment = 1
            vim.g.gruvbox_material_enable_bold = 1
            vim.g.gruvbox_material_ui_contrast = "low"
            vim.g.gruvbox_material_transparent_background = 0
            vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
            vim.g.gruvbox_material_current_word = "grey background"

            --vim.cmd("colorscheme gruvbox-material")
        end,
    },
}
