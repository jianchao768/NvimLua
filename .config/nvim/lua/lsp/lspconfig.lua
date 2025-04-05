return {
    {
        ------------------------------------------------
        ---Neovim LSP 客户端插件，提供代码补全、跳转 ---
        ------------------------------------------------
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local util = require("lspconfig.util")
            -- 通用的 on_attach 函数，用于绑定按键和设置 LSP 客户端行为
            local on_attach = function(client, bufnr)
                local opts = { buffer = bufnr, silent = true }

                -- LSP 相关快捷键
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
            end

            -- Lua LSP配置
            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = {
                            globals = { "vim" }, --允许识别vim全局变量
                            disable = { "lowercase-global" }, -- 关闭某些无关的警告
                        },
                        workspace = {
                            checkThirdParty = false,
                            --增加最大预加载文件数，但是超过数量会提示。。。
                            --如果在拥有三套Nvim配置的文件夹下 打开test.lua 会一直加载
                            --lua-language-server 进程CPU占用率90%，是个很大的bug
                            --但是简单项目没问题
                            maxPreload = 5000,
                            preloadFileSize = 500, -- 允许最大文件大小(KB)
                            ignoreDir = { -- 忽略无关目录
                                ".git",
                                "node_modules",
                                "lib",
                                "meta",
                                "Nvim-lua-4.4",
                                "build",
                                ".cache",
                            },
                            library = false, -- 关闭worksapce 自动索引
                            propmt = false, -- 关闭 "Increase upper limit" 提示，直接取消
                        },
                        telemetry = { enable = false }, -- 禁用 telemetry 数据收集
                    },
                },
            })

            -- 设置补全支持，这里去访问 nvim-cmp 配置的内容了
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            -- C/C++ LSP配置
            lspconfig.clangd.setup({
                on_attach = on_attach,
                capabilities = capabilities,

                cmd = {
                    "clangd",
                    "--background-index", -- 后台建立索引，提高补全速度
                    "--clang-tidy",       -- 启用 clang-tidy 进行代码分析
                    "--completion-style=detailed",  -- 详细补全信息
                    "--header-insertion=never",  -- 关闭头文件自动插入
                },
                filetypes = { "c", "cpp", "objc", "objcpp" },  -- 限定文件类型

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
                lightbulb = {
                    enable = true, --开启灯泡
                    sign = false, --不在左侧显示灯泡
                    virtual_text = true, -- 让灯泡显示再行尾
                }
            })
        end,
    },
}

