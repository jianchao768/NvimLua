return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,            -- 主题类插件允许 early load
    --priority = 1000,         -- 确保最早
    enabled = function()
      return not require("configs.utils").is_diff_mode()
    end,

    opts = require("plugins.colorscheme"),

    config = function(_, opts)
      require("gruvbox").setup(opts)

      vim.cmd("colorscheme gruvbox")

      local group =
        vim.api.nvim_create_augroup("MyDiffHighlight", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "diff",
        callback = function()
          vim.api.nvim_set_hl(0, "DiffAdd",    { reverse = true, fg = "#b8bb26", bg = "#282828", })
          vim.api.nvim_set_hl(0, "DiffChange", { reverse = true, fg = "#8ec07c", bg = "#282828", })
          vim.api.nvim_set_hl(0, "DiffDelete", { reverse = true, fg = "#fb4934", bg = "#282828", })
          vim.api.nvim_set_hl(0, "DiffText",   { reverse = true, fg = "#fabd2f", bg = "#282828", })
        end,
      })
    end,
  },
  { require("plugins.editor"), },
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
    "folke/noice.nvim",
    event = "VeryLazy", -- 延迟加载，避免影响启动
    dependencies = {
      "MunifTanjim/nui.nvim",      -- Noice 的 UI 基础依赖
      "rcarriga/nvim-notify",      -- 可选：更好的通知系统
    },
    opts = require("plugins.noice").opts,
    config = function(_, opts)
      require("noice").setup(opts)
      if vim.o.filetype == "lazy" then
        vim.cmd([[messages clear]])
      end
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ft = { "lua", "c", "cpp"},
    --event = { "BufReadPre", "BufNewFile" },

    opts = function() return require("plugins.indent").opts() end,
    config = function(_, opts) require("plugins.indent").config(opts) end,
  },
  {
    "octol/vim-cpp-enhanced-highlight",
    ft = { "cpp", "c", "hpp", "h" },
    init = function() require("plugins.vim-cpp-highlight").init() end,
  },
  {
    ---------------------------
    ---  Neovim MARK 插件   ---
    ---------------------------
    "winter233/neomark.nvim",

    keys = require("plugins.neomark").keys,
    opts = function() return require("plugins.neomark").opts() end,
    config = function(_, opts) require("plugins.neomark").setup(opts) end,
  },
  {
    ----------------------------
    --- 高亮光标下的相同单词 ---
    ----------------------------
    "RRethy/vim-illuminate",
    event = "CursorHold",
    config = function()
      local opts = require("plugins.vim-illuminate").opts
      require("illuminate").configure(opts)
      require("plugins.vim-illuminate").init()
    end,
  },
  {
    -------------------------------
    --- Tagbar 侧边栏显示函数名 ---
    -------------------------------
    "preservim/tagbar",
    cmd = "TagbarToggle",

    keys = require("plugins.tagbar").keys,
    init = function() require("plugins.tagbar").init() end,
    --config = function(_, opts) require("plugins.tagbar").config(opts) end,
  },
  {
    ------------------------------
    --- Neovim 文件管理器插件 ----
    ------------------------------
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    opts = require("plugins.nvim-tree").opts,
    init = function() require("plugins.nvim-tree").init() end,
    config = function(_, opts) require("plugins.nvim-tree").config(opts) end,
  },
  {
  -----------------------
  --   nvim-cmp 插件  ---
  -----------------------
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },

    opts = function() return require("lsp.nvim-cmp").opts() end,
    --init = function()        require("lsp.nvim-cmp").init() end,
  },
  {
    ----------------------------
    ----    FZF-LUA 配置    ----
    ----------------------------
    "ibhagwan/fzf-lua",
    keys = require("plugins.fzf").keys,
    opts = function() return require("plugins.fzf").setup_opts() end,
  },
  {
    ----------------------------
    ----  显示函数名的插件  ----
    ----------------------------
    "SmiteshP/nvim-navic",
    ft = { "c", "cpp", "lua", "python", "java" },
    init = function() require("plugins.nvim-navic").init() end,
    opts = require("plugins.nvim-navic").opts,
  },
  --{
      ------------------
      ----  标题栏  ----
      ------------------
  --  "akinsho/bufferline.nvim",
  --  event = "VeryLazy",
  --  dependencies = "nvim-tree/nvim-web-devicons",

  --  keys = require("plugins.bufferline").keys,
  --  opts = function() return require("plugins.bufferline").opts() end,
  --  --init = function() require("plugins.bufferline").init() end,
  --},
  {
    ---------------------
    ----  命令行插件 ----
    ---------------------
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "SmiteshP/nvim-navic",
    },

    opts = function() return require("plugins.lualine").opts() end,
    init = function() require("plugins.lualine").init() end,
  },
  {
    -----------------------------------------------
    --- Neovim Git集成插件，在nvim中提供git状态 ---
    -----------------------------------------------
    "lewis6991/gitsigns.nvim",
    --event = { "BufReadPre", "BufNewFile" },
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },

    keys = function() return require("plugins.gitsigns").keys end,
    opts = function() return require("plugins.gitsigns").opts end,
    config = function(_, opts) require("plugins.gitsigns").config(_, opts) end,
  },
  {
    ----------------------------------------------
    --- mason.nvim 提供LSP、工具等安装卸载界面 ---
    ----------------------------------------------
    "williamboman/mason.nvim",
    ft = { "lua", "c", "cpp" },
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },

    opts = function() return require("lsp.mason").opts() end,
  },
  {
    ----------------------------------------------
    --- mason-lspconfig.nvim 用于安装LSP服务器 ---
    ----------------------------------------------
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    ft = { "lua", "c", "cpp" },

    build = function() require("lsp.mason").maybe_update() end,
    opts  = function() return require("lsp.mason").lspconfig_opts() end,
  },
  {
    ----------------------------------------------------
    ---Neovim LSP 客户端插件，但是关闭代码补全、跳转 ---
    ----------------------------------------------------
    "neovim/nvim-lspconfig",
    ft = { "lua", "c", "cpp" },
    --如果打开event限制，ft就失效了。
    --event = { "BufReadPre", "BufNewFile" },
    enabled = not require("configs.utils").is_diff_mode(),

    opts = function() return require("lsp.lspconfig").opts() end,
    config = function(_, opts)
      require("lsp.lspconfig").setup(opts)
    end,
  },
  --{
  --  -----------------------------------
  --  -- nvim-lspconfig UI 增强 (可选) --
  --  -----------------------------------
  --  "nvimdev/lspsaga.nvim",
  --  event = "LspAttach",
  --  opts = {
  --    symbol_in_winbar = {
  --      enable = true,
  --      separator = " > ",
  --      show_file = true,
  --    },

  --    outline = {
  --      enable = true,
  --      keys = {
  --        toggle_or_jump = "<CR>",
  --      },
  --    },
  --  },
  --},
  {
    --------------------
    --- 语义解析插件 ---
    --------------------
    "nvim-treesitter/nvim-treesitter",
    enabled = not require("configs.utils").is_diff_mode(),
    build = ":TSUpdate",
    --event = { "BufReadPost", "BufNewFile" },
    ft = { "cpp", "c", "hpp", "h" , "lua"},
    opts = require("plugins.nvim-treesitter").opts,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  --{
  --  ------------------------
  --  --- 折叠函数头部信息 ---
  --  ------------------------
  --  "nvim-treesitter/nvim-treesitter-context",
  --  event = "VeryLazy",
  --  opts = require("plugins.nvim-treesitter-context").opts,
  --},
  --{
  --  --------------------------
  --  --- 更智能的LSP 函数ui ---
  --  --------------------------
  --  "folke/trouble.nvim",
  --  dependencies = { "nvim-tree/nvim-web-devicons" },
  --  keys = {
  --    { "gr",         "<cmd>Trouble lsp_references focus=true<cr>",       desc = "LSP Go to References" },
  --    { "gd",         "<cmd>Trouble lsp_definitions focus=true<cr>",      desc = "LSP Go to Definitions" },
  --    { "gi",         "<cmd>Trouble lsp_implementations focus=true<cr>",  desc = "LSP Go to Implementations" },
  --    { "<leader>ld", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics list diagnostics info(current buffer)" },
  --  },
  --  opts = {
  --    auto_close = true,       -- auto close when there are no items
  --    warn_no_results = false, -- show a warning when there are no results
  --  },
  --},
  {
    --------------------
    --- 按键提示插件 ---
    --------------------
    "folke/which-key.nvim",
    event = "VeryLazy",
    --cmd = "WhichKey",
    keys = { "<leader>", "<Space>" },
    opts = require("plugins.which-key").opts,
  },
  {
    ----------------------------------
    --- 自动记录项目路径，用来跳转 ---
    ----------------------------------
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    --cmd = "WhichKey",
    opts = require("plugins.project").opts,
    config = function(_, opts)
      require("project_nvim").setup(opts)
    end,
  },

}
