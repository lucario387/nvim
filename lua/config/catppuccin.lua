require("catppuccin").setup({
  -- transparent_background = vim
  flavour = "frappe",
  highlight_overrides = {
    all = function(colors)
      return {
        FloatBorder                = { link = "SagaBorder" },
        LineNr                     = { fg = colors.text },
        Folded                     = { fg = colors.blue },
        MatchWord                  = { bold = true },
        Visual                     = { sp = colors.text, underline = true },
        IndentBlankLineContextChar = { fg = colors.sapphire },
        -- TelescopeSelection = { bg = colors.subtext1 },
        -- TelescopeBorder            = { fg = colors.base, bg = colors.base },

        -- CursorLine = { bg = colors.text },
        NvimTreeWinSeparator       = { fg = colors.text },
        NvimTreeGitNew             = { fg = colors.green },
        NvimTreeGitDirty           = { fg = colors.yellow },
        NvimTreeGitDeleted         = { fg = colors.red },
        -- ColorColumn = { bg = colors. },
        SpecialKey                 = { fg = colors.yellow },
        SagaBorder                 = {
          fg = colors.blue,
        },
        HoverNormal                = { fg = colors.text },

        -- Gitsigns
        GitSignsAddInline = { link = "DiffAdd" },
        GitSignsDeleteInline = { link = "DiffDelete" },
        GitSignsChangedInline = { link = "DiffChange" } ,

        StNormalMode               = { fg = colors.surface0, bg = colors.blue, bold = true },
        StVisualMode               = { fg = colors.surface0, bg = colors.sky, bold = true },
        StInsertMode               = { fg = colors.surface0, bg = colors.lavender, bold = true },
        StTerminalMode             = { fg = colors.surface0, bg = colors.green, bold = true },
        StNTerminalMode            = { fg = colors.surface0, bg = colors.yellow, bold = true },
        StReplaceMode              = { fg = colors.surface0, bg = colors.peach, bold = true },
        StConfirmMode              = { fg = colors.surface0, bg = colors.sapphire, bold = true },
        StCommandMode              = { fg = colors.surface0, bg = colors.green, bold = true },
        StSelectMode               = { fg = colors.surface0, bg = colors.blue, bold = true },

        StInviSep                  = { bg = colors.surface1, fg = colors.surface1 },
        StNormalModeSep            = { bg = colors.surface1, fg = colors.blue },
        StVisualModeSep            = { bg = colors.surface1, fg = colors.sky },
        StInsertModeSep            = { bg = colors.surface1, fg = colors.lavender },
        StTerminalModeSep          = { bg = colors.surface1, fg = colors.green },
        StNTerminalModeSep         = { bg = colors.surface1, fg = colors.yellow },
        StReplaceModeSep           = { bg = colors.surface1, fg = colors.peach },
        StConfirmModeSep           = { bg = colors.surface1, fg = colors.sapphire },
        StCommandModeSep           = { bg = colors.surface1, fg = colors.green },
        StSelectModeSep            = { bg = colors.surface1, fg = colors.blue },

        --CurFile
        StCwd                      = { bg = colors.yellow, fg = colors.base },
        StFile                     = { bg = colors.peach, fg = colors.base, bold = true },
        StCwdSep                   = { fg = colors.yellow, bg = colors.surface1 },
        StFileSep                  = { fg = colors.peach, bg = colors.surface1 },
        StDirFileSep               = { fg = colors.yellow, bg = colors.peach },
        -- Git stuffs
        StGitBranch                = { bg = colors.overlay0, fg = colors.mauve },
        StGitAdded                 = { bg = colors.overlay0, fg = colors.green },
        StGitChanged               = { bg = colors.overlay0, fg = colors.yellow },
        StGitRemoved               = { bg = colors.overlay0, fg = colors.red },
        StGitSep                   = { bg = colors.surface1, fg = colors.overlay0 },
        -- LSP Stuffs
        -- StLSPProgress = { bg = vim.g.transparency and "NONE" or "statusline_bg", fg = "" },
        StLSPClient                = { bg = colors.surface1, fg = colors.blue, bold = true },
        StLSPDiagSep               = { bg = colors.surface1, fg = colors.overlay0 },
        StLSPErrors                = { bg = colors.overlay0, fg = colors.red },
        StLSPWarnings              = { bg = colors.overlay0, fg = colors.yellow },
        StLSPHints                 = { bg = colors.overlay0, fg = colors.mauve },
        StLspInfo                  = { bg = colors.overlay0, fg = colors.sky },
        -- Lsp Diagnostics
        DiagnosticHint             = { fg = colors.mauve },
        DiagnosticError            = { fg = colors.red },
        DiagnosticWarn             = { fg = colors.yellow },
        DiagnosticInformation      = { fg = colors.green },
        -- File Info stuffs
        StPosition                 = { bg = colors.sapphire, fg = colors.surface1 },
        StPositionSep              = { bg = colors.surface1, fg = colors.sapphire },


        --------Custom Tabline coloring--------------------
        TabLineFill                             = { fg = colors.text, bg = colors.crust, sp = colors.text },
        TabLineBufHidden                        = { fg = colors.mantle, bg = colors.subtext1, sp = colors.text },
        TabLineBufActive                        = { fg = colors.text, bg = colors.sapphire, bold = true, sp = colors.text },
        TabLineCurrentBuf                       = { fg = colors.mantle, bg = colors.red, bold = true, sp = colors.text },
        TabLineBufHiddenModified  = { fg = colors.green, bg = colors.subtext1, sp = colors.text },
        TabLineBufActiveModified  = { fg = colors.green, bg = colors.sapphire, bold = true, sp = colors.text },
        TabLineCurrentBufModified = { fg = colors.green, bg = colors.red, bold = true, sp = colors.text },
        TabLineModified                         = { fg = colors.green },
        TabLineCurrentTab                       = { fg = colors.mantle, bg = colors.red, bold = true, sp = colors.text },
        TabLineOtherTab                         = { fg = colors.mantle, bg = colors.subtext1, sp = colors.text },
        TabLineBufActiveSep                     = { fg = colors.sapphire, bg = colors.crust, sp = colors.text },
        TabLineCurrentBufSep                    = { fg = colors.red, bg = colors.crust, sp = colors.text },
        TabLineBufHiddenSep                     = { fg = colors.subtext1, bg = colors.crust, sp = colors.text },


        ["@conceal.checked"] = {
          fg = colors.teal,
        },
        ["@none"] = {
          link = "Normal",
        },
        ["@lsp.type.annotation"] = {
          fg = colors.yellow,
        },
        ["@lsp.type.modifier.java"] = {
          link = "@type.qualifier",
        },
        ["@lsp.mod.builtin"] = {
          fg = colors.maroon,
        },
        ["@lsp.mod.readonly.python"] = { link = "Constant" },
        ["@lsp.mod.documentation"] = { bold = true, fg = colors.mauve },
        ["@lsp.type.keyword"] = { fg = colors.mauve },
        DiagnosticUnnecessary = { link = "" },
      }
    end,
    latte = function(colors)
      return {
        ["@lsp.type.keyword"] = { fg = colors.lavender },
      }
    end,
  },
  background = {
    light = "latte",
    dark = "mocha",
  },
  term_colors = true,
  -- dim_inactive = {
  --   enabled = true,
  --   shade = "light",
  --   percentage = 0.20,
  -- },
  styles = {
    comments = {},
  },
  integrations = {
    alpha = false,
    cmp = true,
    dap = true,
    dap_ui = true,
    dashboard = false,
    flash = false,
    gitsigns = true,
    leap = true,
    mini = {
      enabled = false,
    },
    mason = true,
    markdown = true,
    neogit = true,
    nvimtree = true,
    ufo = false,
    rainbow_delimiters = false,
    semantic_tokens = true,
    telescope = { enabled = true, style = "nvchad" },
    treesitter = true,
    barbecue = false,
    illuminate = false,
    indent_blankline = {
      enabled = true,
      -- scope_color = "",
      colored_indent_levels = false,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
      inlay_hints = {
        background = true,
      },
    },
    lsp_saga = true,
    lsp_trouble = true,
    navic = {
      enabled = false,
      custom_bg = "NONE",
    },
    dropbar = {
      enabled = false,
      color_mode = false,
    },
  },
})
vim.cmd.colorscheme("catppuccin")
