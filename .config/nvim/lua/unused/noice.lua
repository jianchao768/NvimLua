return {
  "folke/noice.nvim",
  event = "VeryLazy", -- 延迟加载，避免影响启动
  dependencies = {
    "MunifTanjim/nui.nvim",      -- Noice 的 UI 基础依赖
    "rcarriga/nvim-notify",      -- 可选：更好的通知系统
  },
  opts = {
    lsp = {
      progress = {
        enabled = true,        -- ✅ 开启 LSP 加载进度显示
        format = "lsp_progress", -- 进度条样式
        format_done = "lsp_progress_done",
        throttle = 1000 / 30,  -- 限制刷新率
      },
      hover = { enabled = true },
      signature = { enabled = true, auto_open = { enabled = true } },
      message = { enabled = true },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },

    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
      {
        filter = {
          any = {
            { find = "^mark%-?%d?%s?" }, -- vim-mark mark-1
            { find = ".(%w+)\\>$" },     -- vim-mark /\<xxxxx\>
            { find = "^%s?cleared" },    -- mark-1 cleared
            { find = "^Cleared%sall" },  -- all marks cleared
            { find = "^%d%s?$" },
            { find = "^/.*" }            --mark-1/word
          },
        },
        view = "mini",
        opts = { skip = true },
      },
    },
    presets = {
      bottom_search = false,     -- 把搜索框放到底部
      command_palette = false,   -- 命令行浮窗居中
      long_message_to_split = true, -- 长消息放在分屏中
      inc_rename = false,       -- 不影响 inc-rename.nvim
      lsp_doc_border = true,    -- 给 LSP hover/签名加边框
    },
    throttle = 1000 / 30,            -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
    cmdline = {
      enabled = true,                -- enables the Noice cmdline UI
      format = {
        cmdline     = { pattern = "^:", icon = "", lang = "vim" },
        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
        search_up   = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        filter      = { pattern = "^:%s*!", icon = "$", lang = "bash" },
        lua         = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
        help        = { pattern = "^:%s*he?l?p?%s+", icon = "󰘥 " },
        input       = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
      },
    },
    messages = {
      -- NOTE: If you enable messages, then the cmdline is enabled automatically.
      -- This is a current Neovim limitation.
      enabled = true,      -- enables the Noice messages UI
      view_search = false, -- view for search count messages. Set to `false` to disable
    },
    health = {
      checker = true, -- Disable if you don't want health checks to run
    },
    views = {
      -- LSP进度框的位置
      mini = {
        timeout = 3000,
        align = "message-left",
        position = {
          row = -1,
          col = "100%",
          --col = "50%",
        },
        win_options = {
          winblend = 0,
        }
      },
      confirm = {
        position = {
          row = "50%",
          col = "50%",
        },
      },
    },
    hover = {
      enabled = true,
      silent = false, -- set to true to not show a message if hover is not available
    },
  },

  config = function(_, opts)
    require("noice").setup(opts)
    if vim.o.filetype == "lazy" then
      vim.cmd([[messages clear]])
    end
  end,
}

