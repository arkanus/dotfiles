require('plugins')
require('lsp-config')

local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- global options
o.swapfile = true
o.dir = '/tmp'
o.smartcase = true
o.termguicolors = true
o.mouse = 'a'

vim.cmd('let g:nvcode_termcolors=256')
vim.cmd('colorscheme one-nvim')
