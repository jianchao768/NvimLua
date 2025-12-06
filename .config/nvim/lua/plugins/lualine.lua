-- lua/plugins/lualine.lua
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy", -- 懒加载
  dependencies = {
    "nvim-tree/nvim-web-devicons",
     "SmiteshP/nvim-navic",
  }, -- 图标支持
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  config = function()
    -- 主题选择，可以用 'auto', 'gruvbox', 'everforest', 等

    local navic_status, navic = pcall(require, 'nvim-navic')
    require('lualine').setup {
      options = {
        icons_enabled        = false,
        theme                = 'gruvbox-material',
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true, -- 全局状态栏
        disabled_filetypes = { "alpha", "NvimTree", "toggleterm" },
        ignore_focus         = {
          "NvimTree",
          "tagbar",
          "gitsigns-blame"
        },
        refresh              = {
          statusline = 500,
          tabline    = 1000,
          winbar     = 1000,
        }
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { },
        lualine_c = {
          { 'filename',
            file_status = true,
            path = 1,   -- 0: 只文件名; 1: 相对路径; 2: 绝对路径; 3: ~ 替换家目录
            shorting_target = 40,-- 太长时缩写目标长度
          },
          {
            function()
              if navic_status then
                return navic.get_location()
              else
                return
              end
            end,
            cond = function()
              if navic_status then
                return navic.is_available()
              else
                return
              end
            end
          },
        },
        lualine_x = {
          'searchcount',
          {
            function()
              local stbufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
              if rawget(vim, "lsp") then
                for _, client in ipairs(vim.lsp.get_clients()) do
                  if client.attached_buffers[stbufnr] and client.name ~= "null-ls" then
                    return (vim.o.columns > 100 and "  " .. client.name .. " ") or " LSP "
                  end
                end
              end

              return ""
            end,
            color = { fg = "#ff9e64" },

          },
          'encoding', 'filetype' },
        lualine_y = {
          {
            function()
              local line = vim.fn.line('.')
              local col = vim.fn.col('.')
              return string.format('%d,%d', line, col)
            end,
            padding = { left = 1, right = 1 },
          },
        },
        lualine_z = { 'progress'},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = { "fugitive", "nvim-tree" }
    }
  end
}

