return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },

  keys = {
    { "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
    { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current file)" },
    { "<leader>dH", "<cmd>DiffviewFileHistory<cr>", desc = "File History (repo)" },
  },

  opts = {
    enhanced_diff_hl = true,
    use_icons        = true,
    diff_binaries    = false,

    view = {
      default = {
        layout     = "diff2_horizontal",           -- 默认 diff 布局为水平双窗口。
        merge_tool = { layout = "diff3_mixed" },   -- 如果是三方合并（merge），使用三窗口混合布局。
      },
    },

    file_panel = { -- 文件面板设置
      position = "left",
      width    = 35,
      tree_config = {
        indent_markers  = { enable = true, }, -- 显示缩进标记（类似树状符号）
        flatten_dirs    = true,      -- 自动展开单目录
        folder_statuses = "symbols", -- 显示 git 状态符号
      },
    },

    file_history_panel = {
      position = "left",
      width    = 35,
    },
  },

  config = function(_, opts)
    require("diffview").setup(opts)
  end,
}
