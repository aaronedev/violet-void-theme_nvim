local M = {}

M.bg = "#0f0f0f"
M.fg = "#e7e7e7"
M.day_brightness = 0.3

local uv = vim.uv or vim.loop

---@param c  string
local function rgb(c)
  c = string.lower(c)
  return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

---@param foreground string foreground color
---@param background string background color
---@param alpha number|string number between 0 and 1. 0 results in bg, 1 results in fg
function M.blend(foreground, alpha, background)
  alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
  local bg = rgb(background)
  local fg = rgb(foreground)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

function M.blend_bg(hex, amount, bg)
  return M.blend(hex, amount, bg or M.bg)
end
M.darken = M.blend_bg

function M.blend_fg(hex, amount, fg)
  return M.blend(hex, amount, fg or M.fg)
end
M.lighten = M.blend_fg

---@param color string|Palette
function M.invert(color)
  if type(color) == "table" then
    for key, value in pairs(color) do
      color[key] = M.invert(value)
    end
  elseif type(color) == "string" then
    local hsluv = require("violet-void.hsluv")
    if color ~= "NONE" then
      local hsl = hsluv.hex_to_hsluv(color)
      hsl[3] = 100 - hsl[3]
      if hsl[3] < 40 then
        hsl[3] = hsl[3] + (100 - hsl[3]) * M.day_brightness
      end
      return hsluv.hsluv_to_hex(hsl)
    end
  end
  return color
end

---@param color string|Palette
function M.invert_for_light(color)
  if type(color) == "table" then
    for key, value in pairs(color) do
      color[key] = M.invert_for_light(value)
    end
  elseif type(color) == "string" then
    local hsluv = require("violet-void.hsluv")
    if color ~= "NONE" then
      local hsl = hsluv.hex_to_hsluv(color)

      -- For light themes, we want to darken the colors instead of just inverting
      -- Keep the hue, adjust saturation and lightness

      -- Reduce lightness significantly for better contrast on light background
      hsl[3] = hsl[3] * 0.6 -- Darken colors

      -- Boost saturation for vibrancy
      hsl[2] = math.min(hsl[2] * 1.2, 100)

      -- Ensure minimum darkness for readability
      if hsl[3] > 60 then
        hsl[3] = 60
      end

      return hsluv.hsluv_to_hex(hsl)
    end
  end
  return color
end

---@param color string  -- The hex color string to be adjusted
---@param lightness_amount number? -- The amount to increase lightness by (optional, default: 0.1)
---@param saturation_amount number? -- The amount to increase saturation by (optional, default: 0.15)
function M.brighten(color, lightness_amount, saturation_amount)
  lightness_amount = lightness_amount or 0.05
  saturation_amount = saturation_amount or 0.2
  local hsluv = require("violet-void.hsluv")

  -- Convert the hex color to HSLuv
  local hsl = hsluv.hex_to_hsluv(color)

  -- Increase lightness slightly
  hsl[3] = math.min(hsl[3] + (lightness_amount * 100), 100)

  -- Increase saturation a bit more to make the color more vivid
  hsl[2] = math.min(hsl[2] + (saturation_amount * 100), 100)

  -- Convert the HSLuv back to hex and return
  return hsluv.hsluv_to_hex(hsl)
end

-- Color harmony functions for generating color palettes
local function clamp(value, min, max)
  return math.max(min, math.min(max, value))
end

local function hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  if #hex == 3 then
    hex = hex:sub(1, 1):rep(2) .. hex:sub(2, 2):rep(2) .. hex:sub(3, 3):rep(2)
  end
  local r = tonumber(hex:sub(1, 2), 16) / 255
  local g = tonumber(hex:sub(3, 4), 16) / 255
  local b = tonumber(hex:sub(5, 6), 16) / 255
  return r, g, b
end

local function rgb_to_hex(r, g, b)
  r = math.floor(clamp(r * 255, 0, 255) + 0.5)
  g = math.floor(clamp(g * 255, 0, 255) + 0.5)
  b = math.floor(clamp(b * 255, 0, 255) + 0.5)
  return string.format("#%02x%02x%02x", r, g, b)
end

local function rgb_to_hsl(r, g, b)
  local max = math.max(r, g, b)
  local min = math.min(r, g, b)
  local h, s, l = 0, 0, (max + min) / 2

  if max ~= min then
    local d = max - min
    s = l > 0.5 and d / (2 - max - min) or d / (max + min)

    if max == r then
      h = (g - b) / d + (g < b and 6 or 0)
    elseif max == g then
      h = (b - r) / d + 2
    else
      h = (r - g) / d + 4
    end
    h = h / 6
  end

  return h * 360, s, l
end

local function hsl_to_rgb(h, s, l)
  h = h / 360
  local r, g, b

  if s == 0 then
    r, g, b = l, l, l
  else
    local function hue_to_rgb(p, q, t)
      if t < 0 then
        t = t + 1
      end
      if t > 1 then
        t = t - 1
      end
      if t < 1 / 6 then
        return p + (q - p) * 6 * t
      end
      if t < 1 / 2 then
        return q
      end
      if t < 2 / 3 then
        return p + (q - p) * (2 / 3 - t) * 6
      end
      return p
    end

    local q = l < 0.5 and l * (1 + s) or l + s - l * s
    local p = 2 * l - q
    r = hue_to_rgb(p, q, h + 1 / 3)
    g = hue_to_rgb(p, q, h)
    b = hue_to_rgb(p, q, h - 1 / 3)
  end

  return r, g, b
end

local function adjust_hue(hue, degrees)
  return (hue + degrees) % 360
end

---@param hex string
---@return table
function M.complement(hex)
  local r, g, b = hex_to_rgb(hex)
  local h, s, l = rgb_to_hsl(r, g, b)
  h = adjust_hue(h, 180)
  r, g, b = hsl_to_rgb(h, s, l)
  return {
    base = hex,
    complement = rgb_to_hex(r, g, b),
  }
end

---@param hex string
---@return table
function M.split_complementary(hex)
  local r, g, b = hex_to_rgb(hex)
  local h, s, l = rgb_to_hsl(r, g, b)

  local h1 = adjust_hue(h, 150)
  local h2 = adjust_hue(h, 210)

  local r1, g1, b1 = hsl_to_rgb(h1, s, l)
  local r2, g2, b2 = hsl_to_rgb(h2, s, l)

  return {
    base = hex,
    split1 = rgb_to_hex(r1, g1, b1),
    split2 = rgb_to_hex(r2, g2, b2),
  }
end

---@param hex string
---@return table
function M.triadic(hex)
  local r, g, b = hex_to_rgb(hex)
  local h, s, l = rgb_to_hsl(r, g, b)

  local h1 = adjust_hue(h, 120)
  local h2 = adjust_hue(h, 240)

  local r1, g1, b1 = hsl_to_rgb(h1, s, l)
  local r2, g2, b2 = hsl_to_rgb(h2, s, l)

  return {
    base = hex,
    triadic1 = rgb_to_hex(r1, g1, b1),
    triadic2 = rgb_to_hex(r2, g2, b2),
  }
end

---@param hex string
---@return table
function M.analogous(hex)
  local r, g, b = hex_to_rgb(hex)
  local h, s, l = rgb_to_hsl(r, g, b)

  local h1 = adjust_hue(h, -30)
  local h2 = adjust_hue(h, 30)

  local r1, g1, b1 = hsl_to_rgb(h1, s, l)
  local r2, g2, b2 = hsl_to_rgb(h2, s, l)

  return {
    base = hex,
    analogous1 = rgb_to_hex(r1, g1, b1),
    analogous2 = rgb_to_hex(r2, g2, b2),
  }
end

---@param hex string
---@return table
function M.monochromatic(hex)
  return {
    base = hex,
    darker = M.darken(hex, 0.5),
    lighter = M.lighten(hex, 0.5),
  }
end

---@param hex string
---@return table
function M.tetradic(hex)
  local r, g, b = hex_to_rgb(hex)
  local h, s, l = rgb_to_hsl(r, g, b)

  local h1 = adjust_hue(h, 60)
  local h2 = adjust_hue(h, 180)
  local h3 = adjust_hue(h, 240)

  local r1, g1, b1 = hsl_to_rgb(h1, s, l)
  local r2, g2, b2 = hsl_to_rgb(h2, s, l)
  local r3, g3, b3 = hsl_to_rgb(h3, s, l)

  return {
    base = hex,
    tetradic1 = rgb_to_hex(r1, g1, b1),
    tetradic2 = rgb_to_hex(r2, g2, b2),
    tetradic3 = rgb_to_hex(r3, g3, b3),
  }
end

---@param hex string
---@return table
function M.get_all_harmonies(hex)
  return {
    complement = M.complement(hex),
    split_complementary = M.split_complementary(hex),
    triadic = M.triadic(hex),
    analogous = M.analogous(hex),
    monochromatic = M.monochromatic(hex),
    tetradic = M.tetradic(hex),
  }
end

---@param groups violet-void.Highlights
---@return violet-void.Highlights
function M.resolve(groups)
  for _, hl in pairs(groups) do
    if type(hl.style) == "table" then
      for k, v in pairs(hl.style) do
        hl[k] = v
      end
      hl.style = nil
    end
  end
  return groups
end

-- Simple string interpolation.
--
-- Example template: "${name} is ${value}"
--
---@param str string template string
---@param table table key value pairs to replace in the string
function M.template(str, table)
  return (
    str:gsub("($%b{})", function(w)
      return vim.tbl_get(table, unpack(vim.split(w:sub(3, -2), ".", { plain = true }))) or w
    end)
  )
end

---@param file string
function M.read(file)
  local fd = assert(io.open(file, "r"))
  ---@type string
  local data = fd:read("*a")
  fd:close()
  return data
end

---@param file string
---@param contents string
function M.write(file, contents)
  vim.fn.mkdir(vim.fn.fnamemodify(file, ":h"), "p")
  local fd = assert(io.open(file, "w+"))
  fd:write(contents)
  fd:close()
end

M.cache = {}

function M.cache.file(key)
  return vim.fn.stdpath("cache") .. "/violet-void-" .. key .. ".json"
end

---@param key string
function M.cache.read(key)
  ---@type boolean, violet-void.Cache
  local ok, ret = pcall(function()
    return vim.json.decode(M.read(M.cache.file(key)), { luanil = {
      object = true,
      array = true,
    } })
  end)
  return ok and ret or nil
end

---@param key string
---@param data violet-void.Cache
function M.cache.write(key, data)
  pcall(M.write, M.cache.file(key), vim.json.encode(data))
end

function M.cache.clear()
  for _, style in ipairs({ "violet-void", "void-light" }) do
    local uv = vim.uv or vim.loop
    uv.fs_unlink(M.cache.file(style))
  end
end

local function ensure_config()
  local config = require("violet-void.config")
  if not config.options then
    config.setup()
  end
  return config
end

---@param opts? VioletVoid.Config
---@return VioletVoid.Highlights highlights, ColorScheme colors, VioletVoid.Config resolved_opts
function M.collect_highlights(opts)
  ensure_config()

  local merged_opts = vim.tbl_deep_extend("force", {
    plugins = {
      all = true,
      auto = false,
    },
  }, opts or {})

  local colors, resolved_opts = require("violet-void.colors").setup(merged_opts)
  local highlights = require("violet-void.groups").setup(colors, resolved_opts)

  return highlights, colors, resolved_opts
end

---@param expected string[]
---@param highlights? VioletVoid.Highlights
---@return string[] missing, string[] unexpected
function M.diff_highlight_sets(expected, highlights)
  highlights = highlights or select(1, M.collect_highlights())

  local missing, unexpected, seen = {}, {}, {}

  for _, name in ipairs(expected) do
    if not highlights[name] then
      table.insert(missing, name)
    else
      seen[name] = true
    end
  end

  for name in pairs(highlights) do
    if not seen[name] then
      table.insert(unexpected, name)
    end
  end

  table.sort(missing)
  table.sort(unexpected)

  return missing, unexpected
end

return M
