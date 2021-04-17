local function setKeyMaps(maps)
    for i, map in ipairs(maps) do
        vim.cmd(map)
    end
end

setKeyMaps {
    "nmap <c-j> :cnext<cr>",
    'nmap <c-k> :cprev<cr>',
}
