local m = { noremap = true }
return {
    ----------------------------
    ----    FZF-LUA 配置    ----
    ----------------------------
	"theniceboy/fzf-lua",
    keys = function()
        return {
            "<c-p>",
            "<leader>fg", "<leader>fl", "<leader>fb", "<leader>fw", "<leader>fW",
            "<leader>fc", "<leader>fr",
            "<leader>tt",
        }
    end,
	config = function()
		local fzf = require('fzf-lua')
        local opts = { fzf_opts = { ['--layout'] = 'reverse' } }
        local actions = require('fzf-lua.actions')
        ----
        --FZF 搜索工作目录下的文件
        ----
        vim.keymap.set('n', '<c-p>', function() fzf.files(opts) end, m)
        ----
        --FZF 搜索文件中的内容
        -- Leader+fg : 搜索工作目录下的所有文件
        -- Leader+fl : 重复上一次的grep搜索
        --
        -- Leader+fb : 在当前buffer（当前文件）中搜素行 （无正则，速度快）
        --
        -- Leader+gw : 在工作目录 搜索光标下的单词
        -- Leader+gW : 在工作目录 搜索光标下的单词（包含符号）
        -- Leader+gc : 在当前buffer（当前文件）中搜素
        --
        -- Leader+gr : 恢复上次fzf 搜索的状态
        ----
		vim.keymap.set('n', '<leader>fg', function() fzf.grep(vim.tbl_extend("force",{ search = ""}, opts )) end, m)
		vim.keymap.set('x', '<leader>fg', function() fzf.grep_visual(vim.tbl_extend("force",{ search = ""}, opts )) end, m)
		vim.keymap.set('n', '<leader>fl', function() fzf.grep_last(vim.tbl_extend("force",{ search = ""}, opts )) end, m)

        vim.keymap.set('n', '<leader>fb', function() fzf.blines(opts) end, m)

		vim.keymap.set('n', '<leader>fw', function() fzf.grep_cword(vim.tbl_extend("force",{ search = ""}, opts )) end, m)
		vim.keymap.set('n', '<leader>fW', function() fzf.grep_cWORD(vim.tbl_extend("force",{ search = ""}, opts )) end, m)
		vim.keymap.set('n', '<leader>fc', function() fzf.grep_curbuf(vim.tbl_extend("force",{ search = ""}, opts )) end, m)

		vim.keymap.set('n', '<leader>fr', function() fzf.resume() end, m)

        -------
        -- 其他
        -- Leader+tt : 查看tab
        vim.keymap.set('n', '<leader>tt', "<cmd>FzfLua tabs<CR>")

		fzf.setup({
			global_resume = true,
			global_resume_query = true,

			winopts = {
                --整体窗口大小
                border     = "none",
				height     = 0.90,
				width      = 0.70,
                row              = 0.35,            -- window row position (0=top, 1=bottom)
                col              = 0.50,            -- window col position (0=left, 1=right)
                backdrop   = 40, --不透明度

				fullscreen = false,
				preview    = {
                    --border     = "none",
                    hidden     = false, --是否隐藏预览 AAA
                    vertical   = 'up:45%', -- up|down:size
                    horizontal = 'right:60%', -- right|left:size
					layout = 'vertical',
					scrollbar = 'float',
				},
			},
			previewers = {
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
					syntax         = true,   -- preview syntax highlight?
					syntax_limit_l = 0,      -- syntax limit (lines), 0=nolimit
					syntax_limit_b = 1024 * 1024, -- syntax limit (bytes), 0=nolimit
					jump_to_line   = true,
					title          = false,
                    toggle_behavior = "extend", -- 控制隐藏 preview 后主窗口尺寸是否变化 AAA
				},
			},
			files = {
				-- previewer      = "bat",          -- uncomment to override previewer
				-- (name from 'previewers' table)
				-- set to 'false' to disable
				prompt       = 'Files❯ ',
				multiprocess = true, -- run command in a separate process
				git_icons    = true, -- show git icons?
				file_icons   = true, -- show file icons?
				color_icons  = true, -- colorize file|git icons
				-- executed command priority is 'cmd' (if exists)
				-- otherwise auto-detect prioritizes `fd`:`rg`:`find`
				-- default options are controlled by 'fd|rg|find|_opts'
				-- NOTE: 'find -printf' requires GNU find
				-- cmd            = "find . -type f -printf '%P\n'",
				find_opts    = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
				rg_opts      = "--color=never --files --hidden --follow -g '!.git'",
				fd_opts      = "--color=never --type f --hidden --follow --exclude .git",

                cwd_prompt             = true,      -- 目录太长就用简写
                cwd_prompt_shorten_len = 32,        -- shorten prompt beyond this length
                cwd_prompt_shorten_val = 1,         -- shortened path parts length
			},
			grep = {
                prompt            = 'Rg❯ ',
                input_prompt      = 'Grep For❯ ',
                multiprocess      = true,           -- run command in a separate process
                git_icons         = false,          -- show git icons?
                file_icons        = true,           -- show file icons (true|"devicons"|"mini")?
                color_icons       = true,           -- colorize file|git icons
				--rg_opts = "--column --line-number --color=always --smart-case --ignore-file=.fzfignore",
                ---- 参数 -----
                --- no-heading: 不显把文件名单独列一行
                rg_opts = "--column --line-number --no-heading --color=always --smart-case --ignore-file=.fzfignore --max-columns=4096 -e",
                grep_opts = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e",
				previewer = "builtin",
				jump_to_line = true,
			},
			buffers = {
				prompt        = 'Buffers❯ ',
				file_icons    = true, -- show file icons?
				color_icons   = true, -- colorize file|git icons
				sort_lastused = true, -- sort buffers() by last used
                cwd_only      = false, -- 只显示当前工作目录下的buffer？
			},
            tabs = {
                prompt            = 'Tabs❯ ',
                tab_title         = "Tab",
                tab_marker        = "<<",
                file_icons        = true,         -- show file icons (true|"devicons"|"mini")?
                color_icons       = true,         -- colorize file|git icons
                actions = {
                    -- actions inherit from 'actions.files' and merge
                    ["enter"]       = actions.buf_switch,
                    ["ctrl-x"]      = { fn = actions.buf_del, reload = true },
                },
                fzf_opts = {
                    -- hide tabnr
                    ["--delimiter"] = "[\\):]",
                    ["--with-nth"]  = '2..',
                },
            },
		})
	end

}
