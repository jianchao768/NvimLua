return {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = "VeryLazy",
    config = function()
        local bufferline = require('bufferline')
        bufferline.setup({
            options = {
                mode = "tabs",
                numbers = "ordinal",
                diagnostics = "nvim_lsp",
                separator_style = "slant", -- 可选: "slant", "thick", "thin", { 'left', 'right' },
                indicator = {
                    icon = '▎', -- this should be omitted if indicator style is not 'icon'
                    -- style = 'icon' | 'underline' | 'none',
                    style = "icon",
                },
                show_buffer_icons = true,
                show_close_icon = false,
                show_buffer_close_icons = false,
                close_command = "bdelete! %d",  -- 点击叉号时做的动作
                right_mouse_command = "bdelete! %d",  -- 右键点击bufferline时的动作，强制关闭

                show_tab_indicators = true,
                always_show_bufferline = true,
                --enforce_regular_tabs = true,  -- 让所有标签页宽度一致
                show_duplicate_prefix = true, -- 同名不同路径，是否显示路径名
                --tab_size = 16,
                padding = 0,

                -- 对tagbar和NvimTree设置偏移，防止重叠
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "center",
                        separator = true,
                    },
                    {
                        filetype = "tagbar",
                        text = "Tagbar",
                        highlight = "Title", -- 或 "Special" 也可以
                        text_align = "center",
                        separator = true,
                    },
                }
            }
        })
        -- 添加自定义快捷键
        vim.keymap.set('n', '<C-Left>', '<Cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<C-Right>', '<Cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true })
        for i = 1, 9 do
            vim.keymap.set('n', '<Leader>'..i, '<Cmd>BufferLineGoToBuffer '..i..'<CR>', { noremap = true, silent = true })
        end

    end
}
