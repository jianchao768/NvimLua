local M = {}

-- function for diffMode (vi -d)
M.is_diff_mode = function()
  if vim.opt.diff:get() then
    return true
  else
    return false
  end
end

M.toggle_diagnostics = function()
  if not vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(true)
    vim.notify("Diagnostic Enabled!", vim.log.levels.INFO)
  else
    vim.diagnostic.enable(false)
    vim.notify("Diagnostic Disabled!", vim.log.levels.WARN)
  end
end

-- close buffer or window layout
M.close_buffer = function()
  local win_count = vim.fn.winnr('$')
  if win_count > 1 then
    vim.cmd("close")
  else
    vim.cmd("bd")
  end
end


M.update_foldcolumn = function()
  if not vim.wo.foldenable then
    vim.wo.foldcolumn = "0"
    return
  end

  local has_fold = false
  local line_count = vim.api.nvim_buf_line_count(0)
  for lnum = 1, line_count do
    if vim.fn.foldlevel(lnum) > 0 then
      has_fold = true
      break
    end
  end

  vim.wo.foldcolumn = has_fold and "1" or "0"
end

M.fzf_projects = function()
  local fzf = require("fzf-lua")
  local project_file = vim.fn.stdpath("data") .. "/project_nvim/project_history"

  local f = io.open(project_file, "r")
  if not f then
    vim.notify("No project history found", vim.log.levels.WARN)
    return
  end

  local projects = {}
  for line in f:lines() do
    if line ~= "" then
      table.insert(projects, line)
    end
  end
  f:close()

  if #projects == 0 then
    vim.notify("No recent projects", vim.log.levels.INFO)
    return
  end

  fzf.fzf_exec(projects, {
    prompt = "Projects> ",
    winopts = {
      title = " Project List ",
      title_pos = "center",
      height = 0.6,
      width = 0.6,
      preview = {
        type = "builtin",
        title = "Preview",
        title_pos = "center",
        scrollbar = false,
      },
    },
    actions = {
      -- Enter：切换到项目目录并打开
      ["default"] = function(selected)
        local dir = selected[1]
        if dir and vim.fn.isdirectory(dir) == 1 then
          vim.cmd("cd " .. dir)
          vim.cmd("edit .")
          vim.notify("Switched to project: " .. dir)
        else
          vim.notify("Invalid project path: " .. dir, vim.log.levels.ERROR)
        end
      end,
      -- Ctrl-F：直接在项目内搜索文件
      ["ctrl-f"] = function(selected)
        local dir = selected[1]
        if dir and vim.fn.isdirectory(dir) == 1 then
          require("fzf-lua").files({ cwd = dir })
        end
      end,
    },
  })

end


return M
