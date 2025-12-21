return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  --ft = { "lua", "c", "cpp"},
  event = { "VeryLazy"},

  opts = {
    indent = {
      char = { "│", "¦", "┆", "┊" },
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
      highlight = { "IblScope" },
      --highlight = { "Function", "Label" }, -- 可按需定制高亮
    },
    exclude = {
      filetypes = {
        "help",
        "startify",
        "dashboard",
        "lazy",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "noice",
      },
      buftypes = { "terminal", "nofile" },
    },
  },
  config = function(_, opts)
    local ibl = require("ibl")
    local hooks = require("ibl.hooks")

    -- scope 颜色
    vim.api.nvim_set_hl(0, "IblScope", { fg = "#7c6f64" })

    -- indent 颜色
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#504945" })
    end)
    -- LSP attach 时单独开启 scope
    --hooks.register(hooks.type.EVENT_LSP_ATTACH, function(_, bufnr)
    --  require("ibl").setup_buffer(bufnr, {
    --    scope = { enabled = true },
    --  })
    --end)

    ibl.setup(opts)
  end
}
