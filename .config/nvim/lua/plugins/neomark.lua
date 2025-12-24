return {
  ---------------------------
  ---  Neovim MARK 插件   ---
  ---------------------------
  "winter233/neomark.nvim",

  keys = {
    { "m",          function() require("neomark").toggle() end, desc = "Mark/Unmark word" },
    { "<leader>mc", function() require("neomark").clear()  end, desc = "Clear marks" },
    { "<c-p>",      function() require("neomark").prev({ recursive = true }) end, desc = "Prev mark" },
    { "<c-n>",      function() require("neomark").next({ recursive = true }) end, desc = "Next mark" },
    { "<leader>[",  function() require("neomark").prev({ recursive = true, any = true }) end, desc = "Prev any mark" },
    { "<leader>]",  function() require("neomark").next({ recursive = true, any = true }) end, desc = "Next any mark" },
  },
  opts = {
    colors = {
      '#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF',
      '#FF9EBB', '#B5EAD7', '#C7CEEA', '#FFFACD', '#E6E6FA', '#D5AAFF'
    },
  },
  --config = function(_, opts)
  --  require("neomark").setup(opts)
  --end,
}
