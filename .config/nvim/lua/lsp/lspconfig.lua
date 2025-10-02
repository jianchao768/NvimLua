return {
    {
        ------------------------------------------------
        ---Neovim LSP 客户端插件，但是关闭代码补全、跳转 ---
        ------------------------------------------------
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local util = require("lspconfig.util")
            -- 通用的 on_attach 函数，用于绑定按键和设置 LSP 客户端行为
            local on_attach = function(client, bufnr)
                -- 禁用所有功能，只保留 documentSymbol
                    client.server_capabilities.definitionProvider = false
                    client.server_capabilities.referencesProvider = false
                    client.server_capabilities.hoverProvider = false
                    client.server_capabilities.renameProvider = false
                    client.server_capabilities.codeActionProvider = false
                    client.server_capabilities.completionProvider = false
                    client.server_capabilities.signatureHelpProvider = false
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                    client.server_capabilities.documentHighlightProvider = false
                    client.server_capabilities.semanticTokensProvider = nil
            end

            -- C/C++ LSP配置
            lspconfig.clangd.setup({
                on_attach = on_attach,
                --仅使用默认功能
                --capabilities = vim.lsp.protocol.make_client_capabilities(),

                cmd = {
                    "clangd",
                    "--background-index=false",      -- 禁用后台索引, 表示只分析当前份文件
                    "--clang-tidy=false",       -- 禁用静态分析,比如不规范写法等
                    "--header-insertion=never", -- 不自动插入头文件
                    "--limit-references=0",     -- 不计算引用，减少计算量
                    "--limit-results=10",       -- 限制引用、定义查找 返回的结果数量

                    "--pch-storage=memory",     -- 加快性能
                    "--log=error",              -- 只输出错误
                    "--enable-config=false",    -- 禁用 .clangd 配置文件
                },
                init_options = {
                    clangdFileStatus = false,  --提供文件状态反馈
                    usePlaceholders = true,   --减少解析开销
                    fallbackFlags = {},       -- 禁止添加默认编译参数
                },
                filetypes = { "c", "cpp", "objc", "objcpp" },  -- 限定文件类型
                handlers = {
                    -- 关闭其他 LSP 响应
                    ["textDocument/publishDiagnostics"] = function() end,  --这个关闭了左侧的E W 显示，但是LSP还会分析
                    ["textDocument/hover"] = function() end,
                    ["textDocument/signatureHelp"] = function() end,
                    ["textDocument/references"] = function() end,
                    ["textDocument/definition"] = function() end,
                    ["textDocument/implementation"] = function() end,
                    ["textDocument/typeDefinition"] = function() end,
                    ["textDocument/rename"] = function() end,
                    ["textDocument/formatting"] = function() end,
                    ["textDocument/rangeFormatting"] = function() end,
                    ["workspace/executeCommand"] = function() end,
                    ["workspace/symbol"] = function() end,
                },

                -- 自定义 root_dir 逻辑
                -- 这样 clangd 会 依次查找 .clangd-root、.git、compile_commands.json、Android.mk，找到的第一个即为 根目录。
                -- 目的是自己新建一个.clangd-root 文件，直接指定根目录 //这个是只下载所需的单独仓，等等
                root_dir = function (fname)
                    return util.root_pattern(".clangd-root", ".git", "compile_commands.json", "Android.mk")(fname)
                    or vim.loop.cwd()
                end,

                settings = {
                    clangd = {
                        --compilationDatabasePath = "out/target/product", -- 适用于 AOSP 项目, 用于指定 compile_commands.json 位置。
                        --offsetEncoding = { "utf-8" },  -- 避免符号跳转问题
                        fallbackFlags = { "-std=c++20" }, -- 没有 compile_commands.json 时，默认使用 C++20 编译。
                    },
                },
            })
        end
    },
    {
        -----------------------------------
        -- nvim-lspconfig UI 增强 (可选) --
        -----------------------------------
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        config = function()
            require("lspsaga").setup({
                --禁用所有不需要的功能
                definition = false,   --禁用跳转定义
                finder = false,       --禁用查找引用
                hover =false,         --禁用悬浮提示
                code_action = false,  --禁用代码操作
                rename = false,       --禁用重命名
                diagnostic = { enable = false, },   --禁用诊断提示
                lightbulb  = { enable = false, },   --禁用灯泡提示

                symbol_in_winbar = {
                    enable = true,
                    separator = " > ",
                    show_file = true,
                },
                outline = {
                    enable = true,   -- 启用符号列表
                    keys = {
                        toggle_or_jump = "<CR>",
                    },
                },
            })
        end,
    },
}

