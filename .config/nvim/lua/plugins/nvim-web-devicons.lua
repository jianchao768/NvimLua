return {
    ----------------------------------------
    -- 提供Nerd Fonts图标供Neovim插件使用 --
    ----------------------------------------
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
        color_icons = true, --启用彩色图标
        strict = true,  -- 仅当文件类型明确时才显示图表
        default = true, -- 默认启用所有图标
    }

}
