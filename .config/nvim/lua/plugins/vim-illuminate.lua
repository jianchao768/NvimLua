local M = {}

M.opts = {
  providers = { "lsp", "treesitter", "regex" }, -- 使用 LSP、Treesitter 和正则匹配高亮
  delay = 200, -- 延迟（毫秒）
  filetypes_denylist = { "NvimTree", "TelescopePrompt" }, -- 禁止高亮的文件类型
  large_file_cutoff = 4000, -- 超过 4000 行的文件不启用
  large_file_overrides = { providers = { "lsp" } }, -- 大文件仅使用 LSP 进行高亮
  undercurl = false,  -- 不使用下划线的额外样式，改为下面的 highlight 控制
}

M.init = function()
  -- 设置快捷键：跳转到上/下一个高亮单词
  --vim.keymap.set("n", "<leader>n", require("illuminate").goto_next_reference, { noremap = true, silent = true })
  --vim.keymap.set("n", "<leader>N", require("illuminate").goto_prev_reference, { noremap = true, silent = true })
  -- 设置高亮样式
  vim.api.nvim_set_hl(0, "IlluminatedWordText", { underline = true })
  vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underline = true })
  vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { underline = true })
end

return M

