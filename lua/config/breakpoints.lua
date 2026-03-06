local M = {}
-- Go to a breakpoint in the current file (either the next or previous)
---@param dir "next"|"prev"
---@package
function M.gotoBreakpoint(dir)
  ---@type dap.bp[]
  local breakpoints = require("dap.breakpoints").get()
  if #breakpoints == 0 then
    vim.notify("No breakpoints set", vim.log.levels.WARN)
    return
  end

  local current = {
    bufnr = vim.api.nvim_get_current_buf(),
    line = vim.api.nvim_win_get_cursor(0)[1],
  }

  if breakpoints[current.bufnr] == nil then
    vim.notify("No breakpoints in current file", vim.log.levels.WARN)
    return
  end

  ---@param a dap.bp
  ---@param b dap.bp
  table.sort(breakpoints[current.bufnr], function(a, b)
    if dir == "next" then
      return a.line < b.line
    else
      return a.line > b.line
    end
  end)
  for _, breakpoint in ipairs(breakpoints[current.bufnr]) do
    local reachedCurrentLine
    if dir == "next" then
      reachedCurrentLine = breakpoint.line > current.line
    else
      reachedCurrentLine = breakpoint.line < current.line
    end
    if reachedCurrentLine then
      vim.cmd(("%s"):format(breakpoint.line))
      return
    end
  end
  vim.cmd(("%s"):format(breakpoints[current.bufnr][1].line))
end

-- Got to next breakpoint in current file
function M.next()
  M.gotoBreakpoint("next")
end

-- Got to previous breakpoint in current file
function M.prev()
  M.gotoBreakpoint("prev")
end

return M
