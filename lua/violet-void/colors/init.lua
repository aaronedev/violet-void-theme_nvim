local Util = require("violet-void.util")

local M = {}

---@type table<string, Palette|fun(opts:VioletVoid.Config):Palette>
M.styles = setmetatable({}, {
  __index = function(_, style)
    return vim.deepcopy(require("violet-void.colors." .. style))
  end,
})

---@param opts? VioletVoid.Config
function M.setup(opts)
  opts = require("violet-void.config").extend(opts)

  Util.day_brightness = opts.day_brightness or 0.3

  local palette = M.styles[opts.style or "violet-void"]
  if type(palette) == "function" then
    palette = palette(opts) --[[@as Palette]]
  end

  -- Color Palette
  ---@class ColorScheme: Palette
  local colors = palette

  Util.bg = colors.bg
  Util.fg = colors.fg

  colors.none = "NONE"

  colors.diff = {
    add = Util.blend_bg(colors.green1, 0.15),
    delete = Util.blend_bg(colors.red1, 0.15),
    change = Util.blend_bg(colors.blue5, 0.15),
    text = colors.blue5,
  }

  colors.git.ignore = colors.dark3
  colors.black = Util.blend_bg(colors.bg, 0.8, "#121212")
  colors.border_highlight = Util.blend_bg(colors.teal, 0.22)
  colors.border = Util.blend_bg(colors.fg_gutter, 0.7)

  -- Popups and statusline always get a dark background
  colors.bg_popup = colors.bg_dark1
  colors.bg_statusline = colors.bg_dark

  -- Sidebar and Floats are configurable
  colors.bg_sidebar = opts.styles.sidebars == "transparent" and colors.none
    or opts.styles.sidebars == "dark" and colors.bg_dark
    or colors.bg_highlight

  colors.bg_float = opts.styles.floats == "transparent" and colors.none
    or opts.styles.floats == "dark" and colors.bg_dark
    or colors.bg_popup

  colors.bg_visual = Util.blend_bg(colors.yellow, 0.55)
  colors.bg_search = Util.blend_bg(colors.blue7, 0.14)
  colors.fg_sidebar = colors.fg_dark
  colors.fg_float = colors.fg

  colors.error = colors.red1
  colors.todo = colors.blue
  colors.warning = Util.blend_fg(colors.orange, 0.7)
  colors.info = colors.blue2
  colors.hint = colors.teal

  colors.rainbow = {
    colors.blue,
    colors.yellow,
    colors.green,
    colors.teal,
    colors.magenta,
    colors.purple,
    colors.orange,
    colors.red,
  }

  -- stylua: ignore
  --- @class TerminalColors
  colors.terminal = {
    black          = colors.black,
    black_bright   = colors.terminal_black,
    red            = colors.red,
    red_bright     = Util.brighten(colors.red),
    green          = colors.green,
    green_bright   = Util.brighten(colors.green),
    yellow         = colors.yellow,
    yellow_bright  = Util.brighten(colors.yellow),
    blue           = colors.blue,
    blue_bright    = Util.brighten(colors.blue),
    magenta        = colors.magenta,
    magenta_bright = Util.brighten(colors.magenta),
    cyan           = colors.cyan,
    cyan_bright    = Util.brighten(colors.cyan),
    white          = colors.fg_dark,
    white_bright   = colors.fg,
  }

  opts.on_colors(colors)

  return colors, opts
end

return M
