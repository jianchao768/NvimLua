return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    --cmd = "WhichKey",
    keys = { "<leader>", "<Space>" },
    opts = function()
      local settings = {
        delay = 500,
        triggers = {
          { "<leader>", mode = { "n", "v" } },
          { "<Space>",  mode = { "n" } },
        },
        icons = {
          mappings = true,
        },
      }
      return settings
    end,
  },
}
