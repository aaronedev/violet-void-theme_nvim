local M = {}

M.version = "1.0.0"

---@class VioletVoid.Config
---@field on_colors fun(colors: ColorScheme)
---@field on_highlights fun(highlights: VioletVoid.Highlights, colors: ColorScheme)
M.defaults = {
  style = "violet-void", -- The theme comes in many styles: violet-void, void-light (you can add more styles later)
  light_style = "void-light", -- The theme is used when the background is set to light
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  day_brightness = 1, -- Adjusts the brightness of the colors of the **Light** style. Number between 0 and 1, from dull to vibrant colors
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    booleans = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "normal", -- style for sidebars, see below
    floats = "normal", -- style for floating windows
  },
  dim_inactive = false, -- dims inactive windows
  lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights VioletVoid.Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,

  cache = true, -- When set to true, the theme will be cached for better performance

  ---@type table<string, boolean|{enabled:boolean}>
  plugins = {
    -- enable all plugins when not using lazy.nvim
    -- set to false to manually enable/disable plugins
    all = package.loaded.lazy == nil,
    -- uses your plugin manager to automatically enable needed plugins
    -- currently only lazy.nvim is supported
    auto = true,
    -- add any plugins here that you want to enable
    -- for all possible plugins, see:
    -- * violet-void/groups/
  },
}

---@type VioletVoid.Config
M.options = nil

---@param options? VioletVoid.Config
function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, options or {})

  -- Setup color harmony commands
  vim.api.nvim_create_user_command("VioletHarmony", function(opts)
    local util = require("violet-void.util")
    local harmony_type = opts.fargs[1] or "all"

    local word = vim.fn.expand("<cWORD>")
    local hex_pattern = "#?%x%x%x%x%x%x"
    local hex = word:match(hex_pattern)

    if not hex then
      hex = word:match("#?%x%x%x")
      if hex and #hex:gsub("#", "") == 3 then
        local clean = hex:gsub("#", "")
        hex = "#" .. clean:sub(1, 1):rep(2) .. clean:sub(2, 2):rep(2) .. clean:sub(3, 3):rep(2)
      end
    end

    if not hex then
      vim.notify("No hex color found under cursor", vim.log.levels.ERROR)
      return
    end

    if not hex:match("^#") then
      hex = "#" .. hex
    end

    local result
    if harmony_type == "all" then
      result = util.get_all_harmonies(hex)
      print(vim.inspect(result))
    else
      local harmony_func = util[harmony_type]
      if not harmony_func then
        vim.notify("Invalid harmony type: " .. harmony_type, vim.log.levels.ERROR)
        return
      end
      result = harmony_func(hex)
      print(vim.inspect(result))
    end
  end, {
    nargs = "?",
    complete = function()
      return { "all", "complement", "split_complementary", "triadic", "analogous", "monochromatic", "tetradic" }
    end,
  })

  vim.api.nvim_create_user_command("VioletCacheClear", function()
    require("violet-void.util").cache.clear()
    vim.notify("Violet Void cache cleared", vim.log.levels.INFO)
  end, {})
end

---@param opts? VioletVoid.Config
function M.extend(opts)
  return opts and vim.tbl_deep_extend("force", {}, M.options, opts) or M.options
end

setmetatable(M, {
  __index = function(_, k)
    if k == "options" then
      return M.defaults
    end
  end,
})

return M
