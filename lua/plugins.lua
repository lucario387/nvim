-- List of all default plugins & their definitions

local plugins = {

  -------------------------------------General---------------------------------
  {
    "wbthomason/packer.nvim",
    branch = "master",
    start = true,
    -- cmd = {
    --   "PackerSync",
    --   "PackerCompile",
    --   "PackerLoad",
    --   "PackerStatus",
    -- },
    -- config = function()
    --   require("plugins")
    -- end,
  },
  {
    "nvim-lua/plenary.nvim",
    start = true,
  },
  {
    "lewis6991/impatient.nvim",
    run = ":LuaCacheClear",
  },

  -- for managing lsp/formatter
  {
    "williamboman/mason.nvim",
    -- cmd = "Mason",
    -- opt = true,
    -- setup = function()
    -- end,
    config = function()
      vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/mason/bin"
      vim.api.nvim_create_autocmd("UIEnter", {
        once = true,
        callback = function()
          vim.schedule(function()
            if vim.v.exiting ~= vim.NIL then
              return
            end
            require("mason").setup({
              PATH = "skip",
              ui = {
                border = "rounded",
                icons = {
                  package_pending = " ",
                  package_installed = " ",
                  package_uninstalled = " ﮊ",
                },
              },
              max_concurrent_installers = 4,
            })
            -- load_plugin()
          end)
        end,
      })
    end,
  },

  -------------------------------------Theme-----------------------------------
  {
    "NvChad/base46",
    -- module = "base46",
    branch = "v2.0",
  },

  -------------------------------------LSP-------------------------------------
  {
    "neovim/nvim-lspconfig",
    -- opt = true,
    config = function()
      local utils = require("config.lsp")
      utils.lsp_handlers()
      if not vim.g.lsp or not vim.g.lsp.servers then
        return
      end
      local on_attach = utils.on_attach
      local capabilities = utils.set_capabilities()

      if vim.g.lsp.servers.default then
        for _, name in ipairs(vim.g.lsp.servers.default) do
          require("lspconfig")[name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end
      end

      if vim.g.lsp.servers.custom then
        for _, name in ipairs(vim.g.lsp.servers.custom) do
          require("config.lsp.custom")[name](on_attach, capabilities)
        end
      end
    end,
    -- setup = function()
    --   if not vim.g.lsp then
    --     return
    --   end
    --   vim.api.nvim_create_autocmd("UIEnter", {
    --     once = true,
    --     callback = function()
    --       vim.schedule(function()
    --         if vim.v.exiting ~= vim.NIL then
    --           return
    --         end
    --         require("packer").loader("nvim-lspconfig")
    --         -- load_plugin()
    --       end)
    --     end,
    --   })
    -- end,
  },
  {
    "glepnir/lspsaga.nvim",
    module = "lspsaga",
    cmd = "Lspsaga",
    config = function()
      require("lspsaga").setup({
        ui = {
          border = "rounded",
        },
        diagnostic = {
          on_insert = false,
          on_insert_follow = false,
          keys = {
            exec_action = "<CR>",
          },
        },
        code_action = {
          extend_gitsigns = false,
        },
        lightbulb = {
          enable = false,
        },
        symbol_in_winbar = {
          enable = false,
        },
      })
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    module = "null-ls",
    config = function()
      require("null-ls").setup({
        debug = false,
        on_attach = function(client, bufnr)
          require("mappings").null_ls(bufnr)
        end,
        border = "rounded",
      })
      if vim.g.lsp and vim.g.lsp.formatters and not vim.g.lsp.formatters["tsserver"] then
        require("config.lsp").register({
          require("null-ls").builtins.formatting.prettierd,
        })
      end
    end,
  },
  -- LSP for specific filetypes
  {
    "mfussenegger/nvim-jdtls",
    opt = true,
  },
  {
    "jose-elias-alvarez/typescript.nvim",
    start = true,
  },
  {
    "folke/neodev.nvim",
    start = true,
  },

  -------------------------------------DAP-------------------------------------
  {
    "mfussenegger/nvim-dap",
    module = "dap",
    ft = { "c", "cpp" },
    config = function()
      require("config.dap").setup()
    end,
    -- config_pre = function()
    --   require("core.utils").load_mappings("dap")
    -- end
  },
  {
    "rcarriga/cmp-dap",
    after = "nvim-dap",
    config = function()
      require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        },
      })
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    after = "nvim-dap",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    after = "nvim-dap",
    config = function()
      require("config.dap.ui")
    end,
  },
  -------------------------------------Tree-sitter-----------------------------
  {
    "~/dev/nvim-treesitter",
    -- opt = true,
    run = ":TSUpdate",
    -- event = "BufReadPre",
    config = function()
      vim.o.foldmethod = "expr"
      -- vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.o.foldexpr = "nvim_treesitter#foldexpr()"
      vim.o.foldenable = false
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        parser_install_dir = vim.fn.stdpath("data") .. "/site",
        ensure_installed = { "vim", "lua", "c" },
        ignore_install = {
          "latex",
        },
        highlight = {
          enable = true,
          disable = function(lang, bufnr)
            if vim.tbl_contains({}, lang) then
              return true
            end
            local max_filesize = 100 * 1024 -- 100kb
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
          disable = {
            -- "c", "cpp",
            -- "python",
          },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "g<cr>",
            node_incremental = "<cr>",
            scope_incremental = "<S-CR>",
            node_decremental = "<bs>",
          },
        },
        autotag = {
          enable = true,
        },
        matchup = {
          enable = true,
          include_match_words = true,
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        playground = {
          enable = true,
          disable = {},
          updatetime = 50,
        },
        query_linter = {
          enable = true,
          use_diagnostics = true,
          lint_events = { "BufRead", "CursorHold" },
        },
        --- nvim-treesitter-textobjects
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            include_surrounding_whitespace = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          swap = {
            enable = false,
          },
          move = {
            enable = false,
          },
        },
      })
    end,
    -- setup = function()
    --   vim.api.nvim_create_autocmd("UIEnter", {
    --     once = true,
    --     callback = function()
    --       vim.schedule(function()
    --         if vim.v.exiting ~= vim.NIL then
    --           return
    --         end
    --         -- load_plugin()
    --         require("packer").loader("nvim-treesitter")
    --       end)
    --     end,
    --   })
    -- end,
  },
  -- Movement related
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "BufRead",
  },
  -- {
  --   "kylechui/nvim-surround",
  --   event = "BufRead",
  --   config = function()
  --     require("nvim-surround").setup()
  --   end,
  -- },
  {
    "andymass/vim-matchup",
    event = "BufRead",
  },
  --ts misc
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufRead",
  },
  {
    "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle", "TSCaptureUnderCursor" },
  },
  {
    "numToStr/Comment.nvim",
    after = "nvim-ts-context-commentstring",
    config = function()
      require("mappings").comment()
      require("Comment").setup({
        mappings = {
          basic = false,
          extra = false,
        },
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  -------------------------------------Completion engine-----------------------
  {
    "rafamadriz/friendly-snippets",
    start = true,
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      require("config.cmp")
      -- autopairs as well, as autopairs has no reason to not be loaded on startup
      local autopairs = require("nvim-autopairs")
      -- local Rule = require("nvim-autopairs.rule")
      autopairs.setup({
        fast_wrap = {},
        disable_filetype = { "TelescopePrompt", "vim" },
      })

      require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

      -- autopairs.add_rules({
      --   Rule("%<%>$", "</>", { "typescript", "typescriptreact", "javascript", "javascriptreact" })
      --     :use_regex(true),
      -- })
    end,
  },

  { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp",     after = "nvim-cmp" },
  { "hrsh7th/cmp-buffer",       after = "nvim-cmp" },
  { "hrsh7th/cmp-path",         after = "nvim-cmp" },

  {
    "L3MON4D3/LuaSnip",
    -- disable = true,
    -- after = "nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      require("luasnip").config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
      })
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.g.luasnippets_path } })

      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if
            require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require("luasnip").session.jump_active
          then
            require("luasnip").unlink_current()
          end
        end,
      })
    end,
  },

  -- { "hrsh7th/cmp-cmdline",         requires = "nvim-cmp" },
  -- { "f3fora/cmp-spell", requires = "nvim-cmp" },

  { "windwp/nvim-autopairs",
    -- after = "nvim-cmp",
    -- event = "InsertEnter",
    -- config = function()
    -- end,
  },
  -------------------------------------Telescope-------------------------------
  {
    "nvim-telescope/telescope.nvim",
    module = "telescope",
    cmd = "Telescope",
    config = function()
      require("config.telescope")
    end,
    setup = function()
      require("mappings").telescope()
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },

  -------------------------------------Git-------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    opt = true,
    config = function()
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
        end,
      })
      null.register({
        null.builtins.code_actions.gitsigns,
      })
    end,
    setup = function()
      vim.api.nvim_create_autocmd("BufReadPre", {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system({ "git", "-C", vim.fn.expand("%:p:h"), "rev-parse" })
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
            vim.schedule(function()
              require("packer").loader("gitsigns.nvim")
              -- load_plugin()
            end)
          end
        end,
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    after = "gitsigns.nvim",
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true,
        view = {
          merge_tool = {
            layout = "diff3_mixed",
            disable_diagnostics = true,
          },
        },
      })
    end,
  },

  -------------------------------------Misc------------------------------------
  {
    "nvim-tree/nvim-web-devicons",
    start = true,
  },
  -- tree plugin
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeClose" },
    config = function()
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
          hide_root_folder = false,
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
    end,
    setup = function()
      vim.keymap.set("n", "<C-n>", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
      -- vim.keymap.set("n", "<C-n>", function()
      --   vim.keymap.del("n", "<C-n>")
      --   load_plugin()
      --   vim.cmd("NvimTreeToggle")
      -- end)
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
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
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("colorizer").setup({
        filetypes = { "lua", "vim", "css", "scss", "html", "vue" },
      })
    end,
  },
  {
    "NvChad/NvTerm",
    module = { "nvterm.terminal" },
    -- keys = { "<C-`>" },
    config = function()
      require("nvterm").setup({
        toggle = {
          horizontal = "<C-`>"
        }
      })
    end
  }

  -- { "MunifTanjim/nui.nvim" },
  -- { "folke/noice.nvim",
  --   config = function()
  --     require("noice").setup({
  --       cmdline   = { enabled = false },
  --       messages  = { enabled = false },
  --       popupmenu = { enabled = false },
  --       notify    = { enabled = false },
  --       lsp       = {
  --         progress = { enabled = false },
  --         override = {
  --           ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --           ["vim.lsp.util.stylize_markdown"] = true,
  --           ["vim.lsp.util.get_documentation"] = true,
  --         },
  --         signature = {
  --           opts = {
  --             focusable = false,
  --           }
  --         },
  --         documentation = {
  --           opts = {
  --             border = {
  --               padding = {0, 0}
  --             },
  --           }
  --         }
  --       },
  --       -- markdown = {
  --       --   hover = {
  --       --     ["|(%S-)|"] = function(url)
  --       --       vim.cmd("rightbelow | help " .. url)
  --       --     end
  --       --   }
  --       -- },
  --       health    = { checker = false },
  --       presets   = { lsp_doc_border = true },
  --     })
  --   end,
  -- },

  -- load luasnips + cmp related in insert mode only
}

local packer = require("packer")

packer.init({
  auto_clean = true,
  git = { clone_timeout = 60 },
  max_jobs = 30,
  display = {
    working_sym = "ﲊ",
    error_sym = "✗ ",
    done_sym = " ",
    removed_sym = " ",
    moved_sym = "",
    -- prompt_border = "rounded",
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})
-- packer.add(plugins)
packer.startup(function(use)
  for _, plugin in ipairs(plugins) do
    use(plugin)
  end
end)
