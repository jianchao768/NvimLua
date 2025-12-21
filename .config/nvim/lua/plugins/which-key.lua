local M = {}

M.opts = {
    delay = 800,
    triggers = {
      { "<leader>", mode = { "n", "v" } },
      { "<Space>",  mode = { "n" } },
    },
    icons = {
      mappings = true,
    },
}

return M
