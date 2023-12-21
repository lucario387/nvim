-- if not vim.g.lsp or not vim.g.lsp.jdtls then
--   return
-- end

if #vim.api.nvim_list_uis() == 0 then
  return
end
if not vim.g.loaded_jdtls then
  vim.g.loaded_jdtls = true
  require("lazy.core.loader").load({ "nvim-lspconfig", "nvim-jdtls", "nvim-dap" }, {})
end

local jdtls = require("jdtls")
local data_path = vim.fn.stdpath("data")
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
extendedClientCapabilities.progressReportProvider = true;
extendedClientCapabilities.onCompletionItemSelectedCommand = "editor.action.triggerParameterHints";


---@type string
local root_dir = require("jdtls.setup").find_root({ ".git", "gradlew", "mvnw", "pom.xml" })
---@type string
local workspace_folder = vim.env.HOME .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local config = {
  cmd = {
    "/usr/lib/jvm/java-17-openjdk/bin/java",

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g", "-Xmx4G",
    "--add-modules=ALL-DEFAULT",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",

    "-javaagent:" .. data_path .. "/mason/packages/jdtls/lombok.jar",
    "-jar",
    vim.fn.glob(data_path .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar",
      true, true, true)[1],
    "-configuration",
    vim.fn.glob(data_path .. "/mason/packages/jdtls/config_linux", true, true, true)[1],
    "-data", workspace_folder,
  },
  root_dir = root_dir,
  ---@type fun(client: lsp.Client, bufnr: integer)
  on_attach = function(client, bufnr)
    require("mappings").lsp(bufnr)
    require("mappings").jdtls(bufnr)
    vim.keymap.set("n", "gi", function()
      require("jdtls").super_implementation()
    end, { buffer = bufnr })
    require("jdtls.dap").setup_dap({
      config_overrides = {
        noDebug = false,
      },
      hotcodereplace = "auto",
    })
    -- require("jdtls.setup").add_commands()
    if client.supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(bufnr, true)
    end
  end,
  capabilities = require("config.lsp").set_capabilities(),
  init_options = {
    bundles = vim.tbl_filter(function(name)
        return not vim.endswith(name, 'com.microsoft.java.test.runner-jar-with-dependencies.jar')
          and not vim.endswith(name, 'com.microsoft.java.test.runner.jar')
      end,
      vim.tbl_flatten(vim.tbl_map(
        function(v)
          return vim.fn.glob(v, true, true, true)
        end,
        {
          data_path .. "/mason/packages/java-test/extension/server/*.jar",
          "/home/lucario387/.vscode/extensions/dgileadi.java-decompiler-0.0.3/server/*fernflower*.jar",
          "/home/lucario387/.vscode/extensions/vscjava.vscode-java-dependency*/server/*.jar",
          "/home/lucario387/.vscode/extensions/vscjava.vscode-java-debug-*/server/com.microsoft.java.debug.plugin-*.jar",
        }
      ))
    ),
    extendedClientCapabilities = extendedClientCapabilities,
  },
  settings = {
    java = {
      signatureHelp = {
        enabled = true,
        description = {
          enabled = true,
        },
      },
      references = {
        includeDecompiledSources = true,
      },
      contentProvider = { preferred = "fernflower" },
      -- saveActions = {
      --   organizeImports = true,
      -- },
      completion = {
        favoriteStaticMembers = {
          "io.crate.testing.Asserts.assertThat",
          "org.assertj.core.api.Assertions.assertThat",
          -- "org.assertj.core.api.Assertions.assertThatThrownBy",
          -- "org.assertj.core.api.Assertions.assertThatExceptionOfType",
          "org.assertj.core.api.Assertions.catchThrowable",
          "org.hamcrest.MatcherAssert.assertThat",
          "org.mockito.ArgumentMatchers.*",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
          -- "MockMvc*",
          "org.springframework.test.web.servlet.setup.MockMvcBuilders.*",
          "org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
          "org.springframework.test.web.servlet.result.MockMvcResultHandlers.*",
          "org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
        importOrder = {
          "javax",
          "java",
          "com",
          "org",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          skipNullValues = true,
          listArrayContents = true,
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
        hashCodeEquals = {
          useInstanceOf = true,
          useJava7Objects = true,
        },
        insertLocation = true,
      },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-11",
            path = "/usr/lib/jvm/java-11-openjdk",
          },
          {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/java-17-openjdk",
          },
          {
            name = "JavaSE-21",
            path = "/usr/lib/jvm/java-21-openjdk"
          }
          -- {
          --   name = "JavaSE-20",
          --   path = "/usr/lib/jvm/java-20-openjdk",
          -- },
        },
      },
      inlayHints = {
        parameterNames = {
          enabled = "literals",
        },
      },
      -- eclipse = {
      --   downloadSources = true,
      -- },
      -- maven = {
      --   downloadSources = true,
      --   updateSnapshots = true,
      -- },
    },
  },
}

jdtls.start_or_attach(config)
