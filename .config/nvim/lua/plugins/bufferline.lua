return {
    'akinsho/bufferline.nvim',
    --dependencies = 'nvim-tree/nvim-web-devicons',
    event = "VeryLazy",
    config = function()
        local bufferline = require('bufferline')
        bufferline.setup({
            options = {
                mode = "tabs",
                numbers = "ordinal",
                modified_icon = "•",
                --diagnostics = "nvim_lsp",
                diagnostics = "false",
                separator_style = "thick", -- 可选: "slant", "thick", "thin", { 'left', 'right' },
                indicator = {
                    icon = '▎', -- this should be omitted if indicator style is not 'icon'
                    -- style = 'icon' | 'underline' | 'none',
                    style = "icon",
                },
                show_buffer_icons = false,
                show_close_icon = false,
                show_buffer_close_icons = false,
                close_command = "bdelete! %d",  -- 点击叉号时做的动作
                --right_mouse_command = "bdelete! %d",  -- 右键点击bufferline时的动作，强制关闭
                right_mouse_command = function()
                    --vim.api.nvim_buf_delete(vim.api.nvim_get_current_buf(), { force = true })
                    local current_buf = vim.api.nvim_get_current_buf()
                    local all_buffers = vim.api.nvim_list_bufs()
                    local normal_buffers = {}  -- 确保初始化为空表

                    -- 过滤掉 nvim-tree、tagbar 和空 buffer
                    for _, buf in ipairs(all_buffers) do
                        if vim.api.nvim_buf_is_valid(buf) then  -- 检查 buffer 是否有效
                            local buf_name = vim.api.nvim_buf_get_name(buf)
                            local buf_ft = vim.api.nvim_buf_get_option(buf, "filetype")

                            -- 只保留普通文件 buffer（非辅助窗口且非空）
                            if buf_name ~= ""
                                and buf_ft ~= "NvimTree"
                                and buf_ft ~= "tagbar" then
                                table.insert(normal_buffers, buf)
                            end
                        end
                    end

                    -- 如果当前 buffer 是最后一个普通 buffer，则退出 Neovim
                    if #normal_buffers == 1 and normal_buffers[1] == current_buf then
                        vim.cmd("q")
                    else
                        vim.api.nvim_buf_delete(current_buf, { force = true })
                    end
                end,

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

        vim.keymap.set('n', '<A-h>', '<Cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<A-l>', '<Cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true })

        for i = 1, 9 do
            vim.keymap.set('n', '<Leader>'..i, '<Cmd>BufferLineGoToBuffer '..i..'<CR>', { noremap = true, silent = true })
        end

    end
}
