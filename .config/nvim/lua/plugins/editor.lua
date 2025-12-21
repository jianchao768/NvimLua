return {
  {
    ----------------------------------------
    -- 提供Nerd Fonts图标供Neovim插件使用 --
    ----------------------------------------
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
      color_icons = true, --启用彩色图标
      strict = true,  -- 仅当文件类型明确时才显示图表
      default = true, -- 默认启用所有图标
    },
  },
  {
    --------------------
    --- 括号自动补全 ---
    --------------------
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,  -- 启用 Treesitter 进行更智能的匹配
      ts_config = {     -- 控制 哪些语言的特定语法环境里不要自动补全括号
        lua = { "string" },
      },
      disable_filetype = { "TelescopePrompt", "vim" },
      fast_wrap = {     --暂时没生效，后面再debug
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [[%'%"%)%>%]%)]],
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
      enable_moveright = true,
    },
    -- 这个会在启动的时候拉起cmp，增加启动时间
    --init = function ()
    --  -- 让 autopairs 和 nvim-cmp 兼容
    --  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    --  local cmp = require("cmp")
    --  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done)
    --end
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
    opts = {
      filetypes = { "css", "html", "javascript", "lua", "vim", "markdown" },
      user_default_options = {
        RGB = true,       -- 支持 `rgb(255, 0, 0)`
        RRGGBB = true,    -- 支持 `#ff0000`
        names = true,     -- 识别颜色名称，如 `red`
        RRGGBBAA = true,  -- 支持带透明度的颜色 `#ff0000aa`
        AARRGGBB = true,  -- `0xffff0000`
        mode = "background",  -- 颜色预览显示模式（"foreground", "background", "virtualtext"）
      },
    },
  },
  ----------------------
  --- 中括号后面提示 ---
  ----------------------
  {
    "andersevenrud/nvim_context_vt",
    event = "VeryLazy",
    enabled = not require("configs.utils").is_diff_mode(),
    init = function()
      vim.api.nvim_set_hl(0, 'CustomContextVt', { fg = '#928374', bold = true, italic = true })
    end,
    opts = {
      enabled                  = true,       -- 是否启用插件
      min_rows                 = 10,         -- 缩进深度：值越大，嵌套越深的结构才会显示
      prefix                   = "",        -- 虚拟文本前缀 -- 󱞩,󱞿,→,   显示在行尾（默认），也可以改成行首
      highlight                = "Comment",  -- 虚拟文本的颜色    highlight = 'CustomContextVt',
      disable_ft               = { "markdown", "text" },  -- 在这些文件类型中禁用
      disable_virtual_lines    = false,      -- 是否在折叠文本中显示上下文
      disable_virtual_lines_ft = { 'yaml' },
      custom_parser            = nil,
      },
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
