return {
    ----------------------------
    --- 高亮光标下的相同单词 ---
    ----------------------------
    "RRethy/vim-illuminate",
    config = function()
        require("illuminate").configure({
            providers = { "lsp", "treesitter", "regex" }, -- 使用 LSP、Treesitter 和正则匹配高亮
            delay = 200, -- 延迟（毫秒）
            filetypes_denylist = { "NvimTree", "TelescopePrompt" }, -- 禁止高亮的文件类型
            large_file_cutoff = 2000, -- 超过 2000 行的文件不启用
            large_file_overrides = { providers = { "lsp" } }, -- 大文件仅使用 LSP 进行高亮
        })

        -- 设置快捷键：跳转到上/下一个高亮单词
        --vim.keymap.set("n", "<leader>n", require("illuminate").goto_next_reference, { noremap = true, silent = true })
        --vim.keymap.set("n", "<leader>N", require("illuminate").goto_prev_reference, { noremap = true, silent = true })
        --vim.cmd [[
        --highlight IlluminatedWordText guibg=#64675a gui=bold
        --highlight IlluminatedWordRead guibg=#64675a gui=bold
        --highlight IlluminatedWordWrite guibg=#64675a gui=bold
        --]]
        -- 设置为下划线高亮样式
        vim.api.nvim_set_hl(0, "IlluminatedWordText", { underline = true })
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underline = true })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { underline = true })

    end,
}

