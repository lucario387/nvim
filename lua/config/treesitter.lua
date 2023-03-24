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
      -- if vim.list_contains({}, lang) then
      --   return true
      -- end
      local max_filesize = 100 * 1024 -- 100kb
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "g<cr>",
      node_incremental = "<cr>",
      scope_incremental = "<S-CR>",
      node_decremental = "<bs>",
    },
  },
  autotag = { enable = true, },
  matchup = { enable = true, include_match_words = true, },
  context_commentstring = { enable = true, enable_autocmd = false, },
  playground = {
    enable = true,
    disable = {},
    updatetime = 50,
  },
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
    swap = { enable = false, },
    move = { enable = false, },
  },
})
