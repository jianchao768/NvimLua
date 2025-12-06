return {
  {
    ------------------------------------------------
    ---Neovim LSP 客户端插件，但是关闭代码补全、跳转 ---
    ------------------------------------------------
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    enabled = not require("config.utils").is_diff_mode(),
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      --------------------------------
      -- 通用 on_attach 配置
      --------------------------------
      local on_attach = function(_, bufnr)
        local bufmap = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        --bufmap("n", "gd", vim.lsp.buf.definition, "LSP [G]oto [D]efinition")
        --bufmap("n", "gr", vim.lsp.buf.references, "LSP [G]oto [R]eferences")
        bufmap("n", "K", vim.lsp.buf.hover, "LSP Hover Documentation")
        bufmap("n", "<leader>rn", vim.lsp.buf.rename, "LSP [R]e[n]ame")
        bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "LSP [C]ode [A]ction")
        bufmap("n", "<leader>lf", function()
          vim.lsp.buf.format({ async = true })
        end, "LSP [F]ormat buffer")

        -- 提示启用
        vim.notify("LSP attached: " .. vim.bo.filetype, vim.log.levels.INFO)
      end

      --------------------------------
      -- 通用能力配置
      --------------------------------
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem = {
        documentationFormat = { "markdown", "plaintext" },   --告诉服务器可以返回 Markdown 格式的说明
        snippetSupport = true,                               --支持 snippet 占位符
        preselectSupport = true,                             --支持自动预选补全项
        insertReplaceSupport = true,                         --支持插入和替换模式的补全
        labelDetailsSupport = true,                          --补全标签支持附加信息
        deprecatedSupport = true,                            --支持标记废弃的补全项
        commitCharactersSupport = true,                      --支持 commit 字符
        tagSupport = { valueSet = { 1 } },                   --支持标签标记，这里 { valueSet = {1} } 通常表示废弃标签。
        resolveSupport = {            --当需要补全项的更多信息时，可以请求额外字段：
          properties = {
            "documentation",          --文档说明
            "detail",                 --类型或签名信息
            "additionalTextEdits",    --补全时的额外文本修改（比如自动添加 import）
          },
        },
      }

      -- disable semanticTokens
      local on_init = function(client, _)
        if vim.fn.has "nvim-0.11" ~= 1 then
          if client.supports_method "textDocument/semanticTokens" then
            client.server_capabilities.semanticTokensProvider = nil
          end
        else
          if client:supports_method "textDocument/semanticTokens" then
            client.server_capabilities.semanticTokensProvider = nil
          end
        end
      end

      --local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      --if ok_cmp then
      --  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      --end

      --------------------------------
      -- 语言服务器配置
      --------------------------------
      local servers = {
        -- C/C++
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            "--fallback-style=Google", -- default format style
            "--header-insertion=never",
            "--pch-storage=memory",
            "-j=8"
          },
          filetypes = { "c", "cpp", "objc", "objcpp" },  -- 只处理这些文件类型
          root_dir = function (fname)
            return lspconfig.util.root_pattern(".clangd-root", ".git", "compile_commands.json", "Android.mk")(fname)
            or vim.loop.cwd()
          end,
        },

        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },

        -- CMake
        cmake = {},
      }

      --------------------------------
      -- 初始化所有服务器
      --------------------------------
      mason_lspconfig.setup_handlers({
        function(server_name)
          local opts = servers[server_name] or {}
          opts.on_init = on_init
          opts.on_attach = on_attach
          opts.capabilities = capabilities
          opts.flags = { debounce_text_changes = 150 }  --延迟触发 LSP 的文本变化处理 ms
          lspconfig[server_name].setup(opts)
        end,
      })
    end,

    -- 配置 diagnostics 显示
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
        spacing = 2,
      },
      signs = true,              --显示左侧符号
      underline = true,          --错误显示下划线
      update_in_insert = false,  --插入模式不更新诊断
      severity_sort = true,      --按照严重程度排序
      float = {
        focusable = true,        --可以用 Ctrl-w 或 Esc 聚焦/关闭
        style     = "minimal",   --简约风格
        source = "always",
        border = "single",
      },
    }),
  },
  {
    -----------------------------------
    -- nvim-lspconfig UI 增强 (可选) --
    -----------------------------------
    --"nvimdev/lspsaga.nvim",
    --event = "LspAttach",
    --config = function()
    --  require("lspsaga").setup({
    --    symbol_in_winbar = {
    --      enable = true,
    --      separator = " > ",
    --      show_file = true,
    --    },
    --    outline = {
    --      enable = true,   -- 启用符号列表
    --      keys = {
    --        toggle_or_jump = "<CR>",
    --      },
    --    },
    --  })
    --end,
  },
}
