local telescope = require("telescope")
local actions = require("telescope.actions")
local lga = require("telescope-live-grep-args.actions")
-- vim.cmd("packadd extensions")
-- local function open_qflist(...)
--   vim.cmd("TroubleToggle quickfix")
-- end
-- vim.g.theme_switcher_loaded = true
telescope.setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--follow",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim",
    },
    prompt_prefix = "   ",
    prompt_title = false,
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    -- preview = {
    --   treesitter = false,
    -- },
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      bottom_pane = {
        height = 15,
        preview_width = 0.5,
        results_width = 0.5,
        prompt_position = "bottom",
        prompt_title = false,
      },
      width = 0.80,
      height = 0.80,
      -- preview_cutoff = 120,
    },
    file_ignore_patterns = { "node_modules/", "LICENSE", "%.git",  "book/", "*-lock.json" },
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    mappings = {
      n = {
        ["q"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<C-q>"] = function(...)
          actions.send_to_qflist(...)
          vim.cmd("Trouble quickfix")
        end,
      },
      i = {
        ["<C-c>"] = { "<Esc>", type = "command" },
        ["<C-q>"] = function(...)
          actions.send_to_qflist(...)
          vim.cmd("Trouble quickfix")
        end,
        -- ["<CR>"] = function(...)
        --   vim.api.nvim_feedkeys(vim.keycode("<Esc>"), 'i', false)
        --   actions.select_default(...)
        -- end,
        -- ["<C-x>"] = function(...)
        --   vim.api.nvim_feedkeys(vim.keycode("<Esc>"), 'i', false)
        --   actions.select_horizontal(...)
        -- end,
        -- ["<C-v>"] = function(...)
        --   vim.api.nvim_feedkeys(vim.keycode("<Esc>"), 'i', false)
        --   actions.select_vertical(...)
        -- end,
        -- ["<C-t>"] = function(...)
        --   vim.api.nvim_feedkeys(vim.keycode("<Esc>"), 'i', false)
        --   actions.select_tab(...)
        -- end,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i = {
          -- ["<C-k>"] = lga.quote_prompt(),
          ["<Tab>"] = lga.quote_prompt({
            postfix = "-t",
          }),
        },
      },
    },
  },
})
local extensions = {
  "fzf",
  "ui-select",
  "live_grep_args",
}
for _, ext in pairs(extensions) do
  telescope.load_extension(ext)
end
