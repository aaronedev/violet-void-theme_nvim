#!/usr/bin/env lua
-- Visual regression test script for violet-void theme
-- Usage: lua test/visual_regression.lua [options]
-- Options:
--   --output DIR    Output directory for test results (default: test/visual)
--   --theme THEME   Theme to test: violet-void, void-light, violet-void-high-contrast (default: violet-void)
--   --verbose       Print detailed progress

local M = {}

-- Configuration
local config = {
  output_dir = "test/visual",
  theme = "violet-void",
  verbose = false,
}

-- Parse arguments
local function parse_args(args)
  local i = 1
  while i <= #args do
    local arg = args[i]
    if arg == "--output" then
      config.output_dir = args[i + 1]
      i = i + 2
    elseif arg == "--theme" then
      config.theme = args[i + 1]
      i = i + 2
    elseif arg == "--verbose" then
      config.verbose = true
      i = i + 1
    else
      i = i + 1
    end
  end
end

-- Language/syntax test cases
local test_cases = {
  {
    name = "lua",
    file = "test/syntax/test.lua",
    filetype = "lua",
  },
  {
    name = "python",
    file = "test/syntax/test.py",
    filetype = "python",
  },
  {
    name = "javascript",
    file = "test/syntax/test.js",
    filetype = "javascript",
  },
  {
    name = "markdown",
    file = "test/syntax/test.md",
    filetype = "markdown",
  },
}

-- Capture highlights for a specific buffer
local function capture_highlights()
  local highlights = {}
  
  -- Get all active highlight groups
  local ok, all_hls = pcall(vim.fn.getwinvar, 0, "")
  if not ok then
    return highlights
  end
  
  -- Get highlight definitions
  for hl_name, hl_info in pairs(vim.fn.getjumplist()[1] or {}) do
    -- placeholder for actual capture
  end
  
  return highlights
end

-- Generate a highlight report
local function generate_report(theme_name)
  local report = {
    theme = theme_name,
    timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
    total_highlights = 0,
    highlights = {},
  }
  
  -- Load theme colors
  local ok, colors = pcall(require, "violet-void.colors." .. theme_name)
  if not ok then
    -- Try main colors module
    ok, colors = pcall(function()
      return require("violet-void.colors").setup({ style = theme_name })
    end)
  end
  
  if ok and colors then
    report.colors = colors
  end
  
  -- Get all highlight groups
  local hl_groups = vim.fn.getcompletion("", "highlight")
  report.total_highlights = #hl_groups
  
  -- Sample some common groups
  local important_groups = {
    "Normal", "Comment", "String", "Number", "Keyword", "Function",
    "Variable", "Type", "Operator", "Punctuation", "Title", "Header",
    "Treesitter", "LSP", "Diagnostic", "Git", "Cursor", "MatchParen",
  }
  
  for _, group in ipairs(important_groups) do
    local hl = vim.api.nvim_get_hl_by_name(group, true)
    if hl then
      report.highlights[group] = {
        fg = string.format("#%06x", hl.foreground or 0),
        bg = string.format("#%06x", hl.background or 0),
        bold = hl.bold or false,
        italic = hl.italic or false,
        underline = hl.underline or false,
      }
    end
  end
  
  return report
end

-- Check contrast ratios
local function check_contrast(fg, bg)
  if not fg or not bg or fg == "NONE" or bg == "NONE" then
    return nil
  end
  
  local function hex_to_rgb(hex)
    hex = hex:gsub("#", "")
    return {
      r = tonumber(hex:sub(1, 2), 16),
      g = tonumber(hex:sub(3, 4), 16),
      b = tonumber(hex:sub(5, 6), 16),
    }
  end
  
  local function luminance(rgb)
    local function to_linear(c)
      return c <= 0.03928 and c / 12.92 or ((c + 0.055) / 1.055) ^ 2.4
    end
    return 0.2126 * to_linear(rgb.r / 255) + 
           0.7152 * to_linear(rgb.g / 255) + 
           0.0722 * to_linear(rgb.b / 255)
  end
  
  local fg_rgb = hex_to_rgb(fg)
  local bg_rgb = hex_to_rgb(bg)
  
  local l1 = luminance(fg_rgb)
  local l2 = luminance(bg_rgb)
  
  local ratio = (math.max(l1, l2) + 0.05) / (math.min(l1, l2) + 0.05)
  
  return {
    ratio = ratio,
    wcag_aa = ratio >= 4.5,
    wcag_aaa = ratio >= 7.0,
  }
end

-- Run contrast checks on common highlight combinations
local function run_contrast_checks()
  local results = {
    passed = {},
    failed = {},
    warnings = {},
  }
  
  local test_pairs = {
    { fg = "fg", bg = "bg", name = "Normal (fg/bg)" },
    { fg = "fg", bg = "bg_sidebar", name = "Sidebar" },
    { fg = "comments", bg = "bg", name = "Comments" },
    { fg = "strings", bg = "bg", name = "Strings" },
    { fg = "functions", bg = "bg", name = "Functions" },
    { fg = "keywords", bg = "bg", name = "Keywords" },
    { fg = "variables", bg = "bg", name = "Variables" },
    { fg = "numbers", bg = "bg", name = "Numbers" },
  }
  
  -- Load colors
  local ok, colors = pcall(require, "violet-void.colors." .. config.theme)
  if not ok then
    return results
  end
  
  for _, pair in ipairs(test_pairs) do
    local fg = colors[pair.fg]
    local bg = colors[pair.bg]
    
    if fg and bg then
      local check = check_contrast(fg, bg)
      if check then
        local result = {
          name = pair.name,
          ratio = string.format("%.2f:1", check.ratio),
          fg = fg,
          bg = bg,
        }
        
        if check.wcag_aaa then
          table.insert(results.passed, result)
        elseif check.wcag_aa then
          table.insert(results.warnings, result)
        else
          table.insert(results.failed, result)
        end
      end
    end
  end
  
  return results
end

-- Main test runner
function M.run(args)
  parse_args(args or {})
  
  print("Violet Void Visual Regression Test")
  print("===================================")
  print("Theme: " .. config.theme)
  print("")
  
  -- Generate highlight report
  print("Generating highlight report...")
  local report = generate_report(config.theme)
  print("Total highlights: " .. report.total_highlights)
  
  -- Run contrast checks
  print("")
  print("Running contrast checks...")
  local contrast = run_contrast_checks()
  
  print("  WCAG AAA (7.0:1): " .. #contrast.passed)
  print("  WCAG AA (4.5:1):  " .. #contrast.warnings)
  print("  Below AA:         " .. #contrast.failed)
  
  if #contrast.failed > 0 then
    print("")
    print("FAILED (below WCAG AA):")
    for _, r in ipairs(contrast.failed) do
      print("  - " .. r.name .. ": " .. r.ratio)
    end
  end
  
  if #contrast.warnings > 0 then
    print("")
    print("WARNINGS (WCAG AA only):")
    for _, r in ipairs(contrast.warnings) do
      print("  - " .. r.name .. ": " .. r.ratio)
    end
  end
  
  if #contrast.passed > 0 and config.verbose then
    print("")
    print("PASSED (WCAG AAA):")
    for _, r in ipairs(contrast.passed) do
      print("  - " .. r.name .. ": " .. r.ratio)
    end
  end
  
  print("")
  print("Done!")
  
  return {
    report = report,
    contrast = contrast,
    success = #contrast.failed == 0,
  }
end

-- Run if executed directly
if vim and vim.fn instead of... then
  -- We're in Neovim
  M.run({})
elseif arg then
  -- Running from command line
  M.run(arg)
end

return M