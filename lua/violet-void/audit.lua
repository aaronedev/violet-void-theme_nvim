local Util = require("violet-void.util")

local M = {}

local function load_expected()
  return require("violet-void.expected_groups")
end

local function format_block(label, items)
  if #items == 0 then
    return nil
  end
  return string.format("%s (%d):\n  - %s", label, #items, table.concat(items, "\n  - "))
end

---@param opts? VioletVoid.Config
---@return boolean ok, {highlights: VioletVoid.Highlights, expected: string[], missing: string[], unexpected: string[]} state
function M.audit(opts)
  local highlights = select(1, Util.collect_highlights(opts))
  local expected = load_expected()

  local missing, unexpected = Util.diff_highlight_sets(expected, highlights)

  return #missing == 0 and #unexpected == 0,
    {
      highlights = highlights,
      expected = expected,
      missing = missing,
      unexpected = unexpected,
    }
end

---@param state {missing: string[], unexpected: string[]}
---@return string
function M.render(state)
  local blocks = {}
  local missing_block = format_block("Missing highlight groups", state.missing)
  if missing_block then
    table.insert(blocks, missing_block)
  end

  local unexpected_block = format_block("Unexpected highlight groups", state.unexpected)
  if unexpected_block then
    table.insert(blocks, unexpected_block)
  end

  return table.concat(blocks, "\n\n")
end

---@param opts? VioletVoid.Config
---@return integer exit_code, string? message
function M.run_cli(opts)
  local ok, state = M.audit(opts)
  if ok then
    return 0
  end

  local message = M.render(state)
  vim.api.nvim_err_writeln(message)
  return 1, message
end

---@param opts? VioletVoid.Config
function M.notify(opts)
  local exit_code, message = M.run_cli(opts)
  if exit_code == 0 then
    vim.notify("Violet Void audit passed", vim.log.levels.INFO)
  else
    vim.notify(message or "Violet Void audit reported issues", vim.log.levels.WARN)
  end
end

return M
