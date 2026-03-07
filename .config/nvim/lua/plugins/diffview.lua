return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },

  keys = {
    { "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
    { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current file)" },
    { "<leader>dH", "<cmd>DiffviewFileHistory<cr>", desc = "File History (repo)" },
    {
      "<leader>gC",
      function()
        local file = vim.fn.expand("%")
        local line = vim.fn.line(".")

        local cmd = string.format(
          "git blame -L %d,%d --porcelain -- %s | head -n 1",
          line,
          line,
          file
        )

        local handle = io.popen(cmd)
        if not handle then
          print("Failed to run git blame")
          return
        end

        local result = handle:read("*l")
        handle:close()

        if result then
          local commit = result:match("^(%w+)")
          if commit then
            vim.cmd("DiffviewOpen " .. commit .. "^!")
          end
        end
      end,
      desc = "Diff current line commit",
    },
  },

  opts = {
    enhanced_diff_hl = true,
    use_icons = true,

    default_args = {
      DiffviewOpen = { "--untracked-files=no" },  -- 默认不显示未跟踪文件
      DiffviewFileHistory = { "--follow" },       -- 即使文件rename了也可以跟踪
    },

    view = {
      default = {
        layout = "diff2_horizontal",
        panel_width = 35,
      },

      merge_tool = {
        layout = "diff3_mixed",
        panel_width = 35,
      },
    },

    file_panel = {
      listing_style = "tree",
      show_untracked = false,    -- 暂时无效果
      hide_dotfiles = true,      -- 排除 隐藏文件

      tree_options = {
        flatten_dirs = true,
        folder_statuses = "symbols",
      },
    },
  },
}
