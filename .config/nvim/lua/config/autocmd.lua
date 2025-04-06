-- 自动恢复上次编辑的位置
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)

    -- 只在合理的范围内恢复位置，避免无效位置的错误
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- 进入新文件时，自动切换当前目录为文件所在目录（lcd %:p:h）
-- 这个改了之后， 文件跳转时，Nvim-tree 会自动调整为当前目录
-- 不过为了FZF，这个先关了
--vim.api.nvim_create_autocmd("BufEnter", {
--    pattern = "*", command = "silent! lcd %:p:h",
--
--})

-- 右侧参考线
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "lua", "python" },
  callback = function()
    vim.wo.colorcolumn = "100"
  end,
})

-- 当 nvim-tree 是最后一个窗口时自动关闭
--vim.api.nvim_create_autocmd("BufEnter", {
--  nested = true,
--  callback = function()
--    local wins = #vim.api.nvim_list_wins()
--    local ft = vim.bo.filetype
--    if wins == 1 and (ft == "NvimTree" or ft == "aerial") then
--      vim.cmd("q")
--    end
--  end,
--})

-- 如果当前窗口只有aerial 和 nvimtree，则都关了
vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        local wins = vim.api.nvim_list_wins()
        local filetypes = {}

        -- 获取所有窗口的文件类型
        for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            local ft = vim.bo[buf].filetype
            filetypes[ft] = true
        end

        -- 处理 vi . 打开后只有 NvimTree 的情况
        if vim.tbl_count(filetypes) == 1 and (filetypes["NvimTree"] or filetypes["aerial"]) then
                vim.cmd("qall!") -- 直接退出 Neovim
            return
        end

        -- 如果窗口内 **只剩下** aerial 和 NvimTree，则退出 Neovim
        if filetypes["NvimTree"] and filetypes["aerial"] and vim.tbl_count(filetypes) == 2 then
            vim.cmd("qall!") -- 退出所有窗口
        end
    end,
})

-- 拷贝高亮显示
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 200,
		})
	end,
})


