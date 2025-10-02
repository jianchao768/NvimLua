return {
    ----------------------
    ---  自动补全插件  ---
    ----------------------
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        --{"hrsh7th/cmp-nvim-lsp", event = "InsertEnter"}, -- LSP源
        {"hrsh7th/cmp-buffer", event = "InsertEnter"},   -- Buffer 源
        {"hrsh7th/cmp-path", event = "InsertEnter" },    -- 路径补全
        {"hrsh7th/cmp-cmdline", event = "CmdlineEnter"},  -- 命令行补全
        --"saadparwaiz1/cmp_luasnip", -- Snippets 源
        --"L3MON4D3/LuaSnip",         -- Snippets 引擎
    },
    config = function()
        local cmp = require("cmp")

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(), -- `Ctrl+Space` 触发补全
            }),
            sources = cmp.config.sources({
                --{ name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
            }),
            completion = {
                completeopt = "menu,menuone,noinsert",
            },

            --界面美化
            formatting = {
                format = function(entry, vim_item)
                    -- 添加补全来源的标识
                    vim_item.menu = ({
                        --nvim_lsp = "[LSP]",
                        buffer = "[Buf]",
                        path = "[Path]",
                    })[entry.source.name]
                    return vim_item
                end,
            },
            -- 预选项行为，灰色虚影
            experimental = {
                ghost_text = true, -- 显示补全提示
            },
        })

        -- `/` 命令行补全
        -- 由于Nvim和cmp限制，无法改动窗口大小，所以要么开要么关
        --cmp.setup.cmdline("/", {
        --    mapping = cmp.mapping.preset.cmdline(),
        --    sources = {
        --        { name = "buffer" },
        --    },
        --})

    end
}

