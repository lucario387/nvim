return {
  --------------Removed plugins-----------------------------
  ["folke/which-key.nvim"] = false,
  ["goolord/alpha-nvim"] = false,
  ["NvChad/nvterm"] = false,
  ["NvChad/ui"] = false,
  ["hrsh7th/cmp-nvim-lua"] = false,
  ["kyazdani42/nvim-tree.lua"] = false,
  ["kyazdani42/nvim-web-devicons"] = false,
  ["nvim-treesitter/nvim-treesitter"] = false,
  -- ["windwp/nvim-autopairs"] = false,
  ----------------------------------------------------------
  --------------Plugins not in NvChad-----------------------
  -- General
  -- Treesitter related stuffs
  ["andymass/vim-matchup"] = {
    event = "BufRead",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        parser_install_dir = vim.fn.stdpath("data") .. "/site",
        matchup = {
          enable = true,
          include_match_words = true,
        },
      })
    end,
  },

  ["windwp/nvim-ts-autotag"] = {
    event = "InsertEnter",
    -- disable = true,
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        parser_install_dir = vim.fn.stdpath("data") .. "/site",
        autotag = {
          enable = true,
        },
      })
    end,
  },
  ["JoosepAlviste/nvim-ts-context-commentstring"] = {
    event = "BufRead",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        parser_install_dir = vim.fn.stdpath("data") .. "/site",
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      })
    end,
  },
  ["nvim-treesitter/playground"] = {
    cmd = { "TSPlaygroundToggle", "TSCaptureUnderCursor" },
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        parser_install_dir = vim.fn.stdpath("data") .. "/site",
        playground = {
          enable = true,
          disable = {},
          updatetime = 50,
        },
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { "BufRead", "CursorHold" },
        },
      })
    end,
  },
  -- ["kylechui/nvim-surround"] = {
  --   event = "BufRead",
  --   config = function()
  --     require("nvim-surround").setup()
  --   end
  -- },
  -- ["nvim-treesitter/nvim-treesitter-textobjects"] = { },
  -- Extras for LSP
  ["glepnir/lspsaga.nvim"] = {
    -- after = "null-ls.nvim",
    module = "lspsaga",
    config = function()
      require("lspsaga").setup({
        ui = {
          border = "rounded",
        },
        diagnostic = {
          keys = {
            exec_action = "<CR>",
          },
        },
        max_preview_lines = 300,
        lightbulb = {
          enable = false,
        },
        symbol_in_winbar = {
          enable = false,
        },
      })
    end,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    module = "null-ls",
    config = function()
      require("null-ls").setup({
        debug = false,
        on_attach = function(client, bufnr)
          require("custom.plugins.lsp").on_attach(client, bufnr)
        end,
        border = "rounded",
      })
    end,
  },
  -- LSP for specific filetypes
  ["mfussenegger/nvim-jdtls"] = {
    opt = true,
  },
  ["jose-elias-alvarez/typescript.nvim"] = {},
  -- ["p00f/clangd_extensions.nvim"] = {
  --   opt = false,
  --   setup = function()
  --     vim.g.loaded_clangd_ext = true
  --   end
  -- },
  -- fzf for telescope
  ["nvim-telescope/telescope-fzf-native.nvim"] = { run = "make" },
  -- Entirety of Nvim-Dap
  ["mfussenegger/nvim-dap"] = {
    module = "dap",
    ft = { "c", "cpp" },
    config = function()
      require("custom.plugins.dap").setup()
    end,
    -- setup = function()
    --   require("core.utils").load_mappings("dap")
    -- end
  },
  ["rcarriga/cmp-dap"] = {
    after = "nvim-dap",
    config = function()
      require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        },
      })
    end,
  },
  ["theHamsta/nvim-dap-virtual-text"] = {
    after = "nvim-dap",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  ["rcarriga/nvim-dap-ui"] = {
    after = "nvim-dap",
    config = function()
      require("custom.plugins.dap.ui")
    end,
  },

  ["nvim-tree/nvim-web-devicons"] = {},
  ["nvim-tree/nvim-tree.lua"] = {
    cmd = { "NvimTreeToggle", "NvimTreeClose" },
    config = function()
      loadfile(vim.g.base46_cache .. "nvimtree", "b")()
      require("nvim-tree").setup({
        filters = {
          dotfiles = true,
          custom = {
            "node_modules",
            "%.git",
            "%.github",
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
        ignore_ft_on_setup = { "alpha", "dashboard", "aerial", "mind" },
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
            padding = "",
          },
        },
      })
    end,
    setup = function()
      vim.keymap.set("n", "<C-n>", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
    end,
  },
  -- Git?
  ["sindrets/diffview.nvim"] = {
    after = "gitsigns.nvim",
    config = function()
      require("core.utils").load_mappings("diff")
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
  -- Eye candy
  ["MunifTanjim/nui.nvim"] = {},
  ["folke/noice.nvim"] = {
    config = function()
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
            ["vim.lsp.util.get_documentation"] = false,
          }
        },
        health    = { checker = false, },
        presets   = { lsp_doc_border = true, }
      })
    end,
  },
  --------------Plugins in NvChad---------------------------

  ["NvChad/base46"] = {
    rm_default_opts = true,
    lock = true, -- Maybe we will return to v2.0 someday, not sure
    -- run = ":CompileNvTheme",
    module = "base46",
    branch = "dev",
    commit = "1f353132de22be592ae49f7b57eeb1a21bd8a3a3",
    -- rm_default_opts = true
  },
  ["NvChad/extensions"] = {
    rm_default_opts = true,
    lock = true, -- Maybe we will return to v2.0 someday, not sure
    commit = "3920c4764b57b972e7308ede2ee33f1d03252cbb",
    -- lock = true,
  },
  ["lewis6991/gitsigns.nvim"] = {
    rm_default_opts = true,
    opt = true,
    config = function()
      loadfile(vim.g.base46_cache .. "git")()
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
          require("core.utils").load_mappings("gitsigns", { buffer = bufnr })
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
            -- vim.schedule(function()
            require("packer").loader("gitsigns.nvim")
            -- end)
          end
        end,
      })
    end,
  },
  ["wbthomason/packer.nvim"] = {
    cmd = { "PackerSync", "PackerLoad", "PackerStatus", "PackerCompile" },
  },
  ["nvim-lua/plenary.nvim"] = { rm_default_opts = true },
  ["williamboman/mason.nvim"] = {
    rm_default_opts = true,
    cmd = "Mason",
    config = function()
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
    end,
  },
  ["lukas-reineke/indent-blankline.nvim"] = {
    rm_default_opts = true,
    event = "BufRead",
    config = function()
      loadfile(vim.g.base46_cache .. "blankline", "b")()
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
    -- disable = true
  },
  ["neovim/nvim-lspconfig"] = {
    rm_default_opts = true,
    -- config = function()
    -- end
  },
  ["rafamadriz/friendly-snippets"] = {
    rm_default_opts = true,
    -- event = "InsertEnter",
    -- keys = { ":", "/" },
  },
  ["hrsh7th/nvim-cmp"] = {
    rm_default_opts = true,
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      require("custom.plugins.cmp")
    end,
  },
  ["L3MON4D3/LuaSnip"] = {
    rm_default_opts = true,
    -- disable = true,
    after = "nvim-cmp",
    config = function()
      require("luasnip").config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
      })
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.g.luasnippets_path } })

      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if  require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
          and not require("luasnip").session.jump_active
          then
            require("luasnip").unlink_current()
          end
        end,
      })
    end,
  },
  ["saadparwaiz1/cmp_luasnip"] = { after = "nvim-cmp" },
  ["hrsh7th/cmp-nvim-lsp"] = { after = "nvim-cmp" },
  ["hrsh7th/cmp-buffer"] = { after = "nvim-cmp" },
  ["hrsh7th/cmp-path"] = { after = "nvim-cmp" },
  -- ["hrsh7th/cmp-cmdline"] = { after = "nvim-cmp" },
  ["windwp/nvim-autopairs"] = {
    rm_default_opts = true,
    disable = false,
    after = "nvim-cmp",
    -- event = "InsertEnter",
    config = function()
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
  ["nvim-telescope/telescope.nvim"] = {
    rm_default_opts = true,
    -- after = "telescope-fzf-native.nvim",
    module = "telescope",
    cmd = { "Telescope" },
    config = function()
      require("custom.plugins.telescope")
    end,
    setup = function()
      require("core.utils").load_mappings("telescope")
    end,
  },

  ["NvChad/nvim-colorizer.lua"] = {
    rm_default_opts = true,
    event = "BufReadPre",
    config = function()
      require("colorizer").setup({
        filetypes = {
          "lua",
          "vim",
          "vue",
          "tsx",
          "js",
          "html",
          "css",
          "scss",
          "xml",
          "TelescopeResults",
        },
        user_default_options = {
          RGB = false, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = true, -- "Name" codes like Blue or blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          AARRGGBB = false, -- 0xAARRGGBB hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = "background", -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = false, -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          virtualtext = "■",
        },
      })
    end,
  },
  ["numToStr/Comment.nvim"] = {
    rm_default_opts = true,
    after = "nvim-ts-context-commentstring",
    config = function()
      require("core.utils").load_mappings("comment")
      require("Comment").setup({
        mappings = {
          basic = false,
          extra = false,
        },
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
  ["/home/lucario387/.nvchad/config/nvim-treesitter"] = {
    rm_default_opts = true,
    run = ":TSUpdate",
    config = function() require("custom.plugins.treesitter") end,
  },
  --------------Plugins in NvChad ends here------------------
}
