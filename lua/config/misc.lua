local M = {}

M.lspsaga = function()
  require("lspsaga").setup({
    ui = { border = "rounded" },
    diagnostic = {
      on_insert = false,
      on_insert_follow = false,
      keys = {
        exec_action = "<CR>",
      },
    },
    -- scroll_preview = {
    --   scroll_down = "",
    --   scroll_up = "",
    -- },
    code_action = { extend_gitsigns = false },
    lightbulb = { enable = false },
    symbol_in_winbar = { enable = false },
  })
end

M.Comment = function()
  require("mappings").comment()
  require("Comment").setup({
    mappings = {
      basic = false,
      extra = false,
    },
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  })
end

M.LuaSnip = function()
  require("luasnip").setup({
    history = false,
    updateevents = "TextChanged,TextChangedI",
  })
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.g.luasnippets_path } })

  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    callback = function()
      if
        require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
    end,
  })
end

M.gitsigns = function()
  dofile(vim.g.base46_cache .. "git")
  local null = require("null-ls")

  require("gitsigns").setup({
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    sign_priority = 0,
    max_file_length = 3000,
    preview_config = {
      border = "rounded",
    },
    on_attach = function(bufnr)
      require("mappings").git(bufnr)
      require("mappings").null_ls(bufnr)
    end,
  })
  null.register({
    null.builtins.code_actions.gitsigns,
  })
end

M["nvim-tree"] = function()
  dofile(vim.g.base46_cache .. "nvimtree")
  require("nvim-tree").setup({
    hijack_cursor = true,
    filters = {
      dotfiles = true,
      custom = {
        "**/node_modules",
        "**/%.git",
        "**/%.github",
      },
      exclude = {
        ".gitignore",
        ".gitmodules",
        ".luarc.json",
        ".eslintrc.json",
        ".exrc",
        ".nvim.lua",
        ".editorconfig",
      },
    },
    disable_netrw = true,
    -- hijack_netrw = true,
    -- ignore_ft_on_config_pre = { "alpha", "dashboard", "aerial", "mind" },
    sort_by = "extension",
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
    view = {
      side = vim.g.nvimtree_side,
      width = 25,
      -- hide_root_folder = false,
      preserve_window_proportions = true,
      mappings = {
        list = {
          { key = "d", action = "trash" },
        },
      },
    },
    git = {
      enable = true,
      show_on_open_dirs = false,
      ignore = false,
      timeout = 5000,
    },
    filesystem_watchers = {
      debounce_delay = 100,
    },
    actions = {
      change_dir = {
        enable = false,
        restrict_above_cwd = true,
        -- global = true,
      },
    },
    renderer = {
      group_empty = true,
      root_folder_label = true,
      highlight_git = true,
      highlight_opened_files = "name",
      -- root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" },
      indent_markers = {
        enable = true,
      },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = false,
          git = true,
        },
      },
    },
  })
end

M["indent-blankline"] = function()
  pcall(function()
    dofile(vim.g.base46_cache .. "blankline")
  end)
  require("indent_blankline").setup({
    filetype_exclude = {
      "help",
      "terminal",
      "packer",
      "qf",
      "lspinfo",
      "mason",
      "TelescopePrompt",
      "TelescopeResults",
      "norg",
      "noice",
    },
    buftype_exclude = {
      "terminal",
      "help",
      "nofile",
    },
    show_trailing_blankline_indent = false,
    show_current_context = true,
    show_first_indent_level = false,
  })
end

M.mason = function()
  -- vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/mason/bin"
  require("mason").setup({
    PATH = "append",
    ui = {
      border = "rounded",
      icons = {
        package_pending = " ",
        package_installed = " ",
        package_uninstalled = " ﮊ",
      },
    },
  })
end

M.noice = function()
  require("noice").setup({
    cmdline   = { enabled = false },
    messages  = { enabled = false },
    popupmenu = { enabled = false },
    notify    = { enabled = false },
    lsp       = {
      progress = { enabled = false },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = false,
      },
      signature = {
        enabled = true,
        opts = {
          focusable = false,
          size = {
            max_height = 15,
            max_width = 60,
          },
          win_options = {
            wrap = false,
          }
        },
      },
      documentation = {
        opts = {
          border = {
            padding = { 0, 0 },
          },
        },
      },
    },
    health    = { checker = false },
    presets   = { lsp_doc_border = true },
  })
end

return M
