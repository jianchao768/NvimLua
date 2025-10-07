return {
  -----------------------------
  --- 颜色主题插件 ------------
  -----------------------------
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = false,
        underline = true,
        bold = true,
        italic = {
          strings = false,
          emphasis = false,
          comments = false,
          operators = false,
          folds = false,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {
          ["@variable"] = { link = "Normal" },
          ["@field"] = { link = "Normal" },
          ["@property"] = { link = "Normal" },
          ["@parameter"] = { link = "Normal" },
          ["@constant"] = { link = "Normal" },
          ["@type"] = { link = "Type" },
          ["@function"] = { link = "Function" },
        },
        dim_inactive = false,
        transparent_mode = false,
      })
      vim.cmd("colorscheme gruvbox")
      vim.cmd [[
      augroup MyDiffHighlight
      autocmd!
      autocmd FileType diff highlight DiffAdd    cterm=reverse ctermfg=142 ctermbg=235 guifg=#b8bb26 guibg=#282828
      autocmd FileType diff highlight DiffChange cterm=reverse ctermfg=108 ctermbg=235 guifg=#8ec07c guibg=#282828
      autocmd FileType diff highlight DiffDelete cterm=reverse ctermfg=167 ctermbg=235 guifg=#fb4934 guibg=#282828
      autocmd FileType diff highlight DiffText   cterm=reverse ctermfg=214 ctermbg=235 guifg=#fabd2f guibg=#282828
      augroup END
      ]]

    end,
  },
}
