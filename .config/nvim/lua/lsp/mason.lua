-- lua/lsp/mason.lua

local M = {}

-- Mason 主配置
function M.opts()
  return {
    auto_update = true,

    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  }
end

-- Mason-lspconfig 配置
function M.lspconfig_opts()
  return {
    ensure_installed = { "clangd", "lua_ls", "cmake" },
    automatic_installation = true,
  }
end

-- MasonUpdate，只在有网络时执行
function M.maybe_update()
  local has_internet =
    vim.fn.systemlist(
      "ping -c 1 google.com 2>/dev/null | grep -E '1 received|1 packets received'"
    )[1] ~= nil

  if has_internet then
    vim.cmd("MasonUpdate")
  end
end

return M
