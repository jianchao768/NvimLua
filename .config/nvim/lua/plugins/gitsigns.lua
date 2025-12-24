return {
  -----------------------------------------------
  --- Neovim Git集成插件，在nvim中提供git状态 ---
  -----------------------------------------------
  "lewis6991/gitsigns.nvim",
  --event = {"BufReadPre", "BufNewFile" },
  event = {"VeryLazy"},
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    --icons eg: '❚' ,
    signs = {
      add          = { text = '┃' },
      change       = { text = '┃' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    signs_staged = {
      add          = { text = '┃' },
      change       = { text = '┃' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    signcolumn = true,  -- 始终显示标记列
    numhl      = false, -- 不要用行号高亮
    linehl     = false, -- 不要用行高亮
    watch_gitdir = {
      interval = 1000,  -- 文件监视间隔（ms）
      follow_files = true
    },
    attach_to_untracked = false, -- 显示未跟踪文件的标记
    current_line_blame = true,  -- 默认关闭当前行 blame
    current_line_blame_opts = {
      virt_text = true, -- 虚拟文本显示
      virt_text_pos = "eol",
      delay = 100, -- 延迟显示（ms）默认1000ms
      ignore_whitespace = false,    -- 是否忽略空白修改
      virt_text_priority = 100,
      use_focus = true,
    },
    current_line_blame_formatter = ' >>> <author>, <author_time:%R> - <summary> <abbrev_sha>',

    on_attach = function()
      vim.cmd [[highlight GitSignsCurrentLineBlame guifg=#777777 gui=italic]]
    end,
    update_debounce = 200,      -- 降低标记列更新频率（默认 100ms）
    _threaded_diff = true,     -- 启用异步差异计算（Neovim 0.10+）
    --excluded_filetypes = { "alpha", "dashboard", "NvimTree" },
  },
  config = function(_, opts)
    require("gitsigns").setup(opts)

    -- 折叠函数（你需要定义一次即可）
    _G.GitFoldExpr = function(lnum)
      local line = vim.fn.getline(lnum)
      if line:match("^diff %-%-git ") then
        return ">1"
      end
      return "="
    end
    _G.GitFoldText = function()
      local first = vim.fn.getline(vim.v.foldstart)
      local fname = first:match("^diff %-%-git%s+a/(.-)%s+b/")
      if fname then
        return "+-- " .. fname .. "  ┄┄ [" .. (vim.v.foldend - vim.v.foldstart + 1) .. " lines]"
      end
      return vim.fn.getline(vim.v.foldstart)
    end

    -------------------
    --- 这段是用来直接展示当前行git commit信息的代码
    --- 大概意思是，拷贝的gitsigns插件里面的实现
    -------------------
    local gitsigns = require('gitsigns')
    local async = require('gitsigns.async')
    local cache = require('gitsigns.cache').cache
    local api = vim.api

    -- 直接从源码中提取的 show_commit 函数
    local show_commit = async.async(function(win, open, bcache)
      local cursor = api.nvim_win_get_cursor(win)[1]
      local sha = bcache.blame[cursor].commit.sha
      local res = bcache.git_obj.repo:command({ 'show', sha })
      async.schedule()
      local buffer_name = bcache:get_rev_bufname(sha, true)
      local commit_buf = nil

      -- 查找已存在的 commit buffer
      for _, bufnr in ipairs(api.nvim_list_bufs()) do
        if api.nvim_buf_get_name(bufnr) == buffer_name then
          commit_buf = bufnr
          break
        end
      end

      if not commit_buf then
        commit_buf = api.nvim_create_buf(true, true)
        api.nvim_buf_set_name(commit_buf, buffer_name)
        api.nvim_buf_set_lines(commit_buf, 0, -1, false, res)
      end

      vim.cmd[open]({ mods = { keepalt = true } })
      api.nvim_win_set_buf(0, commit_buf)
      vim.bo[commit_buf].filetype = 'git'
      vim.bo[commit_buf].bufhidden = 'wipe'
      vim.bo[commit_buf].modifiable = false
      vim.bo[commit_buf].readonly = true
      --设置diff折叠
      vim.api.nvim_buf_set_option(commit_buf, 'foldmethod', 'expr')
      vim.api.nvim_buf_set_option(commit_buf, 'foldexpr', [[v:lua.GitFoldExpr(v:lnum)]])
      vim.api.nvim_buf_set_option(commit_buf, 'foldtext', [[v:lua.GitFoldText()]])
      vim.api.nvim_buf_set_option(commit_buf, 'foldenable', true)

      vim.cmd("silent! normal! zM")
    end)

    -- 安全封装函数
    local function safe_show_commit()
      local win = api.nvim_get_current_win()
      local bufnr = api.nvim_get_current_buf()
      local bcache = cache[bufnr]

      -- 确保缓存和blame数据存在
      if not bcache then
        vim.notify("Buffer not attached to gitsigns", vim.log.levels.WARN)
        return
      end

      -- 确保blame数据已加载
      if not bcache.blame then
        bcache:get_blame()
        if not bcache.blame then
          vim.notify("Failed to get blame data", vim.log.levels.ERROR)
          return
        end
      end

      -- 确保当前行有blame数据
      local cursor = api.nvim_win_get_cursor(win)[1]
      if not bcache.blame[cursor] then
        vim.notify("No blame info for current line", vim.log.levels.WARN)
        return
      end

      -- 调用内部show_commit函数
      show_commit(win, 'vsplit', bcache)
    end


    vim.keymap.set("n", "[g", ":Gitsigns prev_hunk<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "]g", ":Gitsigns next_hunk<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { noremap = true, silent = true })    --查看当前行的blame
    vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { noremap = true, silent = true })    --清楚修改
    vim.keymap.set("n", "<leader>gs", ":Gitsigns preview_hunk<CR>", { noremap = true, silent = true })  --查看当前行的改动
    vim.keymap.set('n', '<leader>ga', ":Gitsigns stage_hunk<CR>", { noremap = true, silent = true })    --将当前段git修改 add

    vim.keymap.set('n', '<leader>gc', safe_show_commit, { desc = "Show commit in vsplit" }) --查看当前行的commit详细信息
  end
}
