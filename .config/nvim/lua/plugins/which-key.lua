return {
  --------------------
  --- 按键提示插件 ---
  --------------------
  "folke/which-key.nvim",
  event = "VeryLazy",
  --cmd = "WhichKey",
  keys = { "<leader>", "<Space>" },
  opts = {
    delay = 800,
    triggers = {
      { "<leader>", mode = { "n", "v" } },
      { "<Space>",  mode = { "n" } },
    },
    icons = {
      mappings = true,
    },
  }
}
