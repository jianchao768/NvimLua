return {
  ---------------------
  ----  命令行插件 ----
  ---------------------
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "SmiteshP/nvim-navic",
  },

  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,

  opts = function()
    local navic_ok, navic = pcall(require, "nvim-navic")

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand "%:t") ~= 1
      end,

      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    return {
      options = {
        icons_enabled = true,
        theme = "gruvbox-material",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        disabled_filetypes = {
          statusline = { "alpha", "NvimTree", "toggleterm", "tagbar", "aerial", "Outline"},
          winbar     = { "alpha", "NvimTree", "toggleterm", "tagbar", "aerial", "Outline"},
        },
        ignore_focus = { "NvimTree", "tagbar", "gitsigns-blame" },
        refresh = {
          statusline = 500,
          tabline = 1000,
          winbar = 1000,
        },
      },

      sections = {
        lualine_a = { "mode" },

        lualine_b = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " " },
          },
        },

        lualine_c = {
          {
            "filename",
            file_status = true,
            path = 1,   -- 0: 只文件名; 1: 相对路径; 2: 绝对路径; 3: ~ 替换家目录
            shorting_target = 40,-- 太长时缩写目标长度
            cond = conditions.buffer_not_empty,  --文件不为空的时候显示
          },
          {
            function()
              return navic_ok and navic.get_location() or ""
            end,
            cond = function()
              return navic_ok and navic.is_available()
            end,
            color = { fg = "#B8C3Ba" },
          },
        },

        lualine_x = {
          {
            require("configs.lsp_progress").get,
            --require("configs.lsp_progress2")
          },

          {
            function()
              local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
              for _, client in ipairs(vim.lsp.get_clients()) do
                if client.attached_buffers[buf] and client.name ~= "null-ls" then
                  return (vim.o.columns > 100 and " " .. client.name) or " LSP"
                end
              end
              return ""
            end,
            color = { fg = "#ff9e64" },
          },
          --'encoding','filetype', { 'filesize', cond = conditions.buffer_not_empty, }
        },

        lualine_y = { "selectioncount", "location" ,
        --{
          --  function()
            --    local line = vim.fn.line('.')
            --    local col = vim.fn.col('.')
            --    return string.format('%d,%d', line, col)
            --  end,
            --  padding = { left = 1, right = 1 },
            --},
          },

          lualine_z = {
            "progress",
            {
              function()
                return vim.fn.fnamemodify(vim.loop.cwd(), ":t")
              end,
              fmt = function(str)
                --return "󰉋 " .. str
                return " " .. str
              end,
              color = { fg = "#458588", bg = "#32302f" },
            },
          },
        },

        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = { "fugitive", "nvim-tree" }
      }
    end
  }
