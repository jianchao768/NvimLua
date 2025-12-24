return {
  "stevearc/conform.nvim",
  keys = {
    -- 格式化整个文件
    --{
    --  "<leader>cf",
    --  function()
    --    require("conform").format({ async = true, lsp_fallback = false })
    --  end,
    --  mode = "n",
    --  desc = "Format file with clang-format",
    --},

    -- 格式化选中区域
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = false })
      end,
      mode = "v",
      desc = "Format selected range with clang-format",
    },
  },
  opts = {
    --format_on_save = {
    --  timeout_ms = 500,
    --},
    formatters_by_ft = {
      cpp = { "clang_format" },
      c = { "clang_format" },
    }
  }
}
