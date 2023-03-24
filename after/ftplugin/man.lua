vim.keymap.set("n", "<leader>x", function() 
  require("config.ui.tabline.utils").close_buffer()
  if #vim.api.nvim_tabpage_list_wins(0) > 1 then
    vim.cmd.q()
  end
end, { 
  buffer = 0,
})
