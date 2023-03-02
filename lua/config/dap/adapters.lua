local M = {}

local fn = vim.fn
local mason_path = fn.stdpath("data") .. "/mason"
local path = "/home/lucario387/.vscode/extensions/ms-vscode.cpptools-1.14.3-linux-x64/debugAdapters/bin/OpenDebugAD7"

M.cppdbg = {
	id = "cppdbg",
	type = "executable",
	-- Must be absolute path to OpenDebugAD7
	command = mason_path .. "/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
}

return M
