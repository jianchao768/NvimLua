return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
  config = function()
    require("treesitter-context").setup({
      enable = true,            -- 启用插件
      max_lines = 3,            -- 最多显示几行上下文
      min_window_height = 0,    -- 窗口太小时自动隐藏（0=总显示）
      line_numbers = true,      -- 在 context 中显示行号
      multiline_threshold = 20, -- 超过 N 行的节点只显示第一行
      trim_scope = "outer",     -- 哪一层范围被裁剪（'inner' 或 'outer'）
      mode = "cursor",          -- 'cursor' | 'topline'
      --separator = "―",          -- 分隔线字符，可设为 nil 不显示
      zindex = 20,              -- 叠放层级
      on_attach = nil,          -- 可选回调（缓冲区 attach 时触发）
    })
  end,
}

