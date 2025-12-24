return {
  ------------------------------
  --- Neovim 文件管理器插件 ----
  ------------------------------
  -- 快捷键	   作用
  -- o or <CR>  打开文件/目录
  -- a	      新建文件/目录
  -- d	      删除文件/目录
  -- r	      重命名文件/目录
  -- x	      剪切
  -- c	      复制
  -- p	      粘贴
  -- yy	      复制文件路径
  -- R	      刷新
  -- ?	      显示所有快捷键
  -- -- -- -- -- -- -- -- -- -- 
  "nvim-tree/nvim-tree.lua",
  cmd = "NvimTreeToggle",

  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true

    -- highlight 必须写在 config/init，不属于 opts
    vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = "#44475a" })
  end,

  opts = {
    on_attach = function(bufnr)
      local api = require "nvim-tree.api"

      -- 载入默认按键
      api.config.mappings.default_on_attach(bufnr)

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- 自定义按键
      vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))   --打开上一级目录
      vim.keymap.set('n', '?',     api.tree.toggle_help,           opts('Help'))
    end,

    view = {
      adaptive_size = true,  -- 根据内容自动调整宽度
      width = { min = 20, max = 40 }, -- 侧边栏宽度，避免过宽影响代码编辑区
      side = "right",
      --cursorline = true,
    },

    git = {
      enable = true,
    },

    renderer = {
      indent_width = 1,  -- 减少缩进宽度（默认是2）
      group_empty = true,  -- 合并空目录
      indent_markers = {
        enable = true,    -- 显示缩进标记线（帮助视觉区分）
      },
      icons = {
        show = {
          git = true,
          folder = true,
          folder_arrow = true,
          file = true,
        },
      },
    },

    update_focused_file = {
      enable = true,  --开启自动高亮
      update_cwd = false,  -- 进入文件时自动更新 nvim-tree 的目录
      ignore_list = {}, --可以设置不更新的文件类型
    },
  },

  --config = function(_, opts)
  --  require("nvim-tree").setup(opts)
  --end,
}
