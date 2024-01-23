local list_contains = vim.list_contains or vim.tbl_contains
vim.o.foldmethod = "expr"
-- or
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.o.foldcolumn = "1"
vim.o.foldlevelstart = 99
-- vim.o.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.o.foldenable = false
vim.o.foldtext = ""
require("nvim-treesitter.configs").setup({
  auto_install = true,
  parser_install_dir = vim.fn.stdpath("data") .. "/site",
  ensure_installed = { "vim", "lua", "c", "vimdoc", "python", "markdown", "markdown_inline" },
  ignore_install = {
    "latex",
  },
  highlight = {
    enable = true,
    disable = function(lang, bufnr)
      -- if list_contains({}, lang) then
      --   return true
      -- end
      local max_filesize = 200 * 1024 -- 200kb
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-Space>",
      node_incremental = "<C-Space>",
      scope_incremental = "<S-CR>",
      node_decremental = "<bs>",
    },
  },
  -- autotag = {
  --   enable = true,
  --   enable_rename = true,
  --   enable_close = true,
  --   enable_close_on_slash = true,
  -- },
  matchup = {
    enable = true,
    -- disable = { "perl" },
    include_match_words = true,
  },
  -- context_commentstring = { enable = true, enable_autocmd = false, },
  -- playground = {
  --   enable = true,
  --   disable = {},
  --   updatetime = 50,
  -- },
  query_linter = {
    enable = false,
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
    swap = { enable = false },
    move = { enable = false },
  },
})

local parser = require("nvim-treesitter.parsers").get_parser_configs()
parser.dart = {
  install_info = {
    url = "https://github.com/UserNobody14/tree-sitter-dart",
    files = { "src/parser.c", "src/scanner.c" },
    revision = "8aa8ab977647da2d4dcfb8c4726341bee26fbce4",
  },
  maintainers = { "@akinsho" },
}
parser.vue = {
  install_info = {
    url = "https://github.com/tree-sitter-grammars/tree-sitter-vue",
    branch = "v2",
    files = { "src/parser.c", "src/scanner.c" },
    revision = "085e99bcc46b2e63ff06a830a31a55132ce95aa5",
  }
}
-- vim.treesitter.language.register("bash", "zsh")
-- vim.api.nvim_create_user_command("TSPlaygroundToggle", "<cmd>InspectTree<CR>")

vim.treesitter.language.register("json", { "chart" })
vim.treesitter.language.register("bash", { "zsh" })
vim.treesitter.language.register("diff", { "suggestion" })
