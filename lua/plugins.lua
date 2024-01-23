-- List of all default plugins & their definitions
---@type NvPluginSpec
local plugins = {

  -------------------------------------General---------------------------------
  { "nvim-lua/plenary.nvim" },

  -- Neovim dev
  {
    "neovim/nvimdev.nvim",
    build = {},
    cond = false,
    -- event = { "VeryLazy" },
  },

  -- for managing lsp/formatter
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("config.misc").mason()
    end,
  },

  -------------------------------------Theme-----------------------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    -- lazy = true,
    cond = #vim.api.nvim_list_uis() ~= 0,
    priority = 1000,
    init = function()
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("ReloadTheme", {}),
        pattern = vim.fs.normalize(vim.fn.stdpath("config") .. "/lua/config/catppuccin.lua"),
        callback = function()
          -- require("plenary.reload").reload_module("catppuccin")
          require("plenary.reload").reload_module("config.catppuccin")
          require("config.catppuccin")
          require("config.ui")
        end,
      })
      vim.api.nvim_create_user_command("ThemeEdit", "vsp " .. vim.fn.stdpath("config") .. "/lua/config/catppuccin.lua",
        {})
      vim.g.colors_name = "catppuccin-frappe"
      dofile(vim.fn.stdpath("cache") .. "/" .. string.gsub(vim.g.colors_name, "%-", "/"))
      require("config.ui")
    end,
    -- config = function()
    --   require("config.catppuccin")
    --   require("config.ui")
    -- end,
  },

  -------------------------------------LSP-------------------------------------
  {
    "neovim/nvim-lspconfig",
    -- lazy = true,
    event = { "VeryLazy", "BufReadPre" },
    config = function()
      local utils = require("config.lsp")
      utils.lsp_handlers()
      if not vim.g.lsp or not vim.g.lsp.servers then
        return
      end
      require("lsp-file-operations").setup()
      local on_attach = utils.on_attach
      local capabilities = utils.set_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.util.default_config = vim.tbl_extend(
        'force',
        lspconfig.util.default_config,
        {
          capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            -- returns configured operations if setup() was already called
            -- or default operations if not
            require'lsp-file-operations'.default_capabilities()
          ),
        }
      )

      if vim.g.lsp.servers.default then
        for _, name in ipairs(vim.g.lsp.servers.default) do
          lspconfig[name].setup({
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
    dependencies = {
      { "antosha417/nvim-lsp-file-operations" },
    },

  },
  { "pmizio/typescript-tools.nvim", lazy = true },
  { "yioneko/nvim-vtsls", lazy = true },
  {
    "nvimtools/none-ls.nvim",
    lazy = true,
    --module = "null-ls",
    config = function()
      require("null-ls").setup({
        sources = {
          require("null-ls").builtins.code_actions.gitrebase,
        },
      })
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    --module = "lspsaga",
    cmd = "Lspsaga",
    config = function()
      require("config.misc").lspsaga()
    end,
  },
  -- LSP for specific filetypes
  -- {
  --   "mfussenegger/nvim-jdtls",
  --   lazy = true,
  -- },
  {
    "nvim-java/nvim-java",
    lazy = true,
  },
  -- { "jose-elias-alvarez/typescript.nvim" },
  -- { "folke/neodev.nvim" },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    config = function()
      require("todo-comments").setup()
      vim.keymap.set("n", "]t", function()
        require("todo-comments").jump_next()
      end, { desc = "Next error/warning todo comment" })
      vim.keymap.set("n", "[t", function()
        require("todo-comments").jump_prev()
      end, { desc = "Next error/warning todo comment" })
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      { "<leader>tn", function() require("trouble").next({ jump = true, skip_groups = true }) end, mode = { "n", "x", "o" } },
      { "<leader>tp", function() require("trouble").prev({ jump = true, skip_groups = true }) end, mode = { "n", "x", "o" } },
    },
    config = function()
      require("trouble").setup()
    end,
  },
  -- { "p00f/clangd_extensions.nvim" },
  -- {
  --   "folke/lazydev.nvim",
  --   opts = {
  --     library = {
  --       {
  --         path = "luvit-meta/library",
  --         words = {
  --           "vim%.uv",
  --         },
  --       }
  --     }
  --   },
  --   ft = "lua",
  --   dependencies = {
  --     {
  --       "Bilal2453/luvit-meta",
  --     }
  --   }
  -- },

  -------------------------------------DAP-------------------------------------
  {
    "mfussenegger/nvim-dap",
    --module = "dap",
    ft = { "c", "cpp" },
    dependencies = {
      { "theHamsta/nvim-dap-virtual-text" },
      { "rcarriga/nvim-dap-ui" },
      { "nvim-neotest/nvim-nio" },
    },
    config = function()
      require("config.dap").setup()
    end,
  },
  -------------------------------------Tree-sitter-----------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    -- event = { "FileReadPre", "BufReadPre", "BufNewFile" },
    dev = true,
    -- lazy = true,
    build = ":TSUpdate",
    -- event = { "BufReadPre" },
    cmd = {
      "TSUpdate",
      "TSInstall",
      "TSUninstall",
    },
    dependencies = {
      {
        "lucario387/nvim-ts-format",
        -- event = { "BufReadPre" },
        dev = true,
      },
      -- Movement related
      -- {
      --   "nvim-treesitter/nvim-treesitter-textobjects",
      --   -- event = { "BufReadPre" },
      -- },
      {
        "andymass/vim-matchup",
        -- cond=false,
        
        event = { "BufReadPre" },
      },
      {
        "numToStr/Comment.nvim",
        -- event = { "BufReadPre" },
        config = function()
          require("config.misc").Comment()
        end,
        -- dependencies = {
        -- },
      },
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        -- event = { "BufReadPre" },
        config = function()
          require('ts_context_commentstring').setup{
            enable_autocmd = false,
          }
        end,
      },

    },
    config = function()
      require("config.treesitter")
    end,
    -- dependencies = {
    -- },
  },

  --ts misc
  -- { "nvim-treesitter/playground",                  cmd = { "TSPlaygroundToggle", "TSCaptureUnderCursor" } },

  -------------------------------------Completion engine-----------------------
  { "rafamadriz/friendly-snippets" },
  {
    -- "hrsh7th/nvim-cmp",
    "iguanacucumber/magazine.nvim",
    name = "nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { url = "https://codeberg.org/FelipeLema/cmp-async-path" },
      { "hrsh7th/cmp-omni" },
      { "windwp/nvim-autopairs" },
      {
        "L3MON4D3/LuaSnip",
        -- disable = true,
        -- dependencies = "nvim-cmp",
        -- event = { "InsertEnter" },
        build = "make install_jsregexp",
        config = function()
          require("luasnip").config.set_config({
            history = true,
            updateevents = "TextChanged,TextChangedI",
          })
          require("luasnip").filetype_extend("markdown", { "license" })
          require("luasnip").filetype_extend("text", { "license" })
          require("luasnip.loaders.from_vscode").lazy_load()
          -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.g.luasnippets_path } })

          vim.api.nvim_create_autocmd({ "ModeChanged" }, {
            pattern = { "s:n", "i:*" },
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
      -- {
      --   "windwp/nvim-ts-autotag",
      --   config = function (_, _)
      --     require("nvim-ts-autotag").setup()
      --   end
      -- },
    },
    config = function()
      require("config.cmp")
      -- autopairs as well, as autopairs has no reason to not be loaded on startup
      local autopairs = require("nvim-autopairs")
      -- local Rule = require("nvim-autopairs.rule")
      autopairs.setup({
        fast_wrap = {},
        disable_filetype = { "TelescopePrompt", "vim", "query" },
      })

      require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

      -- autopairs.add_rules({
      --   Rule("%<%>$", "</>", { "typescript", "typescriptreact", "javascript", "javascriptreact" })
      --     :use_regex(true),
      -- })
    end,
  },


  -- { "hrsh7th/cmp-cmdline",         requires = "nvim-cmp" },
  -- { "f3fora/cmp-spell", requires = "nvim-cmp" },
  -------------------------------------Telescope-------------------------------
  {
    "nvim-telescope/telescope.nvim",
    --module = "telescope",
    cmd = "Telescope",
    event = { "CmdlineEnter" },
    config = function()
      require("config.telescope")
    end,
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim",    build = "make" },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      -- { "nvim-telescope/telescope-frecency.nvim" },
    },
  },

  -------------------------------------Git-------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      {
        "sindrets/diffview.nvim",
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
      {
        "NeogitOrg/neogit",
        -- branch = "nightly",
        -- lazy = true,
        cmd = { "Neogit" },
        -- dependencies = {
        --   "sindrets/diffview.nvim",
        -- },
        -- requires = {
        --   "lewis6991/gitsigns.nvim",
        -- },
        config = function()
          require("config.misc").neogit()
        end,
      },
    },
    lazy = true,
    config = function()
      require("config.misc").gitsigns()
    end,
  },
  -- {
  --   "pwntester/octo.nvim",
  --   cmd = { "GitHub", "Octo" },
  --   config = function()
  --     local colors = require("catppuccin.palettes").get_palette("frappe")
  --     require("octo").setup({
  --       default_merge_method = "rebase",
  --     })
  --   end,
  -- },

  -------------------------------------Misc------------------------------------
  -- {
  --   "mg979/vim-visual-multi",
  --   event = "VeryLazy",
  -- },

  -- {
  --   "andweeb/presence.nvim",
  --   cond = false,
  --   -- event = "VeryLazy",
  --   config = function()
  --     vim.g.presence_log_level = nil
  --     require("presence").setup({
  --       auto_update = true,
  --       main_image = "file",
  --       blacklist = {
  --         "/work",
  --       },
  --       workspace_text = "Gliding on %s",
  --       buttons = true,
  --       enable_line_number = false,
  --       show_time = false,
  --     })
  --   end,
  -- },
  {
    "3rd/image.nvim",
    event = "VeryLazy",
    init = function ()
      local basepath = vim.env.HOME .. "/.luarocks/share/lua/5.1"
      package.path = package.path .. ";" .. basepath .. "/?.lua;" .. basepath .. "/?/init.lua"
    end,
    config = function ()
      require("image").setup({
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = {
              "markdown",
              "vimwiki",
              "quarto",
            }
          }
        },
        max_height_window_percentage = 40,
        kitty_method = "normal",
      })
    end
  },
  {
    "LunarVim/bigfile.nvim",
    -- event = { "FileReadPre", "BufReadPre" },
    config = function(_, _)
      require("bigfile").setup()
    end,
  },
  { "lervag/vimtex" },
  {
    "tweekmonster/helpful.vim",
    cmd = { "HelpfulVersion" },
    ft = { "help" },
  },
  { "nvim-tree/nvim-web-devicons" },
  -- tree plugin
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeClose" },
    config = function()
      require("config.misc")["nvim-tree"]()
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("config.misc")["indent-blankline"]()
    end,
  },

  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   event = "BufRead",
  --   config = function()
  --     require("colorizer").setup({
  --       filetypes = { "lua", "vim", "css", "scss", "html", "vue" },
  --       user_default_options = {
  --         names = false,
  --       },
  --     })
  --   end,
  -- },

  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufRead" },
    config = function()
      require("nvim-highlight-colors").setup({
        enable_tailwind = true,
      })
    end,
  },

  {
    "folke/noice.nvim",
    cond = false,
    event = "VeryLazy",
    dependencies = {
      { "MunifTanjim/nui.nvim" },
    },
    config = function()
      require("config.misc").noice()
    end,
  },
  {
    "folke/flash.nvim",
    cond = false,
    event = "VeryLazy",
    config = function(_, opts)
      require("flash").setup({
        search = {
          incremental = true,
        },
      })
      vim.keymap.set({ "n", "x", "o" }, "s", function()
        require("flash").jump()
      end, { desc = "Flash Search" })
      vim.keymap.set({ "n", "x", "o" }, "S", function()
        require("flash").treesitter()
      end, { desc = "Flash Treesitter Search" })
      vim.keymap.set("o", "r", function()
        require("flash").remote()
      end, { desc = "Flash Remote" })
      vim.keymap.set({ "x", "o" }, "R", function()
        require("flash").treesitter_search()
      end, { desc = "Treesitter Search" })
      vim.keymap.set("c", "<C-s>", function()
        require("flash").toggle()
      end, { desc = "Toggle Flash Search" })
    end,
  },
  -- {
  --   "mg979/vim-visual-multi",
  --   init = function()
  --     vim.g.VM_leader = " "
  --   end
  -- },
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    init = function() -- Hide the (real) cursor when leaping, and restore it afterwards.
      vim.api.nvim_create_autocmd('User', {
        pattern = 'LeapEnter',
        callback = function()
          vim.cmd.hi('Cursor', 'blend=100')
          vim.opt.guicursor:append{ 'a:Cursor/lCursor' }
        end,
      }
      )
      vim.api.nvim_create_autocmd('User', {
        pattern = 'LeapLeave',
        callback = function()
          vim.cmd.hi('Cursor', 'blend=0')
          vim.opt.guicursor:remove{ 'a:Cursor/lCursor' }
        end,
      }
      )
    end,
    config = function(_, _)
      require("leap").create_default_mappings()
    end,
    dependencies = {
      {
        "ggandor/flit.nvim",
        config = function(_, _)
          require("flit").setup()
        end,
      },
      {
        "tpope/vim-repeat",
      },
    },
  },


  {
    "Pocco81/true-zen.nvim",
    cmd = { "TZAtaraxis" },
    config = function()
      require("true-zen").setup({})
    end,
  },
  -- load luasnips + cmp related in insert mode only
}

require("lazy").setup(plugins, {
  install = {
    missing = false,
    -- colorscheme = { "nvchad" },
  },

  rocks = {
    hererocks = true,
  },
  change_detection = {
    enabled = false,
  },
  ui = {
    backdrop = 100,
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
  },
  dev = {
    path = vim.env.HOME .. "/dev",
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      path = {
        vim.fn.stdpath("data") .. "/site",
      },
      disabled_plugins = {
        "2html_plugin",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "matchparen",
        "tar",
        "tarPlugin",
        "tohtml",
        "rrhelper",
        "spellfile_plugin",
        -- "vimball",
        -- "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        -- "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
        "matchparen",
        "fzf",
      },
    },
  },
})
