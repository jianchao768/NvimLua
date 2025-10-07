-- lua/plugins/lualine.lua
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy", -- 懒加载
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- 图标支持
  config = function()
    -- 主题选择，可以用 'auto', 'gruvbox', 'everforest', 等
    local lualine_theme = "auto"

    require('lualine').setup {
      options = {
        theme = lualine_theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true, -- Neovim 0.7+ 支持全局状态栏
        disabled_filetypes = { "alpha", "NvimTree", "toggleterm" },
        ignore_focus         = {
          "NvimTree",
          "tagbar",
          "gitsigns-blame"
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {},
        lualine_c = { { 'filename', file_status = true, path = 1 } },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
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

