local telescope = require("telescope")
local actions = require("telescope.actions")
local lga = require("telescope-live-grep-args.actions")
-- vim.cmd("packadd extensions")
-- local function open_qflist(...)
--   vim.cmd("TroubleToggle quickfix")
-- end
-- vim.g.theme_switcher_loaded = true

local function quoted(prompt)
  local str = prompt:gsub('"', '\\"')
  return '"' .. str .. '"'
end

-- mimic https://github.com/nvim-telescope/telescope-live-grep-args.nvim/blob/master/lua/telescope-live-grep-args/actions/quote_prompt.lua
---@param opts {quote_char: string, prefix: string, postfix: string, trim: boolean}
local function quote_prompt(opts)
  local action_state = require("telescope.actions.state")
  local default_opts = {
    prefix = "",
    postfix = " ",
    trim = true,
  }
  opts = vim.tbl_extend("force", default_opts, opts)
  -- quoted = value:gsub(opts.quote_char, "\\" .. opts.quote_char)
  --   return opts.quote_char .. quoted .. opts.quote_char
  ---@param prompt_bufnr integer
  return function(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local prompt = picker:_get_prompt()
    if opts.trim then
      prompt = vim.trim(prompt)
    end
    prompt = opts.prefix .. quoted(prompt) .. opts.postfix
    picker:set_prompt(prompt)
  end
end
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
        height = 16,
        preview_width = 0.5,
        results_width = 0.5,
        prompt_position = "bottom",
        prompt_title = false,
      },
      width = 0.80,
      height = 0.80,
      -- preview_cutoff = 120,
    },
    file_ignore_patterns = { "node_modules/", "LICENSE", "%.git", "book/", "*-lock.json" },
    path_display = { "truncate" },
    winblend = 0,
    -- border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    -- set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
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
          ["<Tab>"] = quote_prompt({
            -- prefix = "-t ",
            trim = true,
            postfix = " \"",
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
