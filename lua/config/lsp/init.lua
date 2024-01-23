local M = {}

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

---register for null-ls
---@param sources table<any> list of sources to register
M.register = function(sources)
  local null = require("null-ls")
  for _, source in ipairs(sources) do
    if not null.is_registered(source) then
      null.register(source)
    end
  end
end

---use for both null ls and lspconfig
---@param client lsp.Client
---@param bufnr integer
M.on_attach = function(client, bufnr)
  -- Load LSP mappings for buffer bufnr
  require("mappings").lsp(bufnr)
  -- client.server_capabilities.seman
end

---@return lsp.ClientCapabilities
M.set_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.contextSupport = true
  capabilities.textDocument.completion.insertTextMode = 1
  capabilities.textDocument.completion.completionList = {
    itemDefaults = {
      'commitCharacters',
      'editRange',
      'insertTextFormat',
      'insertTextMode',
      'data',
    },
  }
  capabilities.textDocument.completion.completionItem = {
    valueSet = {
      1,
      2,
    },
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        -- "edit",
        "documentation",
        "detail",
        "additionalTextEdits",
        "sortText",
        "filterText",
        "insertText",
        "textEdit",
        "insertTextFormat",
        "insertTextMode",
      },
    },
    insertTextModeSupport = {
      valueSet = {
        1, -- asIs
        2, -- adjustIndentation
      },
    },
  }
  return capabilities
end

M.lsp_handlers = function()
  -- local function lspSymbol(name, icon)
  --   local hl = "DiagnosticSign" .. name
  --   vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
  -- end
  --
  -- lspSymbol("Warn", " ")
  -- lspSymbol("Info", " ")
  -- lspSymbol("Hint", " ")
  -- lspSymbol("Error", " ")

  vim.diagnostic.config({
    virtual_text = true,
    signs = {
      text = {
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.INFO] = " ",
        [vim.diagnostic.severity.HINT] = " ",
        [vim.diagnostic.severity.ERROR] = " ",
      },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,

    float = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "CursorMovedI", "InsertEnter", "FocusLost", "WinLeave" },
      border = "rounded",
      scope = "line",
    },
  })
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = "rounded" }
  )
end

return M
