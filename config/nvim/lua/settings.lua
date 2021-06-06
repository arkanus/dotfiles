-- local o = vim.o
-- local wo = vim.wo
-- local bo = vim.bo

-- global options

local function setOptions(options)
    for key, val in pairs(options) do
        vim.o[key] = val
    end
end

setOptions {
    backup = false,
    clipboard = 'unnamedplus',
    completeopt = 'menu,menuone,noselect',
    cursorline = true,
    dir = '/tmp',
    expandtab = true,
    ignorecase=true,
    lazyredraw = true,
    mouse = 'a',
    number=true,
    relativenumber=true,
    shiftwidth = 2,
    showtabline = 2,
    smartcase = true,
    swapfile = true,
    tabstop = 2,
    termguicolors = true,
    undodir = '$HOME/.cache/nvim/undo',
    undolevels = 500,
    updatetime = 300,
    wrap = true,
    writebackup = false,
}

vim.cmd('let mapleader=","')
vim.cmd('nmap <leader>j :cnext<cr>')

vim.cmd("set number relativenumber")

vim.wo.signcolumn = "yes"
