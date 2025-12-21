return {
  ----------------------------------
  --- 自动记录项目路径，用来跳转 ---
  ----------------------------------
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  --cmd = "WhichKey",
  opts = {
    --- 自动检测项目根目录的模式
    detection_methods = { "lsp", "pattern" },
    -- pattern 模式匹配：按目录名或文件名向上搜索
    -- patterns = { ".git", "Makefile", "package.json", "CMakeLists.txt", "build.gradle" },
    patterns = { ".git"},

    --- 是否在切换项目时自动更新 Neovim 的 cwd
    manual_mode = false,               -- false 表示自动检测
    show_hidden = false,               -- 是否显示隐藏文件
    silent_chdir = false,              -- 切换目录时不显示提示
    datapath = vim.fn.stdpath("data"), -- 保存历史记录的路径
  },
  config = function(_, opts)
    require("project_nvim").setup(opts)
  end,
}
