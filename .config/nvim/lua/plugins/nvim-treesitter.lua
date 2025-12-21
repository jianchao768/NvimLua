local M = {}

M.opts = {
    ensure_installed = { "c", "cpp", "cmake", "lua" },
    sync_install = false,   -- 同步安装（推荐 false：异步下载更快）
    auto_install = true,    -- 自动安装缺失的解析器

    highlight = {
      enable = false,        -- 是否使用高亮,关闭高亮之后，cpp文件无法使用nvim_context_vt
      disable = function(lang, buf)
        local max_filesize = 5 * 1024 * 1024  -- 5MB
        local uv = vim.uv or vim.loop     -- ✅ 兼容新旧版本
        local ok, stats = pcall(uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      additional_vim_regex_highlighting = false,
    },

    indent = { enable = true },

    -- 扩展选取功能
    -- 关闭高亮后，可以手动触发这个选择器，来使能这个插件
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",        -- 初始化选择
        node_incremental = "<CR>",      -- 向上扩选
        node_decremental = "<BS>",      -- 向下缩选
        scope_incremental = "<TAB>",    -- 扩展作用域
      },
    },

    -- 函数、类快速跳转/选择
    --textobjects = {
    --  enable = true,
    --  select = {
    --    enable = true,
    --    lookahead = true,
    --    keymaps = {
    --      ["af"] = "@function.outer",
    --      ["if"] = "@function.inner",
    --      ["ac"] = "@class.outer",
    --      ["ic"] = "@class.inner",
    --    },
    --  },
    --  move = {
    --    enable = true,
    --    set_jumps = true,
    --    goto_next_start = {
    --      ["]m"] = "@function.outer",
    --      ["]]"] = "@class.outer",
    --    },
    --    goto_previous_start = {
    --      ["[m"] = "@function.outer",
    --      ["[["] = "@class.outer",
    --    },
    --  },
    --  swap = {
    --    enable = true,
    --    swap_next = {
    --      ["<leader>a"] = "@parameter.inner",
    --    },
    --    swap_previous = {
    --      ["<leader>A"] = "@parameter.inner",
    --    },
    --  },
    --}
}

return M

