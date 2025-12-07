-- ~/.config/nvim/lua/lsp/lsp_progress.lua
-- Improved LSP progress component for lualine
-- Features:
--  - caches progress by client_id -> token
--  - aggregates multiple clients/tasks
--  - throttles UI updates (tick interval)
--  - spinner + percent, shows "done" briefly then clears
--  - simple fallback: show "LSP busy" if no progress but active clients exist

local M = {}

-- config
local TICK_MS = 120               -- UI refresh / spinner tick
local CLEAR_DELAY_MS = 1200      -- after 'end', keep final state for this long
local MAX_DISPLAY_CLIENTS = 3    -- max client entries to show (others are summarized)
--local SPINNER_FRAMES = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local SPINNER_FRAMES = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" }

-- internal state
local progress_map = {}  -- progress_map[client_id] = { [token] = {title, message, percentage, kind, last_update} }
local spinner_idx = 1
local timer = vim.loop.new_timer()
local dirty = false
local last_nonempty = 0 -- timestamp ms when last progress existed
local last_render = ""  -- cached string to avoid unnecessary redraws

-- helpers
local function now_ms() return vim.loop.now() end

local function ensure_client_table(client_id)
  if not progress_map[client_id] then progress_map[client_id] = {} end
  return progress_map[client_id]
end

local function aggregate_message()
  -- produce an aggregated string from progress_map
  local parts = {}
  local count = 0
  for client_id, client_table in pairs(progress_map) do
    for token, info in pairs(client_table) do
      if info and (info.kind ~= "end") then
        -- prefer title + percent
        local title = info.title or ""
        local pct = (info.percentage and tostring(info.percentage) .. "%" ) or ""
        table.insert(parts, string.format("%s: %s %s", info.client_name or ("c" .. client_id), title, pct))
        count = count + 1
      end
    end
  end

  -- if empty, maybe show last done briefly
  if #parts == 0 then
    return ""
  end

  -- if too many entries, show first N and summary
  if #parts > MAX_DISPLAY_CLIENTS then
    local shown = {}
    for i=1,MAX_DISPLAY_CLIENTS do table.insert(shown, parts[i]) end
    table.insert(shown, ("+%d more"):format(#parts - MAX_DISPLAY_CLIENTS))
    return table.concat(shown, " | ")
  end

  return table.concat(parts, " | ")
end

-- update rendering periodically (spinner tick)
local function tick()
  spinner_idx = (spinner_idx % #SPINNER_FRAMES) + 1
  if dirty then
    dirty = false
    vim.schedule(function()
      vim.cmd("redrawstatus")
    end)
  end
end

-- start/stop timer helpers
local function start_timer()
  if not timer or timer:is_closing() then
    timer = vim.loop.new_timer()
  end
  if not timer:is_active() then
    timer:start(0, TICK_MS, vim.schedule_wrap(tick))
  end
end

local function stop_timer()
  if timer and timer:is_active() then
    timer:stop()
  end
end

-- lifecycle: handle begin/report/end from LSP
local function handle_progress(err, result, ctx)
  if not result or not result.value then return end
  local val = result.value
  local client_id = ctx and ctx.client_id or nil
  -- token 有时在 result.token、有时在 value.token，优先取 result.token，再取 value.token，最后用时间戳做 fallback
  local token = result.token or val.token or tostring(now_ms())

  local client = client_id and vim.lsp.get_client_by_id(client_id) or nil
  local client_name = client and client.name or ("id"..tostring(client_id or "unknown"))
  local ct = ensure_client_table(client_id or "unknown")

  if val.kind == "begin" or val.kind == "report" then
    ct[token] = {
      title = val.title,
      message = val.message,
      percentage = val.percentage,
      kind = val.kind,
      client_name = client_name,
      last_update = now_ms(),
    }
    last_nonempty = now_ms()
    dirty = true
    start_timer()
  elseif val.kind == "end" then
    ct[token] = ct[token] or {}
    ct[token].kind = "end"
    ct[token].percentage = 100
    ct[token].last_update = now_ms()
    last_nonempty = now_ms()
    dirty = true
    vim.defer_fn(function()
      if ct[token] and ct[token].kind == "end" then
        ct[token] = nil
        local empty = true
        for _ in pairs(ct) do empty = false; break end
        if empty then progress_map[client_id] = nil end
        dirty = true
        local any = false
        for _ in pairs(progress_map) do any = true; break end
        if not any then
          vim.defer_fn(function() stop_timer() end, TICK_MS*2)
        end
      end
    end, CLEAR_DELAY_MS)
  end
end


-- attach handler for $/progress: use vim.lsp.handlers so we get ctx
-- On some Neovim versions we must set handlers["$/progress"] = function(...) ... end
vim.lsp.handlers["$/progress"] = function(err, result, ctx)
  handle_progress(err, result, ctx)
end

-- small fallback: if no progress messages but there are active clients, show a simple busy indicator
local function any_active_clients()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  return (#clients > 0), clients
end

-- lualine component getter
function M.get_component()
  -- aggregated active progress
  local agg = aggregate_message()

  if agg ~= "" then
    local spinner = SPINNER_FRAMES[spinner_idx]
    last_render = string.format(" %s %s ", spinner, agg)
    return last_render
  end

  -- fallback: if no progress but active clients recently, show short busy indicator
  local active, clients = any_active_clients()
  if active and (now_ms() - last_nonempty) < 4000 then
    local spinner = SPINNER_FRAMES[spinner_idx]
    last_render = string.format(" %s LSP...", spinner)
    return last_render
  end

  -- nothing to render
  last_render = ""
  return ""
end

-- return the function for lualine
return M.get_component

