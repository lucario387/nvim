-- Unsure if this is nice or not, but why not
--
-- vim.g.clipboard = {
--   name = 'OSC 52',
--   copy = {
--     ['+'] = require('vim.clipboard.osc52').copy,
--     ['*'] = require('vim.clipboard.osc52').copy,
--   },
--   paste = {
--     ['+'] = require('vim.clipboard.osc52').paste,
--     ['*'] = require('vim.clipboard.osc52').paste,
--   },
-- }

---@type ThemeName
vim.g.nvchad_theme = "vscode_dark"
vim.g.transparency = false
-- vim.g.nvimtree_side = "left"

vim.g.query_lint_on = { "BufWrite" }
vim.g.matchup_matchparen_offscreen = { method = nil, scrolloff = 1 }
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.skip_ts_context_commentstring_module = true
-- opt.cmdheight = 0
vim.o.laststatus = 3 -- global statusline
vim.o.showmode = false
-- vim.o.digraph = true

vim.o.title = true
-- vim.o.clipboard = "unnamedplus"

vim.o.cursorline = true
vim.o.exrc = true

-- Indenting
vim.o.expandtab = true
vim.o.shiftwidth = 2
-- vim.o.smartindent = true
vim.o.tabstop = 2
-- vim.o.softtabstop = 0

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
-- vim.o.foldcolumn = "auto"
-- vim.o.mouse = "nv"
-- vim.o.mousemoveevent = true

vim.o.splitbelow = true
vim.o.splitright = true
vim.o.splitkeep = "screen"
vim.o.termguicolors = true
-- vim.o.timeoutlen = 400
vim.o.undofile = true
-- vim.o.swapfile = true
-- vim.o.history = 200

-- interval for writing swap file to disk, also used by gitsigns
vim.o.updatetime = 50

-- vim.opt.smartindent = true
vim.o.number = true
-- vim.o.numberwidth = 2
vim.o.ruler = false
vim.o.relativenumber = true
-- vim.o.hlsearch = true
-- o.shadafile = "NONE"

-- vim.o.conceallevel = 2
vim.o.concealcursor = "n"
-- o.sessionoptions = "buffers,curdir,localoptions,folds,help,winpos,tabpages"

vim.o.viewoptions = "folds,cursor"

-- vim.o.smoothscroll = true
-- Wrap, linebreak settings
vim.o.scrolloff = 10
-- vim.o.wrap = true

vim.o.linebreak = true
vim.o.breakindent = true
-- vim.o.cmdheight = 0

vim.o.pumheight = 10
-- vim.o.spell = false

-- Change default grep
-- if rg exists
-- if vim.fn.executable("rg") == 1 then
--   vim.o.grepprg = "rg --vimgrep --smart-case"
--   vim.opt.grepformat:append("%f:%l:%c:%m")
-- end

-- disable nvim intro
vim.opt.shortmess:append("sIcC")
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- { "internal", "filler", "closeoff", "linematch:90" }
vim.opt.diffopt:append("linematch:90")
-- others: !,'100,<50,s10,h)
vim.opt.shada:append({ "r/tmp/", "r/private/", "rterm:", "rzipfile:", "rhealth:" })
vim.opt.fillchars = {
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
	eob = " ",
}

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append("<>[]hl")

-- Managing python files
-- if fn.exists("$VIRTUAL_ENV") == 1 then
--   vim.g.python3_host_prog = fn.substitute(fn.system("which -a python3 | head -n2 | tail -n1"), "\n", "", "g")
-- else
--   vim.g.python3_host_prog = fn.substitute(fn.system("which python3"), "\n", "", "g")
-- end

-- change this to where you install neovim@4.10.1 npm package
-- vim.g.node_host_prog = vim.env.HOME .. "/.npm-global/lib/node_modules/neovim/bin/cli.js"
local disabled_providers = {
	"node_provider",
	"perl_provider",
	-- "python3_provider",
	"ruby_provider",
}
for _, provider in pairs(disabled_providers) do
	vim.g["loaded_" .. provider] = 0
end

vim.filetype.add({
  pattern = {
    [".*/example_queries/.*%.scm"] = "query"
  },
  filename = {
    ["zathurarc"] = "zathurarc",
  },
})
