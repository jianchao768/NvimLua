return {
    -----------------------------------------------
    --- Neovim Git集成插件，在nvim中提供git状态 ---
    -----------------------------------------------
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        signs = {
            add          = { text = '❚' },
            change       = { text = '❚' },
            delete       = { text = '❚' },
            topdelete    = { text = '❚' },
            changedelete = { text = '❚' },
            untracked    = { text = '┆' },
        },
        signcolumn = true,  -- 始终显示标记列
        numhl      = false, -- 不要用行号高亮
        linehl     = false, -- 不要用行高亮
        watch_gitdir = {
            interval = 1000,  -- 文件监视间隔（ms）
            follow_files = true
        },
        attach_to_untracked = true, -- 显示未跟踪文件的标记
        current_line_blame = true,  -- 默认关闭当前行 blame
        current_line_blame_opts = {
            virt_text = true, -- 虚拟文本显示
            virt_text_pos = "eol",
            delay = 300, -- 延迟显示（ms）
            ignore_whitespace = false,    -- 是否忽略空白修改
            virt_text_priority = 100,
            use_focus = true,
        },
        on_attach = function()
            vim.cmd [[highlight GitSignsCurrentLineBlame guifg=#777777 gui=italic]]
        end,
        update_debounce = 200,      -- 降低更新频率（默认 100ms）
        _threaded_diff = true,     -- 启用异步差异计算（Neovim 0.10+）
        --excluded_filetypes = { "alpha", "dashboard", "NvimTree" },
    },
    config = function(_, opts)
        require("gitsigns").setup(opts)

        vim.keymap.set("n", "[g", ":Gitsigns prev_hunk<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "]g", ":Gitsigns next_hunk<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { noremap = true, silent = true })    --查看当前行的blame
        vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { noremap = true, silent = true })    --清楚修改
        vim.keymap.set("n", "<leader>gs", ":Gitsigns preview_hunk<CR>", { noremap = true, silent = true })  --查看当前行的改动
        vim.keymap.set('n', '<leader>ga', ":Gitsigns stage_hunk<CR>", { noremap = true, silent = true })    --将当前段git修改 add
    end
}
