---Workaround to use Base46 outside NvChad :wink:
local M = {}

-- vim.g.nvchad_theme = "vscode_dark"

--- This is the base46-related configs
--- Aka all the ui table
M.load_config = function()
  ---@type ChadrcConfig
  local spec = {
    ui = {
      ---@type HLTable
      hl_override = {
        Normal = { bg = vim.g.transparency and "NONE" or "one_bg" },
        LineNr = { fg = "white" },
        Folded = { fg = "blue" },
        MatchWord = { bg = "black", fg = "orange", bold = true },
        Visual = { bg = "grey"},
        IndentBlanklineContextChar = { fg = "nord_blue" },
        TelescopeSelection = { bg = "grey_fg2" },
        WinSeparator = { fg = "white" },
        NvimTreeWinSeparator = { fg = "white" },
        NvimTreeGitNew = { fg = "green" },
        NvimTreeGitDirty = { fg = "yellow" },
        NvimTreeGitDeleted = { fg = "red" },
        -- Gitsigns
        DiffChange = { fg = "yellow" },
        DiffAdd = { fg = "green" },
        DiffText = { fg = "white", bg = "red", bold = true },
        -- StorageClass = { fg = " green1" },
        -- ["@emphasis"]    = { fg = "white", },

        -- nvim-cmp
        CmpBorder = { fg = "orange" },
        CmpDocBorder = { fg = "sun" },
        CmpItemKindFolder = { fg = "blue" },
        -- Syntax
        -- Macro = { fg = "red", bold = true },
        -- PreProc = { fg = "pink", bold = true },
        Comment = { fg = "yellow", italic = true },
        String = { fg = "orange" },
        Type = { fg = "vibrant_green" },
        Character = { fg = "orange" },
        -- Constant = { fg = "red" },
        -- Structure = { fg = "green1" },
        -- Identifier = { fg = "purple" },

        -- Treesitter
        ["@text.emphasis"] = { italic = true, fg = "white" },
        ["@text.strike"] = { strikethrough = true, fg = "white" },
        ["@string"] = { fg = "orange" },
        ["@punctuation.bracket"] = { fg = "nord_blue" },
        ["@keyword.function"] = { fg = "purple" },
        -- Semantics
        -- ["@property"]              = { fg = "teal" },
        -- ["@constructor"] = { fg = "yellow" },

        -- Semantics token
        ["@lsp.type.class"] = { fg = (vim.g.nvchad_theme == "vscode_dark") and "green1" or "vibrant_green" },
        ["@lsp.type.interface"] = { fg = "vibrant_green" },
        ["@lsp.type.annotation"] = { fg = "yellow" },
        ["@lsp.type.module"] = { fg = "cyan" },
        ["@lsp.type.parameter"] = { fg = "teal" },
        ["@lsp.type.variable"] = { fg = "cyan" },
      },
      hl_add = {
        SpecialKey = { fg = "yellow" },
        luaparenError = { link = "Normal" },
        ------------------------LspSaga------------------------------------
        SagaBorder = { fg = "blue" },
        HoverNormal = { fg = "white" },
        CodeActionText = { fg = "white" },
        ------------------------Custom Statusline coloring-----------------
        StNormalMode = { fg = "black2", bg = "blue", bold = true },
        StVisualMode = { fg = "black2", bg = "cyan", bold = true },
        StInsertMode = { fg = "black2", bg = "dark_purple", bold = true },
        StTerminalMode = { fg = "black2", bg = "green", bold = true },
        StNTerminalMode = { fg = "black2", bg = "yellow", bold = true },
        StReplaceMode = { fg = "black2", bg = "orange", bold = true },
        StConfirmMode = { fg = "black2", bg = "teal", bold = true },
        StCommandMode = { fg = "black2", bg = "green", bold = true },
        StSelectMode = { fg = "black2", bg = "blue", bold = true },
        StInviSep = { bg = "statusline_bg", fg = "statusline_bg" },
        StNormalModeSep = { bg = "statusline_bg", fg = "blue" },
        StVisualModeSep = { bg = "statusline_bg", fg = "cyan" },
        StInsertModeSep = { bg = "statusline_bg", fg = "dark_purple" },
        StTerminalModeSep = { bg = "statusline_bg", fg = "green" },
        StNTerminalModeSep = { bg = "statusline_bg", fg = "yellow" },
        StReplaceModeSep = { bg = "statusline_bg", fg = "orange" },
        StConfirmModeSep = { bg = "statusline_bg", fg = "teal" },
        StCommandModeSep = { bg = "statusline_bg", fg = "green" },
        StSelectModeSep = { bg = "statusline_bg", fg = "blue" },
        -- -- For my own statusline
        -- StNormalModeSep    = { bg = "statusline_bg", },
        -- StInsertModeSep    = { bg = "statusline_bg", },
        -- StTerminalModeSep  = { bg = "statusline_bg", },
        -- StNTerminalModeSep = { bg = "statusline_bg", },
        -- StVisualModeSep    = { bg = "statusline_bg", },
        -- StReplaceModeSep   = { bg = "statusline_bg", },
        -- StConfirmModeSep   = { bg = "statusline_bg", },
        -- StCommandModeSep   = { bg = "statusline_bg", },
        -- StSelectModeSep    = { bg = "statusline_bg", },

        --CurFile
        StCwd = { bg = "yellow", fg = "black" },
        StFile = { bg = "orange", fg = "black", bold = true },
        StCwdSep = { fg = "yellow", bg = "statusline_bg" },
        StFileSep = { fg = "orange", bg = "statusline_bg" },
        StDirFileSep = { fg = "yellow", bg = "orange" },
        -- Git stuffs
        StGitBranch = { bg = "light_grey", fg = "purple" },
        StGitAdded = { bg = "light_grey", fg = "green" },
        StGitChanged = { bg = "light_grey", fg = "yellow" },
        StGitRemoved = { bg = "light_grey", fg = "red" },
        StGitSep = { bg = "statusline_bg", fg = "light_grey" },
        -- LSP Stuffs
        -- StLSPProgress = { bg = "statusline_bg", fg = "" },
        StLSPClient = { bg = "statusline_bg", fg = "blue", bold = true },
        StLSPDiagSep = { bg = "statusline_bg", fg = "light_grey" },
        StLSPErrors = { bg = "light_grey", fg = "red" },
        StLSPWarnings = { bg = "light_grey", fg = "yellow" },
        StLSPHints = { bg = "light_grey", fg = "purple" },
        StLspInfo = { bg = "light_grey", fg = "cyan" },
        -- Lsp Diagnostics
        DiagnosticHint = { fg = "purple" },
        DiagnosticError = { fg = "red" },
        DiagnosticWarn = { fg = "yellow" },
        DiagnosticInformation = { fg = "green" },
        -- File Info stuffs
        StPosition = { bg = "teal", fg = "black" },
        StPositionSep = { bg = "statusline_bg", fg = "teal" },
        --------Custom Statusline coloring ends------------

        --------Custom Tabline coloring--------------------
        TabLineFill = { underline = true, fg = "white", bg = "darker_black" },
        TabLineBufHidden = { underline = true, fg = "white", bg = "light_grey" },
        TabLineBufActive = { fg = "white", bg = "nord_blue", bold = true },
        TabLineCurrentBuf = { fg = "white", bg = "red", bold = true },
        TabLineModified = { fg = "green" },
        TabLineCurrentTab = { underline = true, fg = "white", bg = "red", bold = true },
        TabLineOtherTab = { underline = true, fg = "white", bg = "black2" },
        TabLineBufActiveSep = { underline = true, fg = "white", bg = "black2" },
        TabLineCurrentBufSep = { underline = true, fg = "white", bg = "black2" },
        TabLineBufHiddenSep = { underline = true, fg = "white", bg = "black2" },
        --- Good old colorful statusline
        -- TabLineBufHidden  = { fg = "black2", bg = "light_grey" },
        -- TabLineBufActive  = { fg = "black2", bg = "cyan", },
        -- TabLineCurrentBuf = { fg = "darker_black", bg = "pink", bold = true },
        -- TabLineModified   = { fg = "green" },
        -- TabLineCurrentTab = { fg = "darker_black", bg = "red", bold = true },
        -- TabLineOtherTab   = { fg = "white", bg = "black2" },
        --
        -- TabLineBufActiveSep  = { fg = "cyan", bg = "black2" },
        -- TabLineCurrentBufSep = { fg = "pink", bg = "darker_black" },
        -- TabLineBufHiddenSep  = { fg = "light_grey", bg = "black2" },
        --------Custom Tabline coloring ends---------------

        --------WinBar coloring----------------------------
        -- WinBarCurrentFile = { fg = "green", bold = true },
        --------WinBar coloring ends-----------------------

        --------Statuscolumn coloring----------------------
        CurrentLineNr = { fg = "yellow", bold = true },
        --------Statuscolumn coloring ends-----------------

        --------Noice-------------------------------------

        --------Noice ends--------------------------------

        -- Packer
        PackerPackageName = { fg = "red" },
        PackerSuccess = { fg = "green" },
        PackerStatusSuccess = { fg = "green" },
        PackerStatusCommit = { fg = "blue" },
        PackeProgress = { fg = "blue" },
        PackerOutput = { fg = "red" },
        PackerStatus = { fg = "blue" },
        PackerHash = { fg = "blue" },
        -- Add strikethrough to hlgroups that signifies deprecated stuffs
        cssDeprecated = { strikethrough = true },
        javaScriptDeprecated = { strikethrough = true },
        markdownError = { link = "Normal" },
        Underlined = { underline = true },
        NullLsInfoBorder = { link = "FloatBorder" },
        -- Treesitter
        ["@boolean"] = { fg = "green" },
        ["@text.danger"] = { fg = "red" },
        ["@text.note"] = { fg = "blue" },
        ["@text.header"] = { bold = true },
        ["@text.diff.add"] = { fg = "green" },
        ["@text.diff.delete"] = { fg = "red" },
        ["@text.todo"] = { fg = "blue" },
        ["@string.special"] = { fg = "blue" },
        -- ["@parameter"]        = { fg = "blue" },
        -- ["@variable"]         = { fg = "base08" },
        -- ["@constant.macro"]   = { fg = "pink" },
        -- ["@interface"]        = { link = "Type" },
        -- ["@type.builtin"]     = { fg = "green1" },
        -- ["@type.qualifier"]   = { fg = "teal" },
        -- ["@storageclass"]     = { fg = "teal" },
        -- ["@text.underline"]   = { underline = true, fg = "green" },

        -- Semantic tokens
        ["@lsp.type.type.lua"] = { fg = "green" },
        ["@lsp.mod.builtin"] = { fg = "sun" },
        ["@lsp.mod.readonly"] = { link = "Constant" },
        ["@lsp.mod.documentation"] = { bold = true, fg = "purple" },
        ["@lsp.type.keyword"] = { fg = vim.g.nvchad_theme == "vscode_dark" and "pink" or "purple" },
        -- ["@lsp.mod.defaultLibrary"] = { fg = "green" },
        -- ["@lsp.type.variable"] = { fg = "light_blue" },
        -- ["@lsp.type.variable.python"] = { fg = "light_blue" },
        -- ["@readonly"]         = { link = "Constant" },
      },
      changed_themes = {
        vscode_dark = {
          base_30 = {
            vibrant_green = "#4ECF94",
          },
        },
      },
      theme_toggle = { "vscode_dark", "catppuccin" },
      theme = "vscode_dark", -- default theme
      transparency = true,
      -- cmp themeing
      cmp = {
        icons = true,
        lspkind_text = true,
        style = "default",            -- default/flat_light/flat_dark/atom/atom_colored
        border_color = "grey_fg",     -- only applicable for "default" style, use color names from base30 variables
        selected_item_bg = "colored", -- colored / simple
      },
      statusline = {
        theme = "default",
      },
      cheatsheet = {
        theme = "grid", -- simple/grid
      },
      telescope = {
        style = "borderless",
      },
    },
  }
  return spec

  ------------------------------- base46 -------------------------------------
  -- hl = highlights
end

return M
