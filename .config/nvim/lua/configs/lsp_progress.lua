local M = {}

-- 保存进度信息
local progress = {
  message = "",
  percent = 0,
  done = true,
}

-- 动画帧
--local spinner_frames = { "⠋", "⠙", "⠿", "⠟", "⠯", "⠷" }
--local spinner_frames = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" }
--local spinner_frames = { "▖", "▘", "▝", "▗" }
--local spinner_frames = { "▌", "▀", "▐", "▄" }
local spinner_frames = { "▀", "▄" }
local spinner_index = 1

-- LSP progress handler（Neovim 0.11 标准写法）
vim.lsp.handlers["$/progress"] = function(_, msg, info)
  local val = msg.value
  if not val.kind then
    return
  end

  if val.kind == "begin" then
    progress.done = false
    progress.message = val.title or "Working..."
    progress.percent = val.percentage or 0

  elseif val.kind == "report" then
    progress.done = false
    progress.message = val.title or progress.message
    progress.percent = val.percentage or progress.percent

  elseif val.kind == "end" then
    progress.done = true
    progress.percent = 100
    progress.message = val.title or progress.message

    -- 2 秒后清空
    vim.defer_fn(function()
      progress.done = true
      progress.message = ""
      progress.percent = 0
    end, 2000)
  end
end

-- Lualine 组件
function M.get()
  if progress.message == "" then
    return ""
  end

  if progress.done then
    return string.format("✔ %s", progress.message)
  end

  spinner_index = spinner_index % #spinner_frames + 1
  local spinner = spinner_frames[spinner_index]

  return string.format("%s %s (%d%%%%)", spinner, progress.message, progress.percent)
end

return M

