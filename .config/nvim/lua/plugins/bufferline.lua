return {
  'akinsho/bufferline.nvim',
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",                    desc = "Bufferline Toggle Pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>",         desc = "Bufferline Delete Non-Pinned Buffers" },
    { "bj",         "<Cmd>BufferLinePick<CR>",                         desc = "Bufferline Pick Buffer" },
    { "bc",         "<Cmd>BufferLinePickClose<CR>",                    desc = "Bufferline Pick Buffer Close" },
    { "<C-Left>",   "<Cmd>BufferLineCyclePrev<CR>",                    desc = "Bufferline Cycle Prev" },
    { "<C-Right>",  "<Cmd>BufferLineCycleNext<CR>",                    desc = "Bufferline Cycle Next" },
    { "<A-h>",   "<Cmd>BufferLineCyclePrev<CR>",                       desc = "Bufferline Cycle Prev" },
    { "<A-l>",  "<Cmd>BufferLineCycleNext<CR>",                        desc = "Bufferline Cycle Next" },
    { "<leader>1",  "<Cmd>lua require'bufferline'.go_to(1, true)<CR>", desc = "Bufferline Go to buffer[1]" },
    { "<leader>2",  "<Cmd>lua require'bufferline'.go_to(2, true)<CR>", desc = "Bufferline Go to buffer[2]" },
    { "<leader>3",  "<Cmd>lua require'bufferline'.go_to(3, true)<CR>", desc = "Bufferline Go to buffer[3]" },
    { "<leader>4",  "<Cmd>lua require'bufferline'.go_to(4, true)<CR>", desc = "Bufferline Go to buffer[4]" },
    { "<leader>5",  "<Cmd>lua require'bufferline'.go_to(5, true)<CR>", desc = "Bufferline Go to buffer[5]" },
    { "<leader>6",  "<Cmd>lua require'bufferline'.go_to(6, true)<CR>", desc = "Bufferline Go to buffer[6]" },
    { "<leader>7",  "<Cmd>lua require'bufferline'.go_to(7, true)<CR>", desc = "Bufferline Go to buffer[7]" },
    { "<leader>8",  "<Cmd>lua require'bufferline'.go_to(8, true)<CR>", desc = "Bufferline Go to buffer[8]" },
    { "<leader>9",  "<Cmd>lua require'bufferline'.go_to(9, true)<CR>", desc = "Bufferline Go to buffer[9]" },
  },
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = "VeryLazy",
  config = function()
    local bufferline = require('bufferline')
    -- icon color:
    --vim.api.nvim_set_hl(0, 'BufferLineIndicatorSelected', { bold = true, fg = '#3498DB' })
    bufferline.setup({
      highlights = {
        buffer_selected = {
          underline = true,
          fg = "#dddddd", -- text color
          sp = "#3498DB", -- 下划线颜色
          bold = true,
        },
      },
      options = {
        mode = "buffers",
        numbers = "ordinal",
        --sort_by = "insert_after_current",  -- 打开的文件就在当前 buffer 右侧，而不是跳到最右边
        modified_icon = "•",
        --diagnostics = "nvim_lsp",
        diagnostics = false,
        separator_style = "thick",         -- 可选: "slant", "thick", "thin", { 'left', 'right' },
        indicator = {
          icon = '▎',                    -- this should be omitted if indicator style is not 'icon'
          style = "underline",           -- style = 'icon' | 'underline' | 'none',
        },
        color_icons = false,
        show_buffer_icons = false,
        show_close_icon = false,
        show_buffer_close_icons = false,
        close_command = "bdelete! %d",     -- 点击叉号时做的动作
        --right_mouse_command = "bdelete! %d",  -- 右键点击bufferline时的动作，强制关闭
        show_tab_indicators = true,
        always_show_bufferline = true,

        max_name_length = 25,              -- default 18
        max_prefix_length = 25,            -- default 15, prefix used when a buffer is de-duplicated
        enforce_regular_tabs = false,      -- 让所有标签页宽度一致
        truncate_names = true,             -- 超长自动截断
        show_duplicate_prefix = true,      -- 同名不同路径，是否显示路径名
        tab_size = 12,                     -- 最小宽度
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
        },
        groups = {
          items = {
            require('bufferline.groups').builtin.pinned:with({ icon = "󰐃" })
          }
        },
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
      }
    })

  end
}
