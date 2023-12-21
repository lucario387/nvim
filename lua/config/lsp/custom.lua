---@type table<string, fun(on_attach: fun(client: lsp.Client, bufnr: integer), capabilities: lsp.ClientCapabilities)>
local M = {}

M.jsonls = function(on_attach, capabilities)
  require("lspconfig").jsonls.setup({
    ---@type fun(client: lsp.Client, bufnr: integer)
    on_attach = function(client, bufnr)
      client.server_capabilities.formattingProvider = false
      client.server_capabilities.rangeFormattingProvider = false
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
    settings = {
      json = {
        validate = {
          enable = true,
        },
      },
    },
  })
end

M.yamlls = function(on_attach, capabilities)
  require("lspconfig").yamlls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      yaml = {
        ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "azure-pipeline*.ya?ml",
      },
    },
  })
end

M.neodev = function(on_attach, capabilities)
  -- require("neodev").setup({
  -- 	library = {
  -- 		plugins = false,
  -- 	},
  -- })
  require("lspconfig").lua_ls.setup({
    ---@type fun(client: lsp.Client, bufnr: integer)
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      require("mappings").lsp(bufnr)
      -- vim.keymap.set("n", "gd", function()
      --   vim.cmd.Lspsaga("goto_definition")
      -- end, { buffer = bufnr })
      vim.keymap.set("n", "<leader>gt", function()
        vim.cmd.Lspsaga("goto_type_definition")
      end, { buffer = bufnr })
      if client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(bufnr, true)
      end
    end,
    capabilities = capabilities,
    settings = {
      Lua = {
        telemetry = {
          enable = false,
        },
        completion = {
          callSnippet = "Disable",
        },
        diagnostics = {
          globals = {
            "vim",
            "describe",
            "it",
          },
        },
        -- hint = {
        --   enable = true,
        -- },
        workspace = {
          checkThirdParty = false,
          -- library = {
          --   vim.env.VIMRUNTIME .. "/lua/",
          --   "/home/lucario387/dev/extensions/nvchad_types",
          --   -- data_path .. "/mason/packages/lua-language-server/libexec/meta/",
          --   -- data_path .. "/mason/packages/lua-language-server/libexec/meta/198256b1",
          --   -- data_path .. "/mason/packages/lua-language-server/libexec/meta/5393ac01",
          -- },
        },
        runtime = {
          pathStrict = true,
        },
      },
    },
  })
end

M.lua_ls = function(on_attach, capabilities)
  require("lspconfig").lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        telemetry = {
          enable = false,
        },
      },
    },
  })
end

M.clangd = function(on_attach, capabilities)
  -- require("clangd_extensions").setup({
  --   -- server = {
  --   -- },
  --   extensions = {
  --     autoSetHints = false,
  --     ast = {
  --       role_icons = {
  --         type = " ",
  --         declaration = " ",
  --         expression = " ",
  --         specifier = "  ",
  --         statement = " ",
  --         ["template argument"] = " ",
  --       },
  --
  --       kind_icons = {
  --         Compound = " ",
  --         Recovery = " ",
  --         TranslationUnit = " ",
  --         PackExpansion = " ",
  --         TemplateTypeParm = " ",
  --         TemplateTemplateParm = " ",
  --         TemplateParamObject = " ",
  --       },
  --     },
  --     memory_usage = {
  --       border = "rounded",
  --     },
  --     symbol_info = {
  --       border = "rounded",
  --     },
  --   },
  -- })
  require("lspconfig").clangd.setup({
    cmd = {
      "clangd",
      "--background-index",
      -- "--offset-encoding=utf-16",   -- temporary fix to stop null-ls
      "--enable-config",
      "--completion-style=detailed",
      "--clang-tidy",
      "--all-scopes-completion",
      "--pch-storage=memory",
      "--suggest-missing-includes",
      "--header-insertion=iwyu",
      "--header-insertion-decorators",
      -- "-j=6",
    },
    on_attach = function(client, bufnr)
      -- client.server_capabilities.semanticTokensProvider = false
      on_attach(client, bufnr)
      -- vim.lsp.inlay_hint(bufnr, true)
    end,
    capabilities = capabilities,
  })
end

M.eslint = function(on_attach, capabilities)
  require("lspconfig").eslint.setup({
    on_attach = function(client, bufnr)
      client.server_capabilities.definitionProvider = false
      client.server_capabilities.completionProvider = false
      client.server_capabilities.signatureHelpProvider = false
      client.server_capabilities.declarationProvider = false
      client.server_capabilities.implementationProvider = false
      client.server_capabilities.typeDefinitionProvider = false
      client.server_capabilities.referencesProvider = false
      client.server_capabilities.inlayHintProvider = false
      if vim.g.lsp.formatters and vim.g.lsp.formatters["tsserver"] then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end
      on_attach(client, bufnr)
      -- vim.keymap.set("n", "<leader>fm", function()
      --   vim.cmd("EslintFixAll")
      -- end, { buffer = 0, silent = true })
    end,
    capabilties = capabilities,
    settings = {
      codeAction = {
        disableRuleComment = {
          enable = true,
          location = "separateLine",
        },
        showDocumentation = { enable = true },
      },
      codeActionOnSave = {
        enable = true,
        mode = "problems",
      },
      format = true,
      nodePath = "",
      onIgnoredFiles = "off",
      packageManager = "npm",
      quiet = false,
      rulesCustomizations = {},
      problems = {
        shortenToSingleFile = true,
      },
      run = "onSave",
      useESLintClass = true,
      validate = "on",
      workingDirectory = {
        mode = "location",
      },
    },
  })
end

M.tsserver = function(on_attach, capabilities)
  require("lazy.core.loader").load({ "typescript-tools.nvim" }, {}, { force = true })
  require("typescript-tools").setup({
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
    end,
  })
  -- require("typescript").setup({
  --   server = {
  --     cmd = {
  --       "typescript-language-server",
  --       "--stdio",
  --     },
  --     on_attach = function(client, bufnr)
  --       on_attach(client, bufnr)
  --       vim.keymap.set("n", "gd", "<cmd>TypescriptGoToSourceDefinition<CR>",
  --         { desc = "Goto source definition", buffer = bufnr })
  --     end,
  --     capabilities = capabilities,
  --     single_file_support = true,
  --   },
  -- })
end

M.volar = function(on_attach, capabilities)
  require("lspconfig").volar.setup({
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      on_attach(client, bufnr)
      -- require("config.lsp.utils").on_attach(client, bufnr)
      -- vim.keymap.set("n", "<leader>fm", function()
      --   vim.cmd("EslintFixAll")
      -- end, { buffer = 0, silent = true })
    end,
    capabilities = capabilities,
    settings = {
      volar = {
        autoCompleteRefs = true,
        vueserver = {
          reverseConfigFilePriority = true,
        },
      },
    },
    init_options = {
      ["vue-semantic-server"] = {
        trace = {
          server = "on",
        },
      },
      vue = {
        server = {
          -- reverseConfigFilePriority = true,
          vitePress = {
            supportMdFile = true,
          },
        },
        updateImportsOnFileMove = {
          enabled = true,
        },
      },
    },
  })
end

M.pyright = function(on_attach, capabilities)
  require("lspconfig").pyright.setup({
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      require("config.lsp").register({
        require("null-ls").builtins.formatting.autopep8,
      })
    end,
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
        },
      },
    },
  })
end

M.pylance = function(on_attach, capabilities)
  require("config.lsp.servers.pylance")
  require("lspconfig").pylance.setup({})
end

M.bashls = function(on_attach, capabilities)
  require("lspconfig").bashls.setup({
    on_attach = function(client, bufnr)
      client.server_capabilities.semanticTokensProvider = vim.NIL
      local null = require("null-ls")
      on_attach(client, bufnr)
      require("config.lsp").register({
        null.builtins.diagnostics.shellcheck,
        null.builtins.code_actions.shellcheck,
        null.builtins.formatting.shellharden,
        null.builtins.formatting.shfmt,
        -- null.builtins.formatting.beautysh
      })
    end,
    capabilities = capabilities,
  })
end

return M
