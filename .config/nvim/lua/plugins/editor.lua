return {
  {
    --------------------
    --- 括号自动补全 ---
    --------------------
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,  -- 启用 Treesitter 进行更智能的匹配
      })
      -- 让 autopairs 和 nvim-cmp 兼容
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done)
    end

  },
  {
    ---------------------------------------------------
    --- 让 #00ffff 这种的背景颜色显现出来，方便调试 ---
    --- 不自动加载，想看颜色的话，直接cmd模式执行命令吧 
    ---------------------------------------------------
    "norcalli/nvim-colorizer.lua",
    lazy = true,
    cmd = { "ColorizerAttachToBuffer", "ColorizerToggle", "ColorizerDetachFromBuffer" },
    --event = {"BufReadPre", "BufNewFile"},
    config = function()
      require("colorizer").setup({
        filetypes = { "css", "html", "javascript", "lua", "vim", "markdown" },
        user_default_options = {
          RGB = true,       -- 支持 `rgb(255, 0, 0)`
          RRGGBB = true,    -- 支持 `#ff0000`
          names = true,     -- 识别颜色名称，如 `red`
          RRGGBBAA = true,  -- 支持带透明度的颜色 `#ff0000aa`
          AARRGGBB = true,  -- `0xffff0000`
          mode = "background",  -- 颜色预览显示模式（"foreground", "background", "virtualtext"）
        },
      })
    end
  },
  ----------------------
  --- 中括号后面提示 ---
  ----------------------
  {
    "andersevenrud/nvim_context_vt",
    event = "VeryLazy",
    enabled = not require("config.utils").is_diff_mode(),
    ft = { 'c', 'cpp', 'lua', 'python' },
    config = function()
      vim.api.nvim_set_hl(0, 'CustomContextVt', { fg = '#928374', bold = true, italic = true })
      require("nvim_context_vt").setup({
        enabled = true, -- 是否启用插件
        min_rows = 10,  -- 缩进深度：值越大，嵌套越深的结构才会显示
        prefix = "",  -- 虚拟文本前缀 -- 󱞩,󱞿,→,
        -- 显示在行尾（默认），也可以改成行首
        highlight = "Comment",  -- 虚拟文本的颜色
        --highlight = 'CustomContextVt',
        disable_ft = { "markdown", "text" },  -- 在这些文件类型中禁用
        disable_virtual_lines = false,  -- 是否在折叠文本中显示上下文
        disable_virtual_lines_ft = { 'yaml' },
        -- 如果使用 treesitter
        custom_parser = nil,
      })
    end,
  },
  --------------------
  --- 符号对齐插件 ---
  --------------------
  {
    "junegunn/vim-easy-align",
    --event = "VeryLazy",
    keys = {
      -- 视觉模式：选中多行后按 `ga` 进入交互对齐
      { "ga", "<Plug>(EasyAlign)", mode = "x", desc = "EasyAlign (visual mode)" },
      -- 普通模式：对当前段落或文本对象进行对齐
      { "ga", "<Plug>(EasyAlign)", mode = "n", desc = "EasyAlign (normal mode)" },
    },
  }

}
