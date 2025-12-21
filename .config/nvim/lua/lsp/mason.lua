return {
  {
    ----------------------------------------------
    --- mason.nvim 提供LSP、工具等安装卸载界面 ---
    ----------------------------------------------
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },

    opts = {
      auto_update = true,

      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    ----------------------------------------------
    --- mason-lspconfig.nvim 用于安装LSP服务器 ---
    ----------------------------------------------
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },

    opts = {
      ensure_installed = { "clangd", "lua_ls", "cmake" },
      automatic_installation = true,
    },
    -- 仅在有网时更新
    build = function()
      local is_nvim = vim.fn.has("nvim") == 1
      local has_internet = vim.fn.systemlist("ping -c 1 google.com 2>/dev/null | grep -E '1 received|1 packets received'")[1] ~= nil
      if is_nvim and has_internet then
        vim.cmd("MasonUpdate")
      end
    end,
  },
}
