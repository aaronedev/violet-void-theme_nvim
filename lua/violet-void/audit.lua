local Util = require("violet-void.util")

local M = {}

-- ========== CONTRAST CHECKING UTILITIES ==========

---Convert hex color to RGB
---@param hex string hex color like "#ff0000"
---@return number r, number g, number b
local function hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  if #hex == 3 then
    hex = hex:sub(1, 1):rep(2) .. hex:sub(2, 2):rep(2) .. hex:sub(3, 3):rep(2)
  end
  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

---Convert sRGB to linear RGB
---@param value number sRGB component (0-255)
---@return number linear value
local function srgb_to_linear(value)
  local srgb = value / 255
  if srgb <= 0.04045 then
    return srgb / 12.92
  end
  return ((srgb + 0.055) / 1.055) ^ 2.4
end

---Calculate relative luminance (WCAG definition)
---@param hex string hex color
---@return number luminance (0-1)
function M.get_relative_luminance(hex)
  local r, g, b = hex_to_rgb(hex)
  local lr, lg, lb = srgb_to_linear(r), srgb_to_linear(g), srgb_to_linear(b)
  return 0.2126 * lr + 0.7152 * lg + 0.0722 * lb
end

---Calculate WCAG contrast ratio between two colors
---@param fg string foreground hex color
---@param bg string background hex color
---@return number ratio contrast ratio (1-21)
function M.get_contrast_ratio(fg, bg)
  local l1 = M.get_relative_luminance(fg)
  local l2 = M.get_relative_luminance(bg)
  local lighter = math.max(l1, l2)
  local darker = math.min(l1, l2)
  return (lighter + 0.05) / (darker + 0.05)
end

---Check if contrast meets WCAG AA standard (4.5:1 for normal text, 3:1 for large text)
---@param fg string foreground hex color
---@param bg string background hex color
---@param large_text? boolean true for large text threshold (3:1)
---@return boolean passes, number ratio
function M.meets_AA(fg, bg, large_text)
  local ratio = M.get_contrast_ratio(fg, bg)
  local threshold = large_text and 3.0 or 4.5
  return ratio >= threshold, ratio
end

---Check if contrast meets WCAG AAA standard (7:1 for normal text, 4.5:1 for large text)
---@param fg string foreground hex color
---@param bg string background hex color
---@param large_text? boolean true for large text threshold (4.5:1)
---@return boolean passes, number ratio
function M.meets_AAA(fg, bg, large_text)
  local ratio = M.get_contrast_ratio(fg, bg)
  local threshold = large_text and 4.5 or 7.0
  return ratio >= threshold, ratio
end

---Audit contrast ratios for key theme colors
---@param opts? VioletVoid.Config
---@return table results with pass/fail info
function M.audit_contrast(opts)
  local _, colors = Util.collect_highlights(opts)

  local results = {}

  -- Key color pairs to check (use existing keys from colors table)
  local pairs = {
    { fg = colors.fg, bg = colors.bg, name = "Normal text on background" },
    { fg = colors.comment, bg = colors.bg, name = "Comments on background" },
    { fg = colors.fg_float, bg = colors.bg_float, name = "Float text on float bg" },
    { fg = colors.fg_sidebar, bg = colors.bg_sidebar, name = "Sidebar text on sidebar bg" },
    { fg = colors.fg_dark, bg = colors.bg_dark, name = "Dark fg on dark bg" },
    { fg = colors.fg, bg = colors.bg_visual, name = "Normal text on visual bg" },
  }

  for _, pair in ipairs(pairs) do
    local ratio = M.get_contrast_ratio(pair.fg, pair.bg)
    local aa_normal, _ = M.meets_AA(pair.fg, pair.bg, false)
    local aa_large, _ = M.meets_AA(pair.fg, pair.bg, true)
    local aaa_normal, _ = M.meets_AAA(pair.fg, pair.bg, false)

    table.insert(results, {
      name = pair.name,
      fg = pair.fg,
      bg = pair.bg,
      ratio = ratio,
      aa_normal = aa_normal,
      aa_large = aa_large,
      aaa_normal = aaa_normal,
    })
  end

  return results
end

---Render contrast audit results
---@param results table results from audit_contrast()
---@return string
function M.render_contrast(results)
  local lines = { "Contrast Audit Results:", "" }

  for _, r in ipairs(results) do
    local status = r.aa_normal and "✅" or (r.aa_large and "⚠️" or "❌")
    table.insert(lines, string.format(
      "%s %s (%.2f:1) - AA:%s AAA:%s",
      status, r.name, r.ratio,
      r.aa_normal and "✓" or "✗",
      r.aaa_normal and "✓" or "✗"
    ))
  end

  return table.concat(lines, "\n")
end

-- ========== EXISTING AUDIT FUNCTIONS ==========

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
