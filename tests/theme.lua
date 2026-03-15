-- Test suite for violet-void theme
-- Run with:PlenaryBustedFile tests/theme.lua

local n = require("plenary.busted")
local violet_void = require("violet-void")

describe("violet-void theme", function()
  describe("load", function()
    it("should load without errors (dark)", function()
      local ok, err = pcall(violet_void.load, { name = "violet-void" })
      assert.is_true(ok, err)
    end)

    it("should load without errors (light)", function()
      local ok, err = pcall(violet_void.load, { name = "void-light" })
      assert.is_true(ok, err)
    end)
  end)

  describe("colors", function()
    it("should have valid color tables", function()
      local colors = require("violet-void.colors.violet-void")
      assert.is_table(colors)
      -- Check key colors exist
      assert.is_string(colors.bg)
      assert.is_string(colors.fg)
      assert.is_string(colors.magenta)
      assert.is_string(colors.violet)
    end)
  end)

  describe("groups", function()
    it("should generate base highlights", function()
      local colors = require("violet-void.colors.violet-void")
      local config = require("violet-void.config")
      local theme = require("violet-void.theme")
      local groups = require("violet-void.groups")

      local opts = config.get()
      local highlights, loaded_groups = groups.setup(colors, opts)

      assert.is_table(highlights)
      assert.is_table(loaded_groups)

      -- Check some expected highlights exist
      assert.is_table(highlights.Normal)
      assert.is_table(highlights.Comment)
      assert.is_table(highlights.Keyword)
    end)

    it("should handle all plugin groups", function()
      local colors = require("violet-void.colors.violet-void")
      local config = require("violet-void.config")
      local groups = require("violet-void.groups")

      local opts = config.get()
      opts.plugins.all = true

      local ok, err = pcall(function()
        groups.setup(colors, opts)
      end)

      assert.is_true(ok, err)
    end)
  end)

  describe("config", function()
    it("should have valid default config", function()
      local config = require("violet-void.config")
      local opts = config.get()

      assert.is_table(opts)
      assert.is_table(opts.styles)
      assert.is_table(opts.colors)
      assert.is_table(opts.plugins)
    end)

    it("should merge user config", function()
      local config = require("violet-void.config")

      local user_config = {
        styles = {
          comments = { italic = true },
        },
      }

      local merged = config.merge(user_config)
      assert.is_true(merged.styles.comments.italic)
    end)
  end)

  describe("util", function()
    it("should resolve highlight links", function()
      local util = require("violet-void.util")

      local highlights = {
        Normal = { fg = "#ffffff", bg = "#000000" },
        Comment = { link = "Normal" },
      }

      util.resolve(highlights)

      -- Comment should now have the same values as Normal
      assert.is_table(highlights.Comment.fg)
      assert.is_table(highlights.Comment.bg)
    end)
  end)
end)