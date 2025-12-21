
require("configs.options")
require("configs.keymaps")
require("configs.autocmd")

vim.opt.rtp:prepend("~/.config/lib/lazy.nvim-11.17.1")
local lazy_config = require "configs.lazy"

require("lazy").setup({
  { import = "plugins" },
  { import = "lsp" },
}, lazy_config)

