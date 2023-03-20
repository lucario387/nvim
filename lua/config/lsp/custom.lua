---@type table<string, fun(on_attach: fun(client: Client, bufnr: integer), capabilities: ClientCapabilities)>
local M = {}

M.jsonls = function(on_attach, capabilities)
	require("lspconfig").jsonls.setup({
		on_attach = function(client, bufnr)
			client.server_capabilities.formattingProvider = false
			client.server_capabilities.rangeFormattingProvider = false
			on_attach(client, bufnr)
		end,
		capabilities = capabilities,
	})
end

M.yamlls = function (on_attach, capabilities)
  require("lspconfig").yamlls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      yaml = {
        ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "azure-pipeline*.ya?ml"
      }
    }
  })
end

M.neodev = function(on_attach, capabilities)
	require("neodev").setup({
		library = {
			plugins = false,
		},
	})
	require("lspconfig").lua_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			Lua = {
				telemetry = {
					enable = false,
				},
				completion = {
					callSnippet = "Both",
				},
        diagnostics = {
          globals = {
            "vim",
          },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            "/home/lucario387/dev/extensions/nvchad_types",
            "/home/lucario387/.local/share/nvim/site/pack/packer/start/neodev.nvim/types/nightly",
            "/home/lucario387/.local/share/nvim/site/pack/packer/start/neodev.nvim/types/override",
            "/usr/local/share/nvim/runtime/lua"
          }
        },
				-- format = {
				-- 	defaultConfig = {
				-- 		align_call_args = false,
				-- 		align_function_define_params = true,
				-- 		continuation_indent_size = 2,
				-- 		continuous_assign_statement_align_to_equal_sign = true,
				-- 		continuous_assign_table_field_align_to_equal_sign = true,
				-- 		if_condition_align_with_each_other = true,
				-- 		if_condition_no_continuation_indent = true,
				-- 		indent_size = 2,
				-- 		indent_style = "space",
				-- 		insert_final_newline = true,
				-- 		keep_one_space_between_namedef_and_attribute = true,
				-- 		keep_one_space_between_table_and_braket = true,
				-- 		label_no_indent = true,
				-- 		quote_style = "double",
				-- 	},
				-- },
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
  require("lspconfig").clangd.setup({
    cmd = {
      "clangd",
      "--background-index",
      "--offset-encoding=utf-16", -- temporary fix to stop null-ls
      "--enable-config",
      "--completion-style=detailed",
      "--clang-tidy",
      "--all-scopes-completion",
      "--pch-storage=memory",
      "--suggest-missing-includes",
    },
    on_attach = function(client, bufnr)
      -- client.server_capabilities.semanticTokensProvider = false
      on_attach(client, bufnr)
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
	require("typescript").setup({
		server = {
      cmd = {
        "typescript-language-server",
        "--stdio",
      },
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
        vim.keymap.set("n", "gd", "<cmd>TypescriptGoToSourceDefinition<CR>", { desc = "Goto source definition", buffer = bufnr })
			end,
			capabilities = capabilities,
			single_file_support = true,
		},
	})
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
