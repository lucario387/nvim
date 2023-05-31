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
    finder = {
      
    },
    -- scroll_preview = {
    --   scroll_down = "",
    --   scroll_up = "",
    -- },
    code_action = { 
      extend_gitsigns = false,
      show_server_name = false,
    },
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

  vim.api.nvim_create_autocmd({ "ModeChanged" }, {
    pattern = { "i:*", "s:n" },
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
      add          = { text = "┃" },
      change       = { text = "┃" },
      delete       = { text = "󰍵" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
      untracked    = { text = "┆" },
    },
    sign_priority = 0,
    max_file_length = 3000,
    preview_config = {
      border = "rounded",
    },
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 500,
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
    experimental = {
      git = {
        async = false,
      },
    },
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")
      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.set("n", "d", api.fs.trash, { buffer = bufnr, nowait = true })
    end,
  })
end

M["indent-blankline"] = function()
  pcall(function()
    dofile(vim.g.base46_cache .. "blankline")
  end)
  -- vim.g.indent_blankline_use_treesitter = true
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
      "NvimTree",
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
        package_installed = "󰄴 ",
        package_uninstalled = " 󰚌",
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
          },
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

M.neogit = function()
  require("neogit").setup({
    integrations = {
      diffview = true,
    },
  })
end

M.wilder = function()
  local wilder = require("wilder")

  wilder.setup({ modes = { ":", "/", "?" } })
  wilder.set_option("use_python_remote_plugin", 0)
  wilder.set_option("pipeline", {
    wilder.branch(
      wilder.cmdline_pipeline({ use_python = 0, fuzzy = 1, fuzzy_filter = wilder.lua_fzy_filter() }),
      wilder.vim_search_pipeline(),
      {
        wilder.check(function(_, x)
          return x == ""
        end),
        wilder.history(),
        wilder.result({
          draw = {
            function(_, x)
              return x
            end,
          },
        }),
      }
    ),
  })


  local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
    border = "rounded",
    highlights = {
      border = "CmpBorder", -- highlight to use for the border
      -- accent = "CmpPmenu"
    },
    empty_message = wilder.popupmenu_empty_message_with_spinner(),
    highlighter = wilder.lua_fzy_highlighter(),
    left = {
      " ",
      wilder.popupmenu_devicons(),
      wilder.popupmenu_buffer_flags({
        flags = " a + ",
      }),
    },
    right = {
      " ",
      wilder.popupmenu_scrollbar(),
    },
  }))
  local wildmenu_renderer = wilder.wildmenu_renderer({
    highlighter = wilder.lua_fzy_highlighter(),
    highlights = {
      selected = "CmpSel",
      -- selected_accent = "CmpSel"
    },
    apply_incsearch_fix = true,
    separator = " | ",
    left = { " ", wilder.wildmenu_spinner(), " " },
    right = { " ", wilder.wildmenu_index() },
  })
  wilder.set_option(
    "renderer",
    wilder.renderer_mux({
      [":"] = popupmenu_renderer,
      ["/"] = wildmenu_renderer,
      substitute = wildmenu_renderer,
    })
  )
  -- local wilder = require('wilder')
  -- wilder.setup({modes = {':', '/', '?'}})
  -- -- Disable Python remote plugin
  -- wilder.set_option('use_python_remote_plugin', 0)
  --
  -- wilder.set_option('pipeline', {
  --   wilder.branch(
  --     wilder.cmdline_pipeline({
  --       fuzzy = 1,
  --       fuzzy_filter = wilder.lua_fzy_filter(),
  --     }),
  --     wilder.vim_search_pipeline()
  --   )
  -- })
  --
  -- wilder.set_option('renderer', wilder.renderer_mux({
  --   [':'] = wilder.popupmenu_renderer({
  --     highlighter = wilder.lua_fzy_highlighter(),
  --     left = {
  --       ' ',
  --       wilder.popupmenu_devicons()
  --     },
  --     right = {
  --       ' ',
  --       wilder.popupmenu_scrollbar()
  --     },
  --   }),
  --   ['/'] = wilder.wildmenu_renderer({
  --     highlighter = wilder.lua_fzy_highlighter(),
  --   }),
  -- }))
end

return M
