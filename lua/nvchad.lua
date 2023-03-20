local M = {}

---@param current string name of current theme
---@param new string name of new theme
M.replace_word = function(current, new) end

-- ---@param theme string theme name
-- M.reload_theme = function(theme)
-- 	theme = theme or vim.g.nvchad_theme
-- 	vim.g.nvchad_theme = theme
-- 	require("base46").load_all_highlights()
-- 	-- vim.api.nvim_exec_autocmds("User", { pattern = "NvChadThemeReload" })
-- end
--
-- ---@param old_data string
-- ---@param new_data string
-- M.write_data = function(old_data, new_data) end
--
-- M.replace_word = function(old_theme, new_theme) end

-- local config = require("core.utils").load_config

-- vim.print(debug.getinfo(config, "Sln"))

return M
