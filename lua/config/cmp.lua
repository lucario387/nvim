local cmp = require("cmp")
pcall(function() dofile(vim.g.base46_cache .. "cmp") end)

local ELLIPSIS_CHAR = "…"
local MAX_LABEL_WIDTH = 40
local icons = require("config.ui.icons").lspkind
local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

-- local has_words_before = function()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

local disabled_buftypes = {
  "terminal",
  -- "nofile",
  "prompt",
}

local disabled_filetypes = {
  "markdown",
  "rst",
  "gitcommit",
}

local menu = {
  nvim_lsp = "(LSP)",
  buffer = "(Buf)",
  dap = "(Dap)",
  cmdline = "(Cmd)",
  path = "(Path)",
  luasnip = "(Snip)",
  neorg = "(Norg)",
  spell = "Spell",
}

local is_dap_buffer = function(bufnr)
  local filetype = vim.api.nvim_buf_get_option(bufnr or 0, "filetype")
  if filetype == "dap-repl" or vim.startswith(filetype, "dapui_") then
    return true
  end
  return false
end

cmp.setup({
  matching = {
    disallow_partial_fuzzy_matching = false,
  },
  -- completion = {
  --   keyword_length = 2,
  --   -- autocomplete = false,
  -- },
  enabled = function()
    local disabled = false
    disabled = disabled or is_dap_buffer(0)
    disabled = disabled or (vim.tbl_contains(disabled_buftypes, vim.api.nvim_buf_get_option(0, "buftype")))
    disabled = disabled or (vim.fn.reg_recording() ~= "")
    disabled = disabled or (vim.fn.reg_executing() ~= "")
    if disabled then
      return not disabled
    end

    -- local context = require("cmp.config.context")
    return true
    -- keep command mode completion enabled when cursor is in a comment
    -- if vim.api.nvim_get_mode().mode == "c" then
    --   return true
    -- else
    --   return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
    -- end
  end,
  window = {
    completion = {
      border = border("CmpBorder"),
      winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
      side_padding = 0,
      scrollbar = true,
    },
    documentation = {
      border = border("CmpDocBorder"),
    },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
        -- elseif has_words_before() then
        --   cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable( -1) then
        require("luasnip").jump( -1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-d>"] = cmp.mapping.scroll_docs( -4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<CR>"] = cmp.mapping.confirm({ select = false, })
  }),
  formatting = {
    -- fields = { "abbr", "menu", "kind" },
    fields = { "abbr", "kind", "menu" },
    format = function(entry, vim_item)
      -- vim_item.menu = menu[entry.source.name]
      vim_item.kind = string.format("%s%s", icons[vim_item.kind], vim_item.kind)
      -- vim_item.kind = string.format("%s", icons[vim_item.kind])
      if #vim_item.abbr > MAX_LABEL_WIDTH then
        vim_item.abbr = string.sub(vim_item.abbr, 1, MAX_LABEL_WIDTH - 1) .. ELLIPSIS_CHAR
      end
      return vim_item
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip", keyword_length = 4, max_item_count = 20 },
    { name = "path" },
    {
      name = "buffer",
      keyword_length = 5,
      entry_filter = function()
        return not require("cmp.config.context").in_treesitter_capture({ "spell", "comment" }) and
          not vim.tbl_contains(disabled_filetypes, vim.api.nvim_buf_get_option(0, "filetype"))
      end,
    },
    -- { name = "spell",
    --   option = {
    --     keep_all_entries = true,
    --     enable_in_context = function()
    --       return require("cmp.config.context").in_treesitter_capture("spell")
    --     end
    --   }
    -- }
  }),
})

-- cmp.setup.cmdline("/", {
--   completion = {
--     autocomplete = false,
--   },
--   mapping = cmp.mapping.preset.cmdline({
--     ["<Tab>"] = {
--       c = function()
--         if cmp.visible() then
--           cmp.select_next_item()
--         else
--           cmp.complete()
--           cmp.select_next_item()
--         end
--       end
--     },
--     ["<S-Tab>"] = {
--       c = function()
--         if cmp.visible() then
--           cmp.select_prev_item()
--         else
--           cmp.complete()
--           cmp.select_prev_item()
--         end
--       end
--     }
--   }),
--   sources = {
--     { name = "buffer" },
--   },
-- })
--
-- cmp.setup.cmdline(":", {
--   completion = {
--     autocomplete = false,
--   },
--   mapping = cmp.mapping.preset.cmdline({
--     ["<Tab>"] = {
--       c = function()
--         if cmp.visible() then
--           cmp.select_next_item()
--         else
--           cmp.complete()
--           cmp.select_next_item()
--         end
--       end
--     },
--     ["<S-Tab>"] = {
--       c = function()
--         if cmp.visible() then
--           cmp.select_prev_item()
--         else
--           cmp.complete()
--           cmp.select_prev_item()
--         end
--       end
--     }
--   }),
--   sources = {
--     { name = "path" },
--     {
--       name = "cmdline",
--       option = {
--         ignore_cmds = { "Man", "!" },
--       },
--     },
--   },
-- })
-- cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
--   sources = {
--     { name = "dap" },
--   },
-- })
