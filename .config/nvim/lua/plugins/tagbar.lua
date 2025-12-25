return {
  -------------------------------
  --- Tagbar 侧边栏显示函数名 ---
  -------------------------------
  --- fd -e h -e cpp -e c <dir> > files
  --- ctags -L files
  --- --- --- --- --- --- --- ---
  "preservim/tagbar",
  cmd = "TagbarToggle",
  keys = {
    { "<F8>",      "<cmd>TagbarToggle<CR>", mode = "n", desc = "Toggle Tagbar" },
    { "<leader>t", "<cmd>TagbarToggle<CR>", mode = "n", desc = "Toggle Tagbar" },
  },
  init = function()
    --vim.o.updatetime = 100 --把这个去掉就不会自动高亮了。。
    vim.g.tagbar_width = 25
    vim.g.tagbar_left = 1
    --vim.g.tagbar_autofocus = 1
    vim.g.tagbar_sort = 1
    --vim.g.tagbar_autoshowtag = 1
    --vim.g.tagbar_autoshow_highlight = 1
    vim.g.tagbar_autoshow_highlight = 0

    --防止解析lambda表达式
    vim.g.tagbar_ctags_args = '--exclude=auto --exclude=*lambda* --c++-kinds=+pf --fields=+niaS --extras=+q'
    vim.g.tagbar_type_cpp = {
      ctagsbin = "ctags",
      ctagstype = "c++",
      kinds = {
        "c:classes",
        "d:macros",
        "e:enumerators",
        "f:functions",
        "g:enums",
        "m:members",
        "n:namespaces",
        "p:prototypes",
        "s:structs",
        "t:typedefs",
        "u:unions",
        "v:variables",
      },
    }
  end,
}
