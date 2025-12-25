return {
  {
    ----------------------------------------------------
    ---Neovim LSP 客户端插件，但是关闭代码补全、跳转 ---
    ----------------------------------------------------
    "neovim/nvim-lspconfig",
    --ft = { "lua", "c", "cpp" },
    --event = { "BufReadPre", "BufNewFile" },
    --如果打开event限制，ft就失效了。
    --好像lsp不能放到VeryLazy,否则LSP检测会失效
    event = "User FilePost",
    enabled = not require("configs.utils").is_diff_mode(),

    opts = function()
      local lspconfig = require("lspconfig")

      ------------------------------------------------
      -- 通用 on_attach 
      ------------------------------------------------
      local function on_attach(_, bufnr)
        local bufmap = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        --bufmap("n", "gd", vim.lsp.buf.definition, "LSP [G]oto [D]efinition")
        --bufmap("n", "gr", vim.lsp.buf.references, "LSP [G]oto [R]eferences")
        bufmap("n", "K", vim.lsp.buf.hover, "LSP Hover Documentation")
        bufmap("n", "<leader>rn", vim.lsp.buf.rename, "LSP Rename")
        bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "LSP [C]ode [A]ction")
        bufmap("n", "<leader>lf", function()
          vim.lsp.buf.format({ async = true })
        end, "LSP Format")

        -- 提示启用
        vim.notify("LSP attached: " .. vim.bo.filetype, vim.log.levels.INFO)
      end

      ------------------------------------------------
      -- 通用 capabilities
      ------------------------------------------------
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

      ------------------------------------------------
      -- 禁用 semanticTokens
      ------------------------------------------------
      local function on_init(client, _)
        if client.supports_method("textDocument/semanticTokens") then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end

      ------------------------------------------------
      -- 各语言 LSP 配置
      ------------------------------------------------
      local servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            "--fallback-style=Google",
            "--header-insertion=never",
            "--pch-storage=memory",
            "-j=8",
          },
          filetypes = { "c", "cpp", "objc", "objcpp" },
          root_dir = function(fname)
            return lspconfig.util.root_pattern(
              ".clangd-root",
              ".git",
              "compile_commands.json",
              "Android.mk"
            )(fname) or vim.loop.cwd()
          end,
        },

        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },

        cmake = {},
      }

      ------------------------------------------------
      -- diagnostics 显示
      ------------------------------------------------
      local diagnostics = {
        virtual_text = { prefix = "●", spacing = 2 },
        signs = true,              --显示左侧符号
        underline = true,          --错误显示下划线
        update_in_insert = false,  --插入模式不更新诊断
        severity_sort = true,      --按照严重程度排序
        float = {
          focusable = true,
          style = "minimal",
          source = "always",
          border = "single",
        },
      }

      return {
        servers = servers,
        capabilities = capabilities,
        on_attach = on_attach,
        on_init = on_init,
        diagnostics = diagnostics,
      }
    end,
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      -- 配置 diagnostics
      vim.diagnostic.config(opts.diagnostics)

      mason_lspconfig.setup_handlers({
        function(server_name)
          local cfg = opts.servers[server_name] or {}
          cfg.on_attach = opts.on_attach
          cfg.on_init = opts.on_init
          cfg.capabilities = opts.capabilities
          cfg.flags = { debounce_text_changes = 150 }

          lspconfig[server_name].setup(cfg)
        end,
      })
    end,
  },
  --{
  --  -----------------------------------
  --  -- nvim-lspconfig UI 增强 (可选) --
  --  -----------------------------------
  --  "nvimdev/lspsaga.nvim",
  --  event = "LspAttach",
  --  opts = {
  --    symbol_in_winbar = {
  --      enable = true,
  --      separator = " > ",
  --      show_file = true,
  --    },

  --    outline = {
  --      enable = true,
  --      keys = {
  --        toggle_or_jump = "<CR>",
  --      },
  --    },
  --  },
  --},
}
