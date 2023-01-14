---@meta
---@diagnostic disable: codestyle-check

---Return the basename of the given file or directory
---@param file string File or directory
---@return string #Basename of `file`
function vim.fs.basename(file) end

---Return an iterator over the files and directories located in `path`
---@param path string An absolute or relative path to the directory to iterate over. The path is first normalized using [vim.fs.normalize()]()
---@param opts {depth: integer|nil, skip: nil|fun(dir_name: string): boolean}
function vim.fs.dir(path, opts) end

---@param file string
---@return string #Parent directory of `file`
function vim.fs.dirname(file) end

---@param names string|string[]|fun(name: string): boolean
---@param opts {path: string, upward: boolean|false, stop: string, type:"file"|"directory", limit: integer}
---@return string[]
function vim.fs.find(names, opts) end

---@param path string
---@return string # Normalized path
function vim.fs.normalize(path) end

---@param start string Initial file or directory
---@return function # iterator
function vim.fs.parents(start) end
