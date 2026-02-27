local Util = require("violet-void.util")

local M = {}

M.url = "https://github.com/MeanderingProgrammer/render-markdown.nvim"

---@type violet-void.HighlightsFn
function M.get(c)
  -- local code_bg = Util.blend_bg(c.fg_gutter, 0.05) -- TODO: wez glyph
  -- local border_fg = Util.blend_bg(c.fg_gutter, 0.08) -- TODO: wez glyph

  -- stylua: ignore
  local ret = {
    RenderMarkdownBullet    = {fg = c.orange}, -- horizontal rule
    -- RenderMarkdownCode      = { bg = code_bg }, -- TODO: wez glyph
    -- RenderMarkdownCodeBorder = { fg = border_fg, bg = code_bg }, -- TODO: wez glyph
    RenderMarkdownCodeInfo  = { fg = c.green }, -- TODO: wez glyph
    RenderMarkdownDash      = {fg = Util.blend_bg(c.orange, 0.22)}, -- horizontal rule
    RenderMarkdownTableHead = { fg = c.red},
    RenderMarkdownTableRow  = { fg = c.orange},
    RenderMarkdownCodeInline = "@markup.raw.markdown_inline",
    RenderMarkdownLink      = { fg = c.warning, underline = true },
    RenderMarkdownQuote1    = { fg = c.red, bold = true },
    RenderMarkdownQuote2    = { fg = c.red, bold = true },
    RenderMarkdownQuote3    = { fg = c.red, bold = true },
    RenderMarkdownQuote4    = { fg = c.red, bold = true },
    RenderMarkdownQuote5    = { fg = c.red, bold = true },
    RenderMarkdownQuote6    = { fg = c.red, bold = true },
  }
  for i, color in ipairs(c.rainbow) do
    ret["RenderMarkdownH" .. i .. "Bg"] = { bg = Util.blend_bg(color, 0.05) }
    ret["RenderMarkdownH" .. i .. "Fg"] = { fg = color, bold = true }
  end
  return ret
end

return M
