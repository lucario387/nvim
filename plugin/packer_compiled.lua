-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/lucario387/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/lucario387/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/lucario387/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/lucario387/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/lucario387/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\nÞ\1\0\0\6\0\n\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0005\2\6\0005\3\5\0=\3\1\0026\3\0\0'\5\a\0B\3\2\0029\3\b\3B\3\1\2=\3\t\2B\0\2\1K\0\1\0\rpre_hook\20create_pre_hook7ts_context_commentstring.integrations.comment_nvim\1\0\0\1\0\2\nextra\1\nbasic\1\nsetup\fComment\fcomment\rmappings\frequire\0" },
    load_after = {
      ["nvim-ts-context-commentstring"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\2\nÉ\1\0\0\3\0\t\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\3\0006\1\4\0009\1\5\0019\1\6\1B\1\1\0028\0\1\0\15\0\0\0X\1\f€6\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\a\0\14\0\0\0X\0\5€6\0\0\0'\2\1\0B\0\2\0029\0\b\0B\0\1\1K\0\1\0\19unlink_current\16jump_active\25nvim_get_current_buf\bapi\bvim\18current_nodes\fsession\fluasnip\frequireÖ\2\1\0\5\0\18\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\3\0005\2\4\0B\0\2\0016\0\0\0'\2\5\0B\0\2\0029\0\6\0B\0\1\0016\0\0\0'\2\5\0B\0\2\0029\0\6\0005\2\n\0004\3\3\0006\4\a\0009\4\b\0049\4\t\4>\4\1\3=\3\v\2B\0\2\0016\0\a\0009\0\f\0009\0\r\0'\2\14\0005\3\16\0003\4\15\0=\4\17\3B\0\3\1K\0\1\0\rcallback\1\0\0\0\16InsertLeave\24nvim_create_autocmd\bapi\npaths\1\0\0\21luasnippets_path\6g\bvim\14lazy_load luasnip.loaders.from_vscode\1\0\2\fhistory\2\17updateevents\29TextChanged,TextChangedI\15set_config\vconfig\fluasnip\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  NvTerm = {
    config = { "\27LJ\2\n^\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\vtoggle\1\0\0\1\0\1\15horizontal\n<C-`>\nsetup\vnvterm\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/NvTerm",
    url = "https://github.com/NvChad/NvTerm"
  },
  base46 = {
    loaded = true,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/start/base46",
    url = "https://github.com/NvChad/base46"
  },
  ["cmp-buffer"] = {
    after_files = { "/home/lucario387/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-dap"] = {
    after_files = { "/home/lucario387/.local/share/nvim/site/pack/packer/opt/cmp-dap/after/plugin/cmp_dap.lua" },
    config = { "\27LJ\2\n”\1\0\0\6\0\b\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\3\0005\2\4\0005\3\6\0004\4\3\0005\5\5\0>\5\1\4=\4\a\3B\0\3\1K\0\1\0\fsources\1\0\0\1\0\1\tname\bdap\1\4\0\0\rdap-repl\18dapui_watches\16dapui_hover\rfiletype\nsetup\bcmp\frequire\0" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/cmp-dap",
    url = "https://github.com/rcarriga/cmp-dap"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/home/lucario387/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    after_files = { "/home/lucario387/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    after_files = { "/home/lucario387/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["diffview.nvim"] = {
    config = { "\27LJ\2\n\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\3=\3\a\2B\0\2\1K\0\1\0\tview\15merge_tool\1\0\0\1\0\2\24disable_diagnostics\2\vlayout\16diff3_mixed\1\0\1\21enhanced_diff_hl\2\nsetup\rdiffview\frequire\0" },
    load_after = {
      ["gitsigns.nvim"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    after = { "diffview.nvim" },
    config = { "\27LJ\2\n8\0\1\4\0\3\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\1\18\3\0\0B\1\2\1K\0\1\0\bgit\rmappings\frequireß\3\1\0\6\0\31\0*6\0\0\0006\2\1\0009\2\2\0029\2\3\2'\3\4\0&\2\3\2B\0\2\0016\0\5\0'\2\6\0B\0\2\0026\1\5\0'\3\a\0B\1\2\0029\1\b\0015\3\22\0005\4\n\0005\5\t\0=\5\v\0045\5\f\0=\5\r\0045\5\14\0=\5\15\0045\5\16\0=\5\17\0045\5\18\0=\5\19\0045\5\20\0=\5\21\4=\4\23\0035\4\24\0=\4\25\0033\4\26\0=\4\27\3B\1\2\0019\1\28\0004\3\3\0009\4\29\0009\4\30\0049\4\a\4>\4\1\3B\1\2\1K\0\1\0\17code_actions\rbuiltins\rregister\14on_attach\0\19preview_config\1\0\1\vborder\frounded\nsigns\1\0\2\18sign_priority\3\0\20max_file_length\3¸\23\14untracked\1\0\1\ttext\bâ”†\17changedelete\1\0\1\ttext\6~\14topdelete\1\0\1\ttext\bâ€¾\vdelete\1\0\1\ttext\bï¡´\vchange\1\0\1\ttext\bâ”ƒ\badd\1\0\0\1\0\1\ttext\bâ”ƒ\nsetup\rgitsigns\fnull-ls\frequire\bgit\17base46_cache\6g\bvim\vdofile\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nK\0\0\4\0\5\0\b6\0\0\0006\2\1\0009\2\2\0029\2\3\2'\3\4\0&\2\3\2B\0\2\1K\0\1\0\14blankline\17base46_cache\6g\bvim\vdofileÇ\2\1\0\4\0\n\0\0146\0\0\0003\2\1\0B\0\2\0016\0\2\0'\2\3\0B\0\2\0029\0\4\0005\2\6\0005\3\5\0=\3\a\0025\3\b\0=\3\t\2B\0\2\1K\0\1\0\20buftype_exclude\1\4\0\0\rterminal\thelp\vnofile\21filetype_exclude\1\0\3\25show_current_context\2\28show_first_indent_level\1#show_trailing_blankline_indent\1\1\v\0\0\thelp\rterminal\vpacker\aqf\flspinfo\nmason\20TelescopePrompt\21TelescopeResults\tnorg\nnoice\nsetup\21indent_blankline\frequire\0\npcall\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lspsaga.nvim"] = {
    commands = { "Lspsaga" },
    config = { "\27LJ\2\n–\2\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0005\4\a\0=\4\b\3=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\0025\3\14\0=\3\15\2B\0\2\1K\0\1\0\21symbol_in_winbar\1\0\1\venable\1\14lightbulb\1\0\1\venable\1\16code_action\1\0\1\20extend_gitsigns\1\15diagnostic\tkeys\1\0\1\16exec_action\t<CR>\1\0\2\21on_insert_follow\1\14on_insert\1\aui\1\0\0\1\0\1\vborder\frounded\nsetup\flspsaga\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["mason.nvim"] = {
    config = { "\27LJ\2\n…\2\0\0\5\0\f\0\0196\0\0\0009\0\1\0009\0\2\0006\1\0\0009\1\3\1\4\0\1\0X\0\1€K\0\1\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\a\0005\3\b\0005\4\t\0=\4\n\3=\3\v\2B\0\2\1K\0\1\0\aui\nicons\1\0\3\20package_pending\tï†’ \22package_installed\tï˜² \24package_uninstalled\t ï®Š\1\0\1\vborder\frounded\1\0\2\30max_concurrent_installers\3\4\tPATH\tskip\nsetup\nmason\frequire\bNIL\fexiting\6v\bvim)\1\0\3\0\3\0\0056\0\0\0009\0\1\0003\2\2\0B\0\2\1K\0\1\0\0\rschedule\bvimÀ\1\1\0\6\0\14\0\0236\0\0\0009\0\1\0006\1\0\0009\1\1\0019\1\2\1'\2\3\0006\3\0\0009\3\4\0039\3\5\3'\5\6\0B\3\2\2'\4\a\0&\1\4\1=\1\2\0006\0\0\0009\0\b\0009\0\t\0'\2\n\0005\3\v\0003\4\f\0=\4\r\3B\0\3\1K\0\1\0\rcallback\0\1\0\1\tonce\2\fUIEnter\24nvim_create_autocmd\bapi\15/mason/bin\tdata\fstdpath\afn\6:\tPATH\benv\bvim\0" },
    loaded = true,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neodev.nvim"] = {
    loaded = true,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/start/neodev.nvim",
    url = "https://github.com/folke/neodev.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\n<\0\2\5\0\3\0\a6\2\0\0'\4\1\0B\2\2\0029\2\2\2\18\4\1\0B\2\2\1K\0\1\0\fnull_ls\rmappings\frequire±\2\1\0\6\0\16\0(6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0003\3\4\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0009\0\b\0\15\0\0\0X\1\26€6\0\6\0009\0\a\0009\0\b\0009\0\t\0\15\0\0\0X\1\20€6\0\6\0009\0\a\0009\0\b\0009\0\t\0009\0\n\0\14\0\0\0X\0\r€6\0\0\0'\2\v\0B\0\2\0029\0\f\0004\2\3\0006\3\0\0'\5\1\0B\3\2\0029\3\r\0039\3\14\0039\3\15\3>\3\1\2B\0\2\1K\0\1\0\14prettierd\15formatting\rbuiltins\rregister\15config.lsp\rtsserver\15formatters\blsp\6g\bvim\14on_attach\0\1\0\2\vborder\frounded\ndebug\1\nsetup\fnull-ls\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "cmp-path", "cmp-buffer", "cmp-nvim-lsp", "cmp_luasnip" },
    config = { "\27LJ\2\n™\2\0\0\b\0\14\0\0276\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0029\1\3\0005\3\4\0004\4\0\0=\4\5\0035\4\6\0=\4\a\3B\1\2\0016\1\0\0'\3\b\0B\1\2\0029\1\t\1\18\3\1\0009\1\n\1'\4\v\0006\5\0\0'\a\f\0B\5\2\0029\5\r\5B\5\1\0A\1\2\1K\0\1\0\20on_confirm_done\"nvim-autopairs.completion.cmp\17confirm_done\aon\nevent\bcmp\21disable_filetype\1\3\0\0\20TelescopePrompt\bvim\14fast_wrap\1\0\0\nsetup\19nvim-autopairs\15config.cmp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\nn\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\14filetypes\1\0\0\1\a\0\0\blua\bvim\bcss\tscss\thtml\bvue\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://github.com/NvChad/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    after = { "nvim-dap-virtual-text", "nvim-dap-ui", "cmp-dap" },
    config = { "\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15config.dap\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    config = { "\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18config.dap.ui\frequire\0" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    config = { "\27LJ\2\nC\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\26nvim-dap-virtual-text\frequire\0" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-jdtls"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/nvim-jdtls",
    url = "https://github.com/mfussenegger/nvim-jdtls"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n¸\3\0\0\f\0\17\0G6\0\0\0'\2\1\0B\0\2\0029\1\2\0B\1\1\0016\1\3\0009\1\4\0019\1\5\1\15\0\1\0X\1\6€6\1\3\0009\1\4\0019\1\5\0019\1\6\1\14\0\1\0X\1\1€K\0\1\0009\1\a\0009\2\b\0B\2\1\0026\3\3\0009\3\4\0039\3\5\0039\3\6\0039\3\t\3\15\0\3\0X\4\19€6\3\n\0006\5\3\0009\5\4\0059\5\5\0059\5\6\0059\5\t\5B\3\2\4X\6\t€6\b\0\0'\n\v\0B\b\2\0028\b\a\b9\b\f\b5\n\r\0=\1\a\n=\2\14\nB\b\2\1E\6\3\3R\6õ\1276\3\3\0009\3\4\0039\3\5\0039\3\6\0039\3\15\3\15\0\3\0X\4\17€6\3\n\0006\5\3\0009\5\4\0059\5\5\0059\5\6\0059\5\15\5B\3\2\4X\6\a€6\b\0\0'\n\16\0B\b\2\0028\b\a\b\18\n\1\0\18\v\2\0B\b\3\1E\6\3\3R\6÷\127K\0\1\0\22config.lsp.custom\vcustom\17capabilities\1\0\0\nsetup\14lspconfig\vipairs\fdefault\21set_capabilities\14on_attach\fservers\blsp\6g\bvim\17lsp_handlers\15config.lsp\frequire\0" },
    loaded = true,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    commands = { "NvimTreeToggle", "NvimTreeClose" },
    config = { "\27LJ\2\n¸\a\0\0\a\0)\00026\0\0\0006\2\1\0009\2\2\0029\2\3\2'\3\4\0&\2\3\2B\0\2\0016\0\5\0'\2\6\0B\0\2\0029\0\a\0005\2\b\0005\3\t\0005\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\14\0025\3\15\0=\3\16\0025\3\18\0006\4\1\0009\4\2\0049\4\17\4=\4\19\0035\4\21\0004\5\3\0005\6\20\0>\6\1\5=\5\22\4=\4\23\3=\3\24\0025\3\25\0=\3\26\0025\3\27\0=\3\28\0025\3\30\0005\4\29\0=\4\31\3=\3 \0025\3!\0005\4\"\0=\4#\0035\4%\0005\5$\0=\5&\4=\4'\3=\3(\2B\0\2\1K\0\1\0\rrenderer\nicons\tshow\1\0\0\1\0\4\bgit\2\tfile\2\17folder_arrow\1\vfolder\2\19indent_markers\1\0\1\venable\2\1\0\3\27highlight_opened_files\tname\16group_empty\2\18highlight_git\2\factions\15change_dir\1\0\0\1\0\2\23restrict_above_cwd\2\venable\1\24filesystem_watchers\1\0\1\19debounce_delay\3d\bgit\1\0\4\vignore\1\22show_on_open_dirs\1\venable\2\ftimeout\3ˆ'\tview\rmappings\tlist\1\0\0\1\0\2\bkey\6d\vaction\ntrash\tside\1\0\3\nwidth\3\25\21hide_root_folder\1 preserve_window_proportions\2\18nvimtree_side\24update_focused_file\1\0\2\15update_cwd\1\venable\2\ffilters\fexclude\1\b\0\0\15.gitignore\16.gitmodules\16.luarc.json\19.eslintrc.json\n.exrc\14.nvim.lua\18.editorconfig\vcustom\1\4\0\0\20**/node_modules\r**/%.git\16**/%.github\1\0\1\rdotfiles\2\1\0\4\fsort_by\14extension\18hijack_cursor\2\18disable_netrw\2\23sync_root_with_cwd\2\nsetup\14nvim-tree\frequire\rnvimtree\17base46_cache\6g\bvim\vdofile\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nÁ\1\0\2\t\0\b\1\0306\2\0\0009\2\1\0024\4\0\0\18\5\0\0B\2\3\2\15\0\2\0X\3\2€+\2\2\0L\2\2\0*\2\0\0006\3\2\0006\5\0\0009\5\3\0059\5\4\0056\6\0\0009\6\5\0069\6\6\6\18\b\1\0B\6\2\0A\3\1\3\15\0\3\0X\5\a€\15\0\4\0X\5\5€9\5\a\4\1\2\5\0X\5\2€+\5\2\0L\5\2\0K\0\1\0\tsize\22nvim_buf_get_name\bapi\ffs_stat\tloop\npcall\17tbl_contains\bvim€À\fÙ\b\1\0\6\0003\0C6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0+\1\1\0=\1\6\0006\0\a\0'\2\b\0B\0\2\0029\0\t\0005\2\n\0006\3\0\0009\3\v\0039\3\f\3'\5\r\0B\3\2\2'\4\14\0&\3\4\3=\3\15\0025\3\16\0=\3\17\0025\3\18\0=\3\19\0025\3\20\0003\4\21\0=\4\22\3=\3\23\0025\3\24\0004\4\0\0=\4\22\3=\3\25\0025\3\26\0005\4\27\0=\4\28\3=\3\29\0025\3\30\0=\3\31\0025\3 \0=\3!\0025\3\"\0=\3#\0025\3$\0004\4\0\0=\4\22\3=\3%\0025\3&\0005\4'\0=\4(\3=\3)\0025\3,\0005\4*\0005\5+\0=\5\28\4=\4-\0035\4.\0=\4/\0035\0040\0=\0041\3=\0032\2B\0\2\1K\0\1\0\16textobjects\tmove\1\0\1\venable\1\tswap\1\0\1\venable\1\vselect\1\0\0\1\0\4\aac\17@class.outer\aic\17@class.inner\aif\20@function.inner\aaf\20@function.outer\1\0\3#include_surrounding_whitespace\2\14lookahead\2\venable\2\17query_linter\16lint_events\1\3\0\0\fBufRead\15CursorHold\1\0\2\20use_diagnostics\2\venable\2\15playground\1\0\2\venable\2\15updatetime\0032\26context_commentstring\1\0\2\19enable_autocmd\1\venable\2\fmatchup\1\0\2\24include_match_words\2\venable\2\fautotag\1\0\1\venable\2\26incremental_selection\fkeymaps\1\0\4\21node_decremental\t<bs>\19init_selection\ng<cr>\22scope_incremental\v<S-CR>\21node_incremental\t<cr>\1\0\1\venable\2\vindent\1\0\1\venable\2\14highlight\fdisable\0\1\0\2\venable\2&additional_vim_regex_highlighting\1\19ignore_install\1\2\0\0\nlatex\21ensure_installed\1\4\0\0\bvim\blua\6c\23parser_install_dir\n/site\tdata\fstdpath\afn\1\0\1\17auto_install\2\nsetup\28nvim-treesitter.configs\frequire\15foldenable\31nvim_treesitter#foldexpr()\rfoldexpr\texpr\15foldmethod\6o\bvim\0" },
    loaded = true,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "/home/lucario387/dev/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    after = { "Comment.nvim" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    commands = { "TSPlaygroundToggle", "TSCaptureUnderCursor" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21config.telescope\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["typescript.nvim"] = {
    loaded = true,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/start/typescript.nvim",
    url = "https://github.com/jose-elias-alvarez/typescript.nvim"
  },
  ["vim-matchup"] = {
    after_files = { "/home/lucario387/.local/share/nvim/site/pack/packer/opt/vim-matchup/after/plugin/matchit.vim" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/lucario387/.local/share/nvim/site/pack/packer/opt/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^dap"] = "nvim-dap",
  ["^lspsaga"] = "lspsaga.nvim",
  ["^null%-ls"] = "null-ls.nvim",
  ["^nvterm%.terminal"] = "NvTerm",
  ["^telescope"] = "telescope.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Setup for: gitsigns.nvim
time([[Setup for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\nG\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\18gitsigns.nvim\vloader\vpacker\frequireç\1\1\0\6\0\r\1\0266\0\0\0009\0\1\0009\0\2\0005\2\3\0006\3\0\0009\3\1\0039\3\4\3'\5\5\0B\3\2\2>\3\3\2B\0\2\0016\0\0\0009\0\6\0009\0\a\0\t\0\0\0X\0\t€6\0\0\0009\0\b\0009\0\t\0'\2\n\0B\0\2\0016\0\0\0009\0\v\0003\2\f\0B\0\2\1K\0\1\0\0\rschedule\21GitSignsLazyLoad\29nvim_del_augroup_by_name\bapi\16shell_error\6v\n%:p:h\vexpand\1\5\0\0\bgit\a-C\0\14rev-parse\vsystem\afn\bvim\0°\1\1\0\b\0\v\0\0166\0\0\0009\0\1\0009\0\2\0'\2\3\0005\3\a\0006\4\0\0009\4\1\0049\4\4\4'\6\5\0005\a\6\0B\4\3\2=\4\b\0033\4\t\0=\4\n\3B\0\3\1K\0\1\0\rcallback\0\ngroup\1\0\0\1\0\1\nclear\2\21GitSignsLazyLoad\24nvim_create_augroup\15BufReadPre\24nvim_create_autocmd\bapi\bvim\0", "setup", "gitsigns.nvim")
time([[Setup for gitsigns.nvim]], false)
-- Setup for: nvim-tree.lua
time([[Setup for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\nr\0\0\6\0\a\0\t6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\1K\0\1\0\1\0\1\tdesc\20Toggle NvimTree\28<Cmd>NvimTreeToggle<CR>\n<C-n>\6n\bset\vkeymap\bvim\0", "setup", "nvim-tree.lua")
time([[Setup for nvim-tree.lua]], false)
-- Setup for: telescope.nvim
time([[Setup for telescope.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\14telescope\rmappings\frequire\0", "setup", "telescope.nvim")
time([[Setup for telescope.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n¸\3\0\0\f\0\17\0G6\0\0\0'\2\1\0B\0\2\0029\1\2\0B\1\1\0016\1\3\0009\1\4\0019\1\5\1\15\0\1\0X\1\6€6\1\3\0009\1\4\0019\1\5\0019\1\6\1\14\0\1\0X\1\1€K\0\1\0009\1\a\0009\2\b\0B\2\1\0026\3\3\0009\3\4\0039\3\5\0039\3\6\0039\3\t\3\15\0\3\0X\4\19€6\3\n\0006\5\3\0009\5\4\0059\5\5\0059\5\6\0059\5\t\5B\3\2\4X\6\t€6\b\0\0'\n\v\0B\b\2\0028\b\a\b9\b\f\b5\n\r\0=\1\a\n=\2\14\nB\b\2\1E\6\3\3R\6õ\1276\3\3\0009\3\4\0039\3\5\0039\3\6\0039\3\15\3\15\0\3\0X\4\17€6\3\n\0006\5\3\0009\5\4\0059\5\5\0059\5\6\0059\5\15\5B\3\2\4X\6\a€6\b\0\0'\n\16\0B\b\2\0028\b\a\b\18\n\1\0\18\v\2\0B\b\3\1E\6\3\3R\6÷\127K\0\1\0\22config.lsp.custom\vcustom\17capabilities\1\0\0\nsetup\14lspconfig\vipairs\fdefault\21set_capabilities\14on_attach\fservers\blsp\6g\bvim\17lsp_handlers\15config.lsp\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
try_loadstring("\27LJ\2\n…\2\0\0\5\0\f\0\0196\0\0\0009\0\1\0009\0\2\0006\1\0\0009\1\3\1\4\0\1\0X\0\1€K\0\1\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\a\0005\3\b\0005\4\t\0=\4\n\3=\3\v\2B\0\2\1K\0\1\0\aui\nicons\1\0\3\20package_pending\tï†’ \22package_installed\tï˜² \24package_uninstalled\t ï®Š\1\0\1\vborder\frounded\1\0\2\30max_concurrent_installers\3\4\tPATH\tskip\nsetup\nmason\frequire\bNIL\fexiting\6v\bvim)\1\0\3\0\3\0\0056\0\0\0009\0\1\0003\2\2\0B\0\2\1K\0\1\0\0\rschedule\bvimÀ\1\1\0\6\0\14\0\0236\0\0\0009\0\1\0006\1\0\0009\1\1\0019\1\2\1'\2\3\0006\3\0\0009\3\4\0039\3\5\3'\5\6\0B\3\2\2'\4\a\0&\1\4\1=\1\2\0006\0\0\0009\0\b\0009\0\t\0'\2\n\0005\3\v\0003\4\f\0=\4\r\3B\0\3\1K\0\1\0\rcallback\0\1\0\1\tonce\2\fUIEnter\24nvim_create_autocmd\bapi\15/mason/bin\tdata\fstdpath\afn\6:\tPATH\benv\bvim\0", "config", "mason.nvim")
time([[Config for mason.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nÁ\1\0\2\t\0\b\1\0306\2\0\0009\2\1\0024\4\0\0\18\5\0\0B\2\3\2\15\0\2\0X\3\2€+\2\2\0L\2\2\0*\2\0\0006\3\2\0006\5\0\0009\5\3\0059\5\4\0056\6\0\0009\6\5\0069\6\6\6\18\b\1\0B\6\2\0A\3\1\3\15\0\3\0X\5\a€\15\0\4\0X\5\5€9\5\a\4\1\2\5\0X\5\2€+\5\2\0L\5\2\0K\0\1\0\tsize\22nvim_buf_get_name\bapi\ffs_stat\tloop\npcall\17tbl_contains\bvim€À\fÙ\b\1\0\6\0003\0C6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0+\1\1\0=\1\6\0006\0\a\0'\2\b\0B\0\2\0029\0\t\0005\2\n\0006\3\0\0009\3\v\0039\3\f\3'\5\r\0B\3\2\2'\4\14\0&\3\4\3=\3\15\0025\3\16\0=\3\17\0025\3\18\0=\3\19\0025\3\20\0003\4\21\0=\4\22\3=\3\23\0025\3\24\0004\4\0\0=\4\22\3=\3\25\0025\3\26\0005\4\27\0=\4\28\3=\3\29\0025\3\30\0=\3\31\0025\3 \0=\3!\0025\3\"\0=\3#\0025\3$\0004\4\0\0=\4\22\3=\3%\0025\3&\0005\4'\0=\4(\3=\3)\0025\3,\0005\4*\0005\5+\0=\5\28\4=\4-\0035\4.\0=\4/\0035\0040\0=\0041\3=\0032\2B\0\2\1K\0\1\0\16textobjects\tmove\1\0\1\venable\1\tswap\1\0\1\venable\1\vselect\1\0\0\1\0\4\aac\17@class.outer\aic\17@class.inner\aif\20@function.inner\aaf\20@function.outer\1\0\3#include_surrounding_whitespace\2\14lookahead\2\venable\2\17query_linter\16lint_events\1\3\0\0\fBufRead\15CursorHold\1\0\2\20use_diagnostics\2\venable\2\15playground\1\0\2\venable\2\15updatetime\0032\26context_commentstring\1\0\2\19enable_autocmd\1\venable\2\fmatchup\1\0\2\24include_match_words\2\venable\2\fautotag\1\0\1\venable\2\26incremental_selection\fkeymaps\1\0\4\21node_decremental\t<bs>\19init_selection\ng<cr>\22scope_incremental\v<S-CR>\21node_incremental\t<cr>\1\0\1\venable\2\vindent\1\0\1\venable\2\14highlight\fdisable\0\1\0\2\venable\2&additional_vim_regex_highlighting\1\19ignore_install\1\2\0\0\nlatex\21ensure_installed\1\4\0\0\bvim\blua\6c\23parser_install_dir\n/site\tdata\fstdpath\afn\1\0\1\17auto_install\2\nsetup\28nvim-treesitter.configs\frequire\15foldenable\31nvim_treesitter#foldexpr()\rfoldexpr\texpr\15foldmethod\6o\bvim\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'NvimTreeToggle', function(cmdargs)
          require('packer.load')({'nvim-tree.lua'}, { cmd = 'NvimTreeToggle', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-tree.lua'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('NvimTreeToggle ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSPlaygroundToggle', function(cmdargs)
          require('packer.load')({'playground'}, { cmd = 'TSPlaygroundToggle', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'playground'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSPlaygroundToggle ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Telescope', function(cmdargs)
          require('packer.load')({'telescope.nvim'}, { cmd = 'Telescope', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'telescope.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Telescope ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSCaptureUnderCursor', function(cmdargs)
          require('packer.load')({'playground'}, { cmd = 'TSCaptureUnderCursor', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'playground'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSCaptureUnderCursor ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Lspsaga', function(cmdargs)
          require('packer.load')({'lspsaga.nvim'}, { cmd = 'Lspsaga', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'lspsaga.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Lspsaga ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'NvimTreeClose', function(cmdargs)
          require('packer.load')({'nvim-tree.lua'}, { cmd = 'NvimTreeClose', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-tree.lua'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('NvimTreeClose ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType cpp ++once lua require("packer.load")({'nvim-dap'}, { ft = "cpp" }, _G.packer_plugins)]]
vim.cmd [[au FileType c ++once lua require("packer.load")({'nvim-dap'}, { ft = "c" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead * ++once lua require("packer.load")({'vim-matchup', 'indent-blankline.nvim', 'nvim-ts-context-commentstring', 'nvim-treesitter-textobjects'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'LuaSnip', 'nvim-cmp', 'nvim-ts-autotag'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au CmdlineEnter * ++once lua require("packer.load")({'LuaSnip', 'nvim-cmp'}, { event = "CmdlineEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'nvim-colorizer.lua'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
