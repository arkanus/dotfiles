function setKeyMaps(maps)
    for i, map in ipairs(maps) do
        vim.cmd(map)
    end
end

setKeyMaps {
  -- " Find files using Telescope command-line sugar.
  "nnoremap <leader>ff <cmd>Telescope find_files<cr>",
  "nnoremap <leader>fg <cmd>Telescope live_grep<cr>",
  "nnoremap <leader>fb <cmd>Telescope buffers<cr>",
  "nnoremap <leader>fh <cmd>Telescope help_tags<cr>",
  "nnoremap <leader>fl <cmd>Telescope git_files<cr>",

}
