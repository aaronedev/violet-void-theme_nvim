-- Minimal test runner for violet-void theme
-- Run with: nvim --headless -u NONE -c "set rtp+=." -c "luafile tests/minimal.lua" -c "qa!"

local function test(name, fn)
  local ok, err = pcall(fn)
  if ok then
    print("✓ " .. name)
    return true
  else
    print("✗ " .. name .. ": " .. tostring(err))
    return false
  end
end

local function describe(name, fn)
  print("\n" .. name)
  fn()
end

local results = { passed = 0, failed = 0 }

-- Mock plenary describe
_G.describe = function(name, fn)
  print("\n" .. name)
  fn()
end

_G.it = function(name, fn)
  local ok = test(name, fn)
  if ok then
    results.passed = results.passed + 1
  else
    results.failed = results.failed + 1
  end
end

-- Add rtp
vim.opt.rtp:prepend(".")

describe("violet-void theme tests", function()
  it("loads violet-void (dark) without errors", function()
    local ok = vim.cmd("colorscheme violet-void")
    -- If no error, ok is nil or empty
    assert(vim.g.colors_name == "violet-void", "Theme should be violet-void")
  end)

  it("loads void-light without errors", function()
    vim.cmd("colorscheme void-light")
    assert(vim.g.colors_name == "void-light", "Theme should be void-light")
  end)

  it("has valid colors module", function()
    local colors = require("violet-void.colors.violet-void")
    assert(colors.bg ~= nil)
    assert(colors.fg ~= nil)
  end)

  it("generates highlights", function()
    local config = require("violet-void.config")
    config.setup({})

    local colors = require("violet-void.colors").setup(config.options)
    local groups = require("violet-void.groups")

    local highlights = groups.setup(colors, config.options)

    assert(highlights.Normal ~= nil)
    assert(highlights.Comment ~= nil)
  end)

  it("config has expected defaults", function()
    local config = require("violet-void.config")
    config.setup({})

    local opts = config.options

    assert(opts.styles ~= nil)
    assert(opts.plugins ~= nil)
  end)
end)

print(string.format("\n\nResults: %d passed, %d failed", results.passed, results.failed))
vim.cmd(results.failed > 0 and "cq 1" or "qa!")