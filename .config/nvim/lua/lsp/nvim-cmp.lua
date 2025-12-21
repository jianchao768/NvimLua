return {
  -----------------------
  --   nvim-cmp 插件  ---
  -----------------------
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
  },

  opts = function()
    local cmp = require("cmp")

    return {
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"]   = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"]    = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
      }),

      completion = {
        completeopt = "menu,menuone,noinsert",
      },

      formatting = {
        format = function(entry, item)
          item.menu = ({
            nvim_lsp = "[LSP]",
            buffer   = "[Buf]",
            path     = "[Path]",
          })[entry.source.name]
          return item
        end,
      },

      experimental = {
        ghost_text = true,
      },
    }
  end,
  --init = function()
  --  -- Lazy 官方推荐：cmdline 配置用 CmdlineEnter 触发
  --  vim.api.nvim_create_autocmd("CmdlineEnter", {
  --    pattern = "/",
  --    callback = function()
  --      local cmp = require("cmp")
  --      cmp.setup.cmdline("/", {
  --        mapping = cmp.mapping.preset.cmdline(),
  --        sources = {
  --          { name = "buffer" },
  --        },
  --      })
  --    end,
  --  })
  --end
}
