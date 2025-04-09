return {
    -------------------------------
    --- Tagbar 侧边栏显示函数名 ---
    -------------------------------
    'preservim/tagbar',
    cmd = "TagbarToggle",
    init = function()
        vim.g.tagbar_width = 25
        vim.g.tagbar_autofocus = 1
        vim.g.tagbar_sort = 0
        vim.g.tagbar_autoshowtag = 1
        vim.g.tagbar_left = 1
        vim.g.tagbar_autoshow_highlight = 1  -- 启用自动高亮

        --防止解析lambda表达式
        vim.g.tagbar_ctags_args = '--exclude=auto --exclude=*lambda* --c++-kinds=+pf --fields=+iaS --extras=+q'
        vim.g.tagbar_type_cpp = {
            ctagsbin = "ctags",
            ctagstype = "c++",
            kinds = {
                "c:classes",
                "d:macros",
                "e:enumerators",
                "f:functions",
                "g:enumerations",
                "m:members",
                "n:namespaces",
                "p:prototypes",
                "s:structs",
                "t:typedefs",
                "u:unions",
                "v:variables",
            },
        }

        vim.keymap.set('n', '<F8>', ':TagbarToggle<CR>')
        vim.keymap.set('n', '<leader>t', ':TagbarToggle<CR>', { silent = true, desc = "Toggle Tagbar" })

        vim.o.updatetime = 100 --把这个去掉就不会自动高亮了。。
        --vim.api.nvim_create_autocmd('CursorHold', {
        --    pattern = '*',
        --    callback = function()
        --        if vim.fn.exists(':TagbarShowTag') == 2 then  -- 检查 Tagbar 是否可用
        --            vim.cmd('TagbarForceUpdate')  -- 自动高亮当前符号
        --        end
        --    end
        --})
    end
}
