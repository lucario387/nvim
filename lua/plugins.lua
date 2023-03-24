-- List of all default plugins & their definitions

local plugins = {

  -------------------------------------General---------------------------------
  {
    "wbthomason/packer.nvim",
    branch = "master",
  },
  { "nvim-lua/plenary.nvim" },

  -- for managing lsp/formatter
  {
    "williamboman/mason.nvim",
    run = ":MasonUpdate",
  },

  -------------------------------------Theme-----------------------------------
  {
    "NvChad/base46",
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
  },
  {
    "glepnir/lspsaga.nvim",
    module = "lspsaga",
    cmd = "Lspsaga",
    config = function()
      require("config.misc").lspsaga()
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    module = "null-ls",
    config = function()
      require("null-ls").setup({
        sources = {
          require("null-ls").builtins.formatting.prettierd,
        },
      })
    end,
  },
  -- LSP for specific filetypes
  {
    "mfussenegger/nvim-jdtls",
    opt = true,
  },
  { "jose-elias-alvarez/typescript.nvim" },
  { "folke/neodev.nvim" },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("trouble").setup()
    end,
  },

  -------------------------------------DAP-------------------------------------
  {
    "mfussenegger/nvim-dap",
    module = "dap",
    ft = { "c", "cpp" },
    config = function()
      require("config.dap").setup()
    end,
  },
  { "theHamsta/nvim-dap-virtual-text" },
  { "rcarriga/nvim-dap-ui" },
  -------------------------------------Tree-sitter-----------------------------
  {
    "~/dev/nvim-treesitter",
    -- opt = true,
    run = ":TSUpdate",
    -- event = "BufReadPre",
  },
  -- Movement related
  { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufRead" },
  { "andymass/vim-matchup",                        event = "BufRead" },
  --ts misc
  { "windwp/nvim-ts-autotag",                      event = "InsertEnter" },
  { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufRead" },
  { "nvim-treesitter/playground",                  cmd = { "TSPlaygroundToggle", "TSCaptureUnderCursor" } },
  {
    "numToStr/Comment.nvim",
    after = "nvim-ts-context-commentstring",
    config = function()
      require("config.misc").Comment()
    end,
  },

  -------------------------------------Completion engine-----------------------
  { "rafamadriz/friendly-snippets" },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
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

  { "saadparwaiz1/cmp_luasnip",    after = "nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp",        after = "nvim-cmp" },
  { "hrsh7th/cmp-buffer",          after = "nvim-cmp" },
  { "hrsh7th/cmp-path",            after = "nvim-cmp" },

  {
    "L3MON4D3/LuaSnip",
    -- disable = true,
    -- after = "nvim-cmp",
    event = { "InsertEnter" },
    config = function()
      require("luasnip").config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
      })
      require("luasnip.loaders.from_vscode").lazy_load()
      -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.g.luasnippets_path } })

      vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        callback = function()
          -- if
          --   require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
          --   and not require("luasnip").session.jump_active
          -- then
          require("luasnip").unlink_current()
          -- end
        end,
      })
    end,
  },

  -- { "hrsh7th/cmp-cmdline",         requires = "nvim-cmp" },
  -- { "f3fora/cmp-spell", requires = "nvim-cmp" },

  { "windwp/nvim-autopairs" },
  -------------------------------------Telescope-------------------------------
  {
    "nvim-telescope/telescope.nvim",
    module = "telescope",
    cmd = "Telescope",
    config = function()
      require("config.telescope")
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },

  -------------------------------------Git-------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    opt = true,
    config = function()
      require("config.misc").gitsigns()
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
    event = "BufReadPre",
    config = function()
      require("colorizer").setup({
        filetypes = { "lua", "vim", "css", "scss", "html", "vue" },
      })
    end,
  },

  { "MunifTanjim/nui.nvim" },
  { "folke/noice.nvim" },

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
