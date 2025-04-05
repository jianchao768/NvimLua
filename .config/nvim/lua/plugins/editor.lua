return {
    {
        --------------------
        --- 括号自动补全 ---
        --------------------
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                check_ts = true,  -- 启用 Treesitter 进行更智能的匹配
            })
            -- 让 autopairs 和 nvim-cmp 兼容
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done)
        end

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
        config = function()
            require("colorizer").setup({
                filetypes = { "css", "html", "javascript", "lua", "vim", "markdown" },
                user_default_options = {
                    RGB = true,       -- 支持 `rgb(255, 0, 0)`
                    RRGGBB = true,    -- 支持 `#ff0000`
                    names = true,     -- 识别颜色名称，如 `red`
                    RRGGBBAA = true,  -- 支持带透明度的颜色 `#ff0000aa`
                    AARRGGBB = true,  -- `0xffff0000`
                    mode = "background",  -- 颜色预览显示模式（"foreground", "background", "virtualtext"）
                },
            })
        end
    },
}
