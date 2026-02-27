local M = {}

---@type violet-void.HighlightsFn
function M.get(c)
  -- stylua: ignore
  return {
    -- Main window
    FzfLuaNormal            = { fg = c.fg, bg = c.bg_popup },
    FzfLuaBorder            = { fg = c.border_highlight, bg = c.bg_float },
    FzfLuaTitle             = { fg = c.blue, bg = c.bg_popup, bold = true },
    FzfLuaTitleFlags        = { fg = c.purple, bg = c.bg_popup },
    FzfLuaBackdrop          = { bg = c.bg_dark },

    -- Preview window
    FzfLuaPreviewNormal     = { fg = c.fg, bg = c.bg_float },
    FzfLuaPreviewBorder     = { fg = c.border_highlight, bg = c.bg_float },
    FzfLuaPreviewTitle      = { fg = c.blue, bg = c.bg_float, bold = true },
    FzfLuaCursor            = { fg = c.bg, bg = c.fg },
    FzfLuaCursorLine        = { bg = c.bg_highlight },
    FzfLuaCursorLineNr      = { fg = c.green1 },
    FzfLuaSearch            = { bg = c.bg_search, fg = c.fg, bold = true },

    -- Scrollbars
    FzfLuaScrollBorderEmpty = { fg = c.border_highlight, bg = c.bg_float },
    FzfLuaScrollBorderFull  = { fg = c.border_highlight, bg = c.bg_float },
    FzfLuaScrollFloatEmpty  = { bg = c.bg_popup },
    FzfLuaScrollFloatFull   = { fg = c.fg_gutter },

    -- Help window
    FzfLuaHelpNormal        = { fg = c.fg, bg = c.bg_popup },
    FzfLuaHelpBorder        = { fg = c.border_highlight, bg = c.bg_float },

    -- Header elements
    FzfLuaHeaderBind        = { fg = c.orange, bold = true },
    FzfLuaHeaderText        = { fg = c.cyan },

    -- Path highlighting
    FzfLuaPathColNr         = { fg = c.blue5 },
    FzfLuaPathLineNr        = { fg = c.green },

    -- Buffer-related
    FzfLuaBufName           = { fg = c.blue, bold = true },
    FzfLuaBufId             = { fg = c.comment },
    FzfLuaBufNr             = { fg = c.orange },
    FzfLuaBufLineNr         = { fg = c.fg_gutter },
    FzfLuaBufFlagCur        = { fg = c.cyan, bold = true },
    FzfLuaBufFlagAlt        = { fg = c.blue0 },

    -- Tab-related
    FzfLuaTabTitle          = { fg = c.blue0, bold = true },
    FzfLuaTabMarker         = { fg = c.orange },

    -- File/directory highlighting
    FzfLuaDirIcon           = { fg = c.blue, bold = true },
    FzfLuaDirPart           = { fg = c.comment },
    FzfLuaFilePart          = { fg = c.fg },

    -- Live query
    FzfLuaLivePrompt        = { fg = c.purple, bold = true },
    FzfLuaLiveSym           = { fg = c.purple, bold = true },

    -- fzf interface
    FzfLuaFzfNormal         = { fg = c.fg, bg = c.bg_float },
    FzfLuaFzfCursorLine     = { bg = c.bg_highlight },
    FzfLuaFzfMatch          = { fg = c.orange, bold = true },
    FzfLuaFzfBorder         = { fg = c.border_highlight, bg = c.bg_float },
    FzfLuaFzfScrollbar      = { fg = c.blue },
    FzfLuaFzfSeparator      = { fg = c.blue },
    FzfLuaFzfGutter         = { bg = c.bg_popup },
    FzfLuaFzfHeader         = { fg = c.blue, bold = true },
    FzfLuaFzfInfo           = { fg = c.dark3 },
    FzfLuaFzfPointer        = { fg = c.orange, bold = true },
    FzfLuaFzfMarker         = { fg = c.orange, bold = true },
    FzfLuaFzfSpinner        = { fg = c.orange, bold = true },
    FzfLuaFzfPrompt         = { fg = c.orange, bold = true },
    FzfLuaFzfQuery          = { fg = c.fg, bg = c.bg_popup },
  }
end

return M
