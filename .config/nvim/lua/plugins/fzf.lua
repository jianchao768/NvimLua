local local_opts = {
  search = "",
  fzf_opts = { ["--layout"] = "reverse" },
}

return {
  ----------------------------
  ----    FZF-LUA 配置    ----
  ----------------------------
  "ibhagwan/fzf-lua",
  keys = {
    -- File --
    { "<Space>f",   "<cmd>FzfLua files<CR>",                               mode = "n", desc = "Find files" },
    { "<leader>ff",
      function()
        local text = require("fzf-lua.utils").get_visual_selection()
        if text == "" then
          vim.notify("No text selected!", vim.log.levels.WARN, { title = "fzf-lua" })
          return
        end
        require("fzf-lua").files({ fzf_opts = { ["--query"] = text } })
      end,
      mode = "v", desc = "Fzf: search file by selected text",
    },
    { "<leader>fo", "<cmd>FzfLua oldfiles<CR>",                             mode = "n", desc = "Find old files" },
    { "<leader>fs", "<cmd>FzfLua git_status<CR>",                           mode = "n", desc = "Check git status" },
    { "<leader>p",  function() require("configs.utils").fzf_projects() end, mode = "n", desc = "Search projects (fzf-lua + project.nvim)" },

    -- Grep --
    { "<leader>fg", function() require("fzf-lua").grep(
      vim.tbl_extend("force", { search  = "" }, local_opts)) end,           mode = "n", desc = "Grep selection" },
    { "<leader>fg", function() require("fzf-lua").grep_visual(
      vim.tbl_extend("force", { search  = "" }, local_opts)) end,           mode = "x", desc = "Grep visual selection" },
    { "<leader>fl", "<cmd>FzfLua grep_last<CR>",                            mode = "n", desc = "Repeat last grep" },
    { "<leader>fb", "<cmd>FzfLua blines<CR>",                               mode = "n", desc = "Search lines in current buffer" },

    { "<leader>fw", "<cmd>FzfLua grep_cword<CR>",                           mode = "n", desc = "Grep word under cursor" },
    { "<leader>fW", "<cmd>FzfLua grep_cWORD<CR>",                           mode = "n", desc = "Grep WORD under cursor" },
    { "<leader>fc", "<cmd>FzfLua grep_curbuf<CR>",                          mode = "n", desc = "Grep current buffer" },
    { "<leader>fc",
      function()
        local text = require("fzf-lua.utils").get_visual_selection()
        if text == "" then
          vim.notify("No text selected!", vim.log.levels.WARN, { title = "fzf-lua" })
          return
        end
        require("fzf-lua").grep_curbuf({
          prompt = "GCurbuf> ",
          fzf_opts = { ["--query"] = text }
        })
      end,
      mode = "v", desc = "Fzf: search selected text int current buffer",
    },

    { "<leader>fr", "<cmd>FzfLua resume<CR>",                               mode = "n", desc = "Resume last fzf" },
    --{ "<leader>ft", "<cmd>FzfLua tags<CR>",                               mode = "n", desc = "Search tags" },
    { "<leader>ft", function() require("fzf-lua").tags(
      { prompt = "Tags> " }) end,                                           mode = "n", desc = "Search tags" },
    { "<leader>ft",
      function()
        local text = require("fzf-lua.utils").get_visual_selection()
        if text == "" then
          vim.notify("No text selected!", vim.log.levels.WARN, { title = "fzf-lua" })
          return
        end
        require("fzf-lua").tags({
          prompt = "Tags> ",
          fzf_opts = { ["--query"] = text },
        })
      end,
      mode = "v", desc = "Search tags by selected text",
    },

    -- LSP --
    { "<leader>lw", function() require("fzf-lua").diagnostics_workspace({ prompt = "[LSP] Diagnostics> ", }) end, mode = "n", desc = "LSP Diagnostics", },
    { "<leader>ld", function() require("fzf-lua").lsp_definitions({ prompt       = "[LSP] Definitions> ", }) end, mode = "n", desc = "LSP Definitions", },
    { "<leader>lr", function() require("fzf-lua").lsp_references({ prompt        = "[LSP] References> ", }) end, mode = "n", desc = "LSP References", },
    { "<leader>lc", function() require("fzf-lua").diagnostics_document({ prompt  = "[LSP] Doc_Diagnostics> ", }) end, mode = "n", desc = "LSP Document Diagnostics", },
    { "<leader>lw", function() require("fzf-lua").diagnostics_workspace({ prompt = "[LSP] WS_Diagnostics> ", }) end, mode = "n", desc = "LSP Workspace Diagnostics", },
    { "<leader>ls", function() require("fzf-lua").lsp_document_symbols({ prompt  = "[LSP] Doc_Symbols> ", }) end, mode = "n", desc = "LSP Document Symbols", },
    { "<leader>lS", function() require("fzf-lua").lsp_workspace_symbols({ prompt = "[LSP] WS_Symbols> ", }) end, mode = "n", desc = "LSP Workspace Symbols", },
  },
  opts = function()
    local searching_h_only = false

    return {
      global_resume = true,
      global_resume_query = true,

      winopts = {
        --整体窗口大小
        border     = "none",          -- 边框样式，可选: "none", "single", "double", "rounded", "solid", "shadow"
        height     = 0.90,
        width      = 0.70,
        row        = 0.35,            -- window row position (0=top, 1=bottom)
        col        = 0.50,            -- window col position (0=left, 1=right)
        backdrop   = 40, --不透明度
        --title         = "Title",
        --title_pos     = "center",   -- 'left', 'center' or 'right'
        --title_flags   = false,      -- uncomment to disable title flags

        fullscreen = false,
        preview    = {
          border     = "single",
          hidden     = false,       --是否隐藏预览 AAA
          vertical   = 'up:45%',    -- up|down:size
          horizontal = 'right:60%', -- right|left:size
          layout     = 'vertical',
          scrollbar  = 'float',
        },
      },
      previewers = {
        cat = {
          cmd  = "cat",
          args = "-n",
        },
        bat = {
          cmd  = "bat",
          args = "--color=always --style=numbers,changes",
        },
        head = {
          cmd  = "head",
          args = nil,
        },
        git_diff = {
          cmd_deleted   = "git diff --color HEAD --",
          cmd_modified  = "git diff --color HEAD",
          cmd_untracked = "git diff --color --no-index /dev/null",
          -- pager        = "delta",      -- if you have `delta` installed
        },
        man = {
          cmd = "man -c %s | col -bx",
        },
        builtin = {
          syntax          = true,        -- preview syntax highlight?
          syntax_limit_l  = 0,           -- syntax limit (lines), 0=nolimit
          syntax_limit_b  = 1024 * 1024, -- syntax limit (bytes), 0=nolimit
          jump_to_line    = true,
          title           = false,
          toggle_behavior = "extend",    -- 控制隐藏 preview 后主窗口尺寸是否变化 AAA
        },
      },
      files = {
        -- previewer      = "bat",       -- uncomment to override previewer
        -- (name from 'previewers' table)
        -- set to 'false' to disable
        prompt       = 'Files❯ ',
        multiprocess = true,  -- run command in a separate process
        git_icons    = false, -- show git icons?
        file_icons   = false, -- show file icons?
        color_icons  = false, -- colorize file|git icons
        -- executed command priority is 'cmd' (if exists)
        -- otherwise auto-detect prioritizes `fd`:`rg`:`find`
        -- default options are controlled by 'fd|rg|find|_opts'
        -- NOTE: 'find -printf' requires GNU find
        -- cmd            = "find . -type f -printf '%P\n'",
        find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
        rg_opts   = "--color=never --files --hidden --follow -g '!.git'",
        fd_opts   = "--color=never --type f --hidden --follow --exclude .git --exclude .cache --exclude node_modules",
        dir_opts  = [[/s/b/a:-d]],

        cwd_prompt             = true,      -- 显示目录
        cwd_prompt_shorten_len = 32,        -- shorten prompt beyond this length
        cwd_prompt_shorten_val = 1,         -- shortened path parts length

      },
      grep = {
        prompt            = 'Rg❯ ',
        input_prompt      = 'Grep For❯ ',
        multiprocess      = true,           -- run command in a separate process
        git_icons         = false,          -- show git icons?
        file_icons        = false,          -- show file icons (true|"devicons"|"mini")?
        color_icons       = false,          -- colorize file|git icons
        ---- 参数 -----
        --- no-heading: 不显把文件名单独列一行
        --- 默认不搜索 .h文件，需要Ctrl-h 切换
        rg_opts      = "--line-number --no-heading --color=always --smart-case --max-columns=4096 --column -g '!*.h' -e",
        grep_opts    = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e",
        previewer    = "builtin",
        jump_to_line = true,
        actions = {
          ["ctrl-h"] = function(selected, opts)
            searching_h_only = not searching_h_only
            local new_rg_opts = searching_h_only
            and "--line-number --no-heading --color=always --smart-case --max-columns=4096 --column -e"
            or "--line-number --no-heading --color=always --smart-case --max-columns=4096 --column -g '!*.h' -e"
            local new_prompt = searching_h_only and "Rg_.h> " or "Rg❯ "
            require('fzf-lua').live_grep({
              rg_opts = new_rg_opts,
              prompt  = new_prompt,
              search  = opts.query or "",   -- 保持搜索内容
            })
          end,
        },
      },
      buffers = {
        prompt        = 'Buffers❯ ',
        file_icons    = false, -- show file icons?
        color_icons   = false, -- colorize file|git icons
        sort_lastused = true,  -- sort buffers() by last used
        cwd_only      = false, -- 只显示当前工作目录下的buffer？
      },
      grep_cword = {
        prompt = "Word❯ ",
      },
      oldfiles = {
        prompt = "History❯ ",
      },
      git = {
        files   = { prompt = "GitFiles❯ " },
        status  = { prompt = "GitStatus❯ " },
        commits = { prompt = "Commits❯ " },
      },
    }
  end,
}
