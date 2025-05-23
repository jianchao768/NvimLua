return {
    --{
    --    --------------------------------------------------------------
    --    --- nvim-treesitter 的可视化调试工具，允许你检查语法树结构，--
    --    --- 方便调试 Treesitter 的解析情况。                        --
    --    --- :Inspect 显示高亮组 
    --    --- :InspectTree 显示已解析的语法树
    --    --- :EditQuery 打开实时编辑器
    --    --------------------------------------------------------------
    --    "nvim-treesitter/playground",
    --    cmd = {"TSPlaygroundToggle",},
    --},
    --{
    --    --------------------------------------------------------------------
    --    --- Neovim 语法解析插件，提供更强大的 高亮、缩进、代码折叠等功能 ---
    --    --------------------------------------------------------------------
    --    "nvim-treesitter/nvim-treesitter",
    --    event = { "BufReadPost", "BufNewFile" },
    --    build = ":TSUpdate",  -- 确保安装时自动更新解析器
    --    config = function ()
    --        vim.defer_fn(function ()
    --            vim.opt.smartindent = false --关闭 Neovim 的 smartindent，避免 Treesitter 和默认缩进规则冲突。
    --            require ("nvim-treesitter.configs").setup {
    --                --能git clone时再打开,不然会自动下载
    --                ensure_installed = { "c", "lua", "vim", "cpp" , "make" , "bash",},
    --                sync_install = false,
    --                auto_install = false, -- 关闭自动安装，手动 `:TSInstall` 更安全
    --                ignore_install = {},

    --                highlight = {
    --                    enable =  true,
    --                    disable = {}
    --                    --disable = function(_, buf)
    --                    --    local max_filesize = 200 * 1024 -- 200 KB
    --                    --    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --                    --    if ok and stats and stats.size > max_filesize then
    --                    --        return true
    --                    --    end
    --                    --end,
    --                },
    --                indent = { --缩进规则
    --                    enable = true,
    --                    disable = function(lang, bufnr)
    --                        local disallowed_filetypes = { "yaml", "dart" }
    --                        return vim.tbl_contains(disallowed_filetypes, lang)
    --                    end,
    --                },
    --            }
    --            --vim.opt.runtimepath:append("~/.local/share/nvim/site/parser")
    --            vim.opt.runtimepath:append(vim.fn.expand("~/.local/share/nvim/site/parser"))
    --        end, 100)
    --    end
    --},
    --{
    --    ----------------------------------
    --    --- 再顶部固定函数 ---
    --    ----------------------------------
    --    "nvim-treesitter/nvim-treesitter-context",
    --    event = "BufReadPost", --文件加载完后再初始化
    --    config = function()
    --        require("treesitter-context").setup({
    --            enable = true,
    --            max_lines = 3, -- 最大显示3行上下文
    --            trim_scope = "outer", --只显示最外层的作用域
    --            min_window_height = 10,    -- 只在窗口高度 >=10 时显示
    --            lint_numbers = true,       -- 是否显示行号
    --            multiline_threshold = 20,  -- 如果上下文超过20行，会折叠为单行
    --            mode = "cursor",           -- 只有光标进入函数时才显示
    --            zindex = 20,               -- 层级
    --            on_attach = nil,           -- 所有缓冲区都使用
    --        })
    --        vim.keymap.set("n", "[c", function()
    --            tscontext.go_to_context()
    --        end, { silent = true })
    --    end
    --},
}
