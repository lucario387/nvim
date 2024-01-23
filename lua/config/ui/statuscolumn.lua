local M = {}

M.draw = function()
	if vim.v.wrap then
		return "%="
	end
  return "%=%l%s"
	-- local line = vim.fn.line(".")
	-- return (vim.v.lnum == line or not vim.v.relnum) and "%=%#CurrentLineNr#%l%s" or "%=%r%s"
	-- return vim.v.lnum < x and
	--   "%=%{v:relnum?-v:relnum:v:lnum}%s%C" or
	-- return "%=%{v:relnum?v:relnum:v:lnum}%s%C"
end

return M


--- For statuscolumn option of Neovim Nightly
--- If you are not using nightly, please ignore this
-- local M = {}
--
-- --- Ty CKolkey for these functions
-- local not_fold_start = function(line)
--   return vim.fn.foldlevel(line) <= vim.fn.foldlevel(line - 1) 
-- end
--
-- local fold_opened = function(line)
--   return vim.fn.foldclosed(line) == -1
-- end
--
-- local fold_icon = function(line)
--   if vim.v.virtnum ~= 0
--       or vim.fn.foldlevel(line) <= 0
--       or not_fold_start(line) then
--     return " "
--   end
--
--   if fold_opened(line) then 
--     return ""
--   else
--     return ""
--   end
-- end
--
-- _G.FoldClickHandler = function()
--   local line = vim.fn.getmousepos().line
--   if not_fold_start(line) then
--     return
--   end
--   vim.cmd(line .. "fold" .. (fold_opened(line) and "close" or "open"))
-- end
--
-- local fold_handler = function()
--   return "%#FoldColumn#%@v:lua.FoldClickHandler@" .. fold_icon(vim.v.lnum)
-- end
--
-- local line_number = function()
--   -- If part of a wrapped line, dont show extra line nums
--   if vim.v.wrap then
--     return "%="
--   end
--
--   --- Make sure normal number/relnum functionalities of vim stays as is
-- 	local line = vim.fn.line(".")
-- 	return (vim.v.lnum == line or not vim.v.relnum) and "%=%#LineNr#%l" or "%=%r"
-- end
--
--
-- M.draw = function()
--   return table.concat({
--     line_number(),
--     "%s", -- sign column, git/diagnostics/debug breakpoint will show here
--     fold_handler(),
--     " "
--   }, "")
-- end
--
-- return M
