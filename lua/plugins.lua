-- List of all default plugins & their definitions

---@type NvPluginSpec
local plugins = {

  -------------------------------------General---------------------------------
  { "nvim-lua/plenary.nvim" },

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
    "NvChad/base46",
    branch = "v2.0",
    priority = 1000,
    init = function()
      vim.g.base46_cache = vim.fn.stdpath("data") .. "/nvchad/base46/"
    end,
    build = function()
      vim.fn.mkdir(vim.g.base46_cache, "p")
      vim.cmd("CompileTheme")
    end,
    config = function()
      dofile(vim.g.base46_cache .. "defaults")
      dofile(vim.g.base46_cache .. "syntax")
      dofile(vim.g.base46_cache .. "devicons")
      dofile(vim.g.base46_cache .. "git")
      require("config.ui")
    end,
  },

  -------------------------------------LSP-------------------------------------
  {
    "neovim/nvim-lspconfig",
    -- lazy = true,
    event = { "UIEnter", "BufReadPre" },
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
    dependencies = {
      { "pmizio/typescript-tools.nvim" },
    },

  },
  {
    "nvimtools/none-ls.nvim",
    lazy = true,
    --module = "null-ls",
    config = function()
      require("null-ls").setup({
        sources = {
          require("null-ls").builtins.formatting.prettierd,
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
  {
    "mfussenegger/nvim-jdtls",
    lazy = true,
  },
  -- { "jose-elias-alvarez/typescript.nvim" },
  -- { "folke/neodev.nvim" },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("trouble").setup()
    end,
  },
  -- { "p00f/clangd_extensions.nvim" },

  -------------------------------------DAP-------------------------------------
  {
    "mfussenegger/nvim-dap",
    --module = "dap",
    ft = { "c", "cpp" },
    config = function()
      require("config.dap").setup()
    end,
  },
  { "theHamsta/nvim-dap-virtual-text" },
  { "rcarriga/nvim-dap-ui" },
  -------------------------------------Tree-sitter-----------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    dev = true,
    -- lazy = true,
    build = ":TSUpdate",
    event = { "BufReadPre" },
    cmd = {
      "TSInstall",
      "TSUninstall",
    },
    config = function()
      require("config.treesitter")
    end,
    dependencies = {

      {
        "lucario387/nvim-ts-format",
        dev = true,
        -- config = function()
        --   vim.api.nvim_create_user_command("TSFormatFile", function()
        --     require("nvim-ts-format.format").format_buf_no_inj()
        --   end, {})
        -- end,
      },
      -- Movement related
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "andymass/vim-matchup" },
      {
        "numToStr/Comment.nvim",
        config = function()
          require("config.misc").Comment()
        end,
      },
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
          require('ts_context_commentstring').setup{
            enable_autocmd = false,
          }
        end,
      },
    },
  },
  --ts misc
  -- { "nvim-treesitter/playground",                  cmd = { "TSPlaygroundToggle", "TSCaptureUnderCursor" } },

  -------------------------------------Completion engine-----------------------
  { "rafamadriz/friendly-snippets" },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-omni" },
      { "windwp/nvim-autopairs" },
      {
        "L3MON4D3/LuaSnip",
        -- disable = true,
        -- dependencies = "nvim-cmp",
        -- event = { "InsertEnter" },
        config = function()
          require("luasnip").config.set_config({
            history = true,
            updateevents = "TextChanged,TextChangedI",
          })
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
      -- { "windwp/nvim-ts-autotag" },
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
    },
    lazy = true,
    config = function()
      require("config.misc").gitsigns()
    end,
  },
  -- {
  --   "NeogitOrg/neogit",
  --   -- lazy = true,
  --   cmd = { "Neogit" },
  --   dependencies = {
  --     "sindrets/diffview.nvim",
  --   },
  --   -- requires = {
  --   --   "lewis6991/gitsigns.nvim",
  --   -- },
  --   config = function()
  --     require("config.misc").neogit()
  --   end,
  -- },

  -------------------------------------Misc------------------------------------
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

  {
    "NvChad/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("colorizer").setup({
        filetypes = { "lua", "vim", "css", "scss", "html", "vue" },
        user_default_options = {
          names = false,
        },
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
    colorscheme = { "nvchad" },
  },

  change_detection = {
    enabled = false,
  },
  ui = {
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
        "rplugin",
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
