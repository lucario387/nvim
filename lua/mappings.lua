---@type table<string, fun(bufnr?: integer)>
local M = {}

-- local set = vim.keymap.set

--- Use for null-ls and lsp
M.null_ls = function(bufnr)
  vim.keymap.set({ "n", "x" }, "<leader>fm", function()
    vim.lsp.buf.format({
      async = true,
    })
  end, { desc = "LSP format", buffer = bufnr })
  vim.keymap.set({ "n", "x" }, "<leader>ca", function()
    if not package.loaded["telescope"] then
      require("lazy.core.loader").load({ "telescope.nvim" }, {})
    end
    vim.lsp.buf.code_action()
    -- vim.cmd.Lspsaga("code_action")
    -- require("lspsaga.codeaction"):code_action()
  end, { desc = "code action", buffer = bufnr })
end

M.general = function()
  vim.keymap.set("n", "<C-b>", function()
    vim.cmd.NvimTreeToggle()
  end, { desc = "Toggle NvimTree" })
  -- vim.keymap.set("n", "<C-n>", vim.cmd.cnext, { desc = "Jump to next quickfix" })
  -- vim.keymap.set("n", "<C-p>", vim.cmd.cprevious, { desc = "Jump to prev quickfix" })
  --- Normal mode
  vim.keymap.set("n", "<ESC>", "<cmd>noh<CR>", { desc = "no highlight" })

  -- switch between windows
  vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "window left" })
  vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "window right" })
  vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "window down" })
  vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "window up" })
  -- vim.keymap.set("n", "o", "A<Enter>", {})
  
  -- View cursor line: Open just enough folds to make the line in
  -- which the cursor is located not folded.
  vim.keymap.set({"n", "x" }, "n", "nzzzv", { desc = "see :h zv"})



  -- save
  vim.keymap.set({ "n", "i" }, "<C-s>", function() vim.cmd.write() end, { desc = "save file" })

  -- Copy all
  vim.keymap.set("n", "<C-c>", "<cmd> %y+ <CR>", { desc = "copy whole file" })

  vim.keymap.set("n", "dw", '"_dw', { desc = "" })
  vim.keymap.set("n", "db", '"_db', { desc = "" })
  vim.keymap.set("n", "cw", '"_cw', { desc = "" })
  vim.keymap.set("n", "cb", '"_cb', { desc = "" })
  vim.keymap.set({ "n", "x" }, "<C-d>", "<C-d>zz", { desc = "" })
  vim.keymap.set({ "n", "x" }, "<C-u>", "<C-u>zz", { desc = "" })
  vim.keymap.set({ "n", "x" }, "n", "nzz", { desc = "" })
  vim.keymap.set({ "n", "x" }, "N", "Nzz", { desc = "" })
  vim.keymap.set("n", "<C-c>", "<cmd>%y+<CR>", { silent = true })
  vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "" })
  vim.keymap.set("n", "<A-j>", "<cmd>m+1<CR>==", { desc = "" })
  vim.keymap.set("n", "<A-k>", "<cmd>m-2<CR>==", { desc = "" })

  vim.keymap.set("n", "<C-->", "<C-w>2-", { desc = "" })
  vim.keymap.set("n", "<C-=>", "<C-w>2+", { desc = "" })
  vim.keymap.set("n", "<C-.>", "<C-w>2>", { desc = "" })
  vim.keymap.set("n", "<C-,>", "<C-w>2<", { desc = "" })

  vim.keymap.set("n", "<leader>tt", function()
    vim.cmd.colorscheme(vim.g.colors_name == "catppuccin-latte" and "catppuccin-mocha" or "catppuccin-latte")
  end, { desc = "toggle theme" })

  vim.keymap.set("n", "a", function()
    local line = #vim.trim(vim.fn.getline("."))
    vim.api.nvim_feedkeys(line >= 1 and "a" or [["_cc]], "n", true)
  end, { desc = "auto indent when enter insert on empty line", expr = true })
  vim.keymap.set("n", "i", function()
    local line = #vim.trim(vim.fn.getline("."))
    vim.api.nvim_feedkeys(line >= 1 and "i" or [["_cc]], "n", true)
  end, { desc = "auto indent when enter insert on empty line", expr = true })
  vim.keymap.set("n", "A", function()
    local line = #vim.trim(vim.fn.getline("."))
    vim.api.nvim_feedkeys(line >= 1 and "A" or [["_cc]], "n", true)
  end, { desc = "auto indent when enter insert on empty line", expr = true })
  vim.keymap.set("n", "I", function()
    local line = #vim.trim(vim.fn.getline("."))
    vim.api.nvim_feedkeys(line >= 1 and "I" or [["_cc]], "n", true)
  end, { desc = "auto indent when enter insert on empty line" })

  vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = false })
  vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y', { noremap = false })
  vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { noremap = false })
  vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { noremap = false })
  vim.keymap.set("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Don't copy replaced text" })

  --- Insert mode
  -- Emacs keybind kek
  vim.keymap.set("i", "<C-a>", function()
    local cur_line = vim.fn.line(".")
    vim.api.nvim_win_set_cursor(0, { cur_line, vim.fn.indent(cur_line) })
  end, { desc = "to start of line" })
  vim.keymap.set("i", "<C-e>", "<End>", { desc = "to eol" })
  vim.keymap.set("i", "<C-f>", "<C-Right>", { desc = "next word" })
  vim.keymap.set("i", "<C-b>", "<C-Left>", { desc = "last word" })
  vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "better escape :')" })
  -- navigate within insert mode
  vim.keymap.set("i", "<C-h>", "<Left>", { desc = "move left" })
  vim.keymap.set("i", "<C-l>", "<Right>", { desc = "move right" })
  vim.keymap.set("i", "<C-j>", "<Down>", { desc = "move down" })
  vim.keymap.set("i", "<C-k>", "<Up>", { desc = "move up" })

  vim.keymap.set("i", "<A-j>", "<Esc><cmd>m+1<CR>==a", { desc = "" })
  vim.keymap.set("i", "<A-k>", "<Esc><cmd>m-2<CR>==a", { desc = "" })
  -- vim.keymap.set("i", "<C-A-v>", "<Esc><cmd>PasteImg<CR>", { desc = "" })

  --- Visual mode

  vim.keymap.set({ "n", "x" }, "x", '"_x', { desc = "" })
  vim.keymap.set("x", ">", ">gv", { desc = "" })
  vim.keymap.set("x", "<", "<gv", { desc = "" })
  vim.keymap.set("x", "<A-j>", ":m'>+1<CR>gv=gv", { silent = true })
  vim.keymap.set("x", "<A-k>", ":m'<-2<CR>gv=gv", { silent = true })

  --- Terminal mode related
  vim.keymap.set("n", "<C-`>", function()
    require("nvterm.terminal").toggle("horizontal")
  end, { desc = "Open/Close terminal of current tab" })
  vim.keymap.set("t", "<C-x>", "<C-\\><C-n>", { desc = "Exit terminal mode", silent = true })
  vim.keymap.set("t", "<C-`>", function()
    require("nvterm.terminal").toggle("horizontal")
  end)

  -- Built in comment
  vim.keymap.set("n", "<C-/>", "gcc", { desc = "toggle comment" })
  vim.keymap.set(
    "x",
    "<C-/>",
    "gc",
    { desc = "Toggle comment" }
  )
  vim.keymap.set("i", "<C-/>", "<C-o>gcc", {})
end

---@param bufnr integer buffer number to vim.keymap.set keymap
M.lsp = function(bufnr)
  bufnr = bufnr or 0
  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
    -- require("lspsaga.hover"):render_hover_doc()
  end, { buffer = bufnr })
  vim.keymap.set("n", "gd", function()
    -- vim.lsp.buf.definition()
    -- vim.cmd("Lspsaga goto_definition")
    vim.cmd("Telescope lsp_definitions")
    -- require("lspsaga.definition"):goto_definition(1)
  end, { desc = "Goto defintion", buffer = bufnr })
  vim.keymap.set("n", "<leader>gt", function()
    -- vim.lsp.buf.type_definition()
    vim.cmd("Lspsaga goto_type_definition")
    -- require("lspsaga.definition"):goto_definition(2)
  end, { desc = "Goto Type Definition", buffer = bufnr })
  vim.keymap.set("n", "<leader>rn", function()
    vim.lsp.buf.rename()
    -- vim.cmd("Lspsaga rename")
    -- require("lspsaga.rename"):lsp_rename()
  end, { buffer = bufnr, desc = "LSP rename" })
  vim.keymap.set("n", "<leader>gr", function()
    vim.cmd("Lspsaga lsp_finder")
    -- require("lspsaga.finder"):lsp_finder()
  end, { buffer = bufnr })
  vim.keymap.set("n", "<leader>gs", function()
    vim.lsp.buf.signature_help()
  end, { desc = "Show signature", buffer = bufnr })
  vim.keymap.set("n", "<leader>ds", function()
    vim.cmd("Lspsaga show_line_diagnostics")
    -- require("lspsaga.diagnostic"):show_diagnostics(arg, "line")
  end, { desc = "Show line diagnostic", buffer = bufnr })
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev()
    -- vim.cmd("Lspsaga diagnostic_jump_prev")
    -- require("lspsaga.diagnostic"):goto_prev({ wrap = true })
  end, { desc = "goto prev diagnostic", buffer = bufnr })
  vim.keymap.set("n", "]d", function() -- vim.diagnostic.goto_next()
    vim.diagnostic.goto_next()
    -- vim.cmd("Lspsaga diagnostic_jump_next")
    -- require("lspsaga.diagnostic"):goto_next()
  end, { desc = "goto next diagnostic", buffer = bufnr })

  M.null_ls(bufnr)
end

---@param bufnr integer buffer number to vim.keymap.set keymap
M.jdtls = function(bufnr)
  -- vim.keymap.set("n", "gd", function()
  --   vim.lsp.buf.definition()
  --   -- vim.cmd.Lspsaga("goto_definition")
  --   -- require("lspsaga.definition"):goto_definition(1)
  -- end, { desc = "Goto defintion", buffer = bufnr })
  vim.keymap.set("n", "<leader>gt", function()
    vim.lsp.buf.type_definition()
    -- vim.cmd.Lspsaga("goto_type_definition")
    -- require("lspsaga.definition"):goto_definition(2)
  end, { desc = "Goto Type Definition", buffer = bufnr })
  bufnr = bufnr or 0
  vim.keymap.set("n", "<A-o>", function()
    require("jdtls").organize_imports()
  end, { desc = "Jdtls organize imports", buffer = bufnr })
  vim.keymap.set("n", "<leader>jv", function()
    require("jdtls").extract_variable()
  end, { desc = "extract variable", buffer = bufnr })
  vim.keymap.set("n", "<S-F6>", function() -- F18 or S-F6
    require("jdtls").test_class({})
    vim.schedule(function()
      vim.cmd("stopinsert")
    end)
  end, { desc = "Test java class", buffer = bufnr })
  vim.keymap.set("n", "<S-F8>", function() -- F20 or S-F8
    require("jdtls").test_nearest_method()
  end, { desc = "test nearest java method", buffer = bufnr })
  vim.keymap.set("x", "<leader>jv", function()
    require("jdtls").extract_variable(true)
  end, { desc = "Extract variable", buffer = bufnr })
  vim.keymap.set("x", "<leader>jc", function()
    require("jdtls").extract_constant(true)
  end, { desc = "Extract constant", buffer = bufnr })
  vim.keymap.set("x", "<leader>jm", function()
    require("jdtls").extract_method(true)
  end, { desc = "Extract method", buffer = bufnr })
end

M.telescope = function()
  vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep_args prompt_title=false<CR>", { desc = "Live grep" })
  vim.keymap.set(
    "n",
    "<leader>fa",
    "<cmd> Telescope find_files follow=true no_ignore=true hidden=true prompt_title=false<CR>",
    { desc = "find all" }
  )
  vim.keymap.set(
    "n",
    "<leader>ff",
    function ()
      require("telescope.builtin").find_files({
        find_command = { "fd", "--type", "f", "--color", "never" },
      })
    end,
    -- "<cmd>Telescope find_files prompt_title=false find_command=['fd', '--type', 'f', '--color', 'never']<CR>",
    { desc = "find files" })
  vim.keymap.set(
    "n",
    "<leader>tm",
    '<cmd>Telescope man_pages prompt_title=false sections={"ALL"}<CR>',
    { desc = "show man page" }
  )
  vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps prompt_title=false<CR>", { desc = "find mappings" })
end

---@param bufnr integer buffer to vim.keymap.set key map
M.git = function(bufnr)
  -- bufnr = bufnr or 0
  local gitsigns = package.loaded.gitsigns
  vim.keymap.set("n", "<leader>gdo", "<cmd>DiffviewOpen<CR>", { desc = "Open Diff view", buffer = bufnr })
  vim.keymap.set("n", "<leader>gdc", "<cmd>DiffviewClose<CR>", { desc = "Close Diff view", buffer = bufnr })
  vim.keymap.set("n", "<leader>gdr", "<cmd>DiffviewRefresh<CR>", { desc = "Refresh Diff view", buffer = bufnr })

  vim.keymap.set("n", "[c", function()
    if vim.wo.diff then
      return "[c"
    end
    vim.schedule(function()
      gitsigns.prev_hunk({ preview = true })
    end)
    return "<Ignore>"
  end, { expr = true, desc = "Jump to prev hunk", buffer = bufnr })
  vim.keymap.set("n", "]c", function()
    if vim.wo.diff then
      return "]c"
    end
    vim.schedule(function()
      gitsigns.next_hunk({ preview = true })
    end)
    return "<Ignore>"
  end, { expr = true, desc = "Jump to next hunk", buffer = bufnr })

  vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage Hunk" })
  vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage Hunk" })
  vim.keymap.set("n", "<leader>hr", function()
    gitsigns.reset_hunk()
  end, { desc = "Reset hunk", buffer = bufnr })
  vim.keymap.set("v", "<leader>hs", function()
    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "Stage Hunk", buffer = bufnr })
  vim.keymap.set("v", "<leader>hr", function()
    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { buffer = bufnr, desc = "Reset Hunk" })
  vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk, { buffer = bufnr, desc = "Undo Stage Hunk" })
  vim.keymap.set("n", "<leader>s", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage Hunk" })
  vim.keymap.set("n", "<leader>r", function()
    gitsigns.reset_hunk()
  end, { desc = "Reset hunk", buffer = bufnr })
  vim.keymap.set("v", "<leader>s", function()
    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { desc = "Stage Hunk", buffer = bufnr })
  vim.keymap.set("v", "<leader>r", function()
    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end, { buffer = bufnr, desc = "Reset Hunk" })
  vim.keymap.set("n", "<leader>u", gitsigns.undo_stage_hunk, { buffer = bufnr, desc = "Undo Stage Hunk" })
  vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, { buffer = bufnr, desc = "View Diff" })
  vim.keymap.set("n", "<leader>hD", function()
    gitsigns.diffthis("~")
  end, { buffer = bufnr, desc = "View Diff" })

  vim.keymap.set("n", "<leader>hp", function()
    gitsigns.preview_hunk_inline()
  end, { desc = "Preview hunk", buffer = bufnr })

  vim.keymap.set("n", "<leader>hb", function()
    gitsigns.blame_line()
  end, { desc = "Blame line", buffer = bufnr })

  vim.keymap.set("n", "<leader>td", function()
    gitsigns.toggle_deleted()
  end, { desc = "Toggle deleted", buffer = bufnr })
  -- vim.keymap.set({ "n" }, "<leader>cm", function()
  --   require("Neogit")
  -- end)
end

M.dap = function()
  vim.keymap.set("n", "<F5>", "<cmd>DapContinue<CR>", { desc = "Continue/start a debug session" })
  vim.keymap.set("n", "<F17>", "<cmd>DapTerminate<CR>", { desc = "Close current debug session" })
  vim.keymap.set("n", "<F29>", function()
    vim.notify("Debug Session Restarting", vim.diagnostic.severity.INFO)
    require("dap").terminate({}, { terminateDebuggee = true }, function()
      require("dap").run_last()
    end)
  end, { desc = "Continue/start a debug session" })
  vim.keymap.set("n", "<F10>", "<cmd>DapStepOver<CR>", { desc = "DAP Step Over" })
  vim.keymap.set("n", "<F11>", "<cmd>DapStepInto", { desc = "DAP Step Into" })
  vim.keymap.set("n", "<F23>", "<cmd>DapStepOut<CR>", { desc = "DAP Step Out" })
  vim.keymap.set("n", "<leader>b", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint on current line" })

  vim.keymap.set("n", "<leader>do", function()
    require("dap.repl").toggle()
  end, { desc = "Toggle REPL" })
  vim.keymap.set("n", "<leader>du", function()
    require("dapui"):toggle()
  end, { desc = "Toggle dapui" })
end

M.tabline = function()
  -- Why
  vim.keymap.set("n", "<leader>x", function()
    require("config.ui.tabline.utils").close_buffer()
  end, { desc = "close buffer" })
  vim.keymap.set("n", "<Tab>", function()
    require("config.ui.tabline.utils").next_buffer()
  end, { desc = "Next buffer" })
  vim.keymap.set("n", "<S-Tab>", function()
    require("config.ui.tabline.utils").prev_buffer()
  end, { desc = "Prev buffer" })
end

M.comment = function()
  vim.keymap.set("n", "<C-/>", function()
    require("Comment.api").toggle.linewise.current()
  end, { desc = "toggle comment" })
  vim.keymap.set(
    "x",
    "<C-/>",
    "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    { desc = "Toggle comment" }
  )
  vim.keymap.set("n", "<leader>/", function()
    require("Comment.api").toggle.linewise.current()
  end, { desc = "toggle comment" })
  vim.keymap.set(
    "x",
    "<leader>/",
    "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    { desc = "Toggle comment" }
  )
  vim.keymap.set("i", "<C-/>", function()
    require("Comment.api").toggle.linewise.current()
  end)
end

return M
