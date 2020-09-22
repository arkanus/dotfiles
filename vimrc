" vim: fdm=marker foldlevel=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings for Vim
"
" author: Marcos Sánchez
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Plug: plugin manager! {{{
set nocompatible
filetype off
call plug#begin('~/.vim/plugged')

" Actual useful plugins
Plug 'critiqjo/vim-autoclose'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'sheerun/vim-polyglot' " lots syntax and language settings
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'ciaranm/securemodelines'
Plug 'itchyny/lightline.vim'
Plug 'neovim/nvim-lspconfig'

" Langs
Plug 'othree/yajs.vim', {'for': 'javascript'}
Plug 'sirtaj/vim-openscad'
Plug 'b4b4r07/vim-hcl' " syntax for hashi-stuff

" Golang
Plug 'jodosha/vim-godebug', {'for': 'go'}

" Fuzzy finder using fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Colorschemes {{{
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'whatyouhide/vim-gotham',  {  'as': 'gotham' }
" }}}

call plug#end()
" }}}

" Neovim LSP {{{
autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" }}}

" General {{{

set number
set history=1000
set foldlevel=99					"Always unfold
set colorcolumn=80					"Highlight column 80
set showcmd
set clipboard+=unnamedplus			"Use system clipboard
set incsearch
set ignorecase
set smartcase
set nowrap
set linebreak
set lazyredraw
set scrolloff=3 	"Always show at least 3 lines above/below cursor
set tabstop=4
set shiftwidth=4
set nosmartindent
set backspace+=indent,start,eol
set autoread "Automatically reload modified files
set autoindent
set modelines=1
set laststatus=2
set cursorline
set mouse=a
set visualbell

set ttimeoutlen=100 "Avoid wait on the <ESC>O key combination

set nobackup
set undofile
set undodir=$HOME/.vim/undo

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

if has("termguicolors")
    set termguicolors
endif

" Show character on line breaks
let &showbreak="↪️ "

" Applies filetype plugins
filetype plugin on
" Applies indentation options specified in ftplugins
filetype plugin indent on
" Sets an easier to press leader key
let mapleader = ","
"Syntaxis coloreada
syntax on

colorscheme gotham

" Hightlight trailing whitespaces on lines
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" }}}


" Next/Prev quickfix mappings
nmap  <C-k> :cp<CR>
nmap  <C-j> :cn<CR>
" Toggle search result highlighting
map <Leader>h :set invhls <CR>
" Toggle mouse input (useful for terminal emulator copy/paste)
nnoremap <Leader>mo :call ToggleMouse()<cr>
" Toggle autoclose plugin
nmap <silent> <Leader>c :AutoCloseToggle<cr>
" Toggle NERDTree file explorer split
nmap <Leader>3 :NERDTreeToggle<CR>
" nmap <S-F3> :NERDTreeMirror<CR>
" Easy diff lines put/get
if &diff
    vnoremap < :diffget<CR>
    vnoremap > :diffput<CR>
endif

" jump to tag in new tab
nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T

" fzf search
nnoremap <C-p> :Files<cr>
nnoremap <C-g> :GFiles<cr>

" terminal to normal mode
tnoremap <leader><esc> <C-\><C-n>
" }}}

" LightLine {{{
let g:lightline = {
	\ 'colorscheme': 'one',
\ }
" }}}

" NERDTree {{{
" Ignore these files
let NERDTreeIgnore = ['\.pyc','^tags','\.o','\.a','\.gch','^CMakeFiles','^CMakeCache.txt','^cmake_install.cmake']

" }}}
