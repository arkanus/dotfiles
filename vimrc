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

Plug 'critiqjo/vim-autoclose'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'sheerun/vim-polyglot' " lots syntax and language settings
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'ciaranm/securemodelines'
Plug 'itchyny/lightline.vim'

" Langs
Plug 'othree/yajs.vim', {'for': 'javascript'}
Plug 'sirtaj/vim-openscad'
Plug 'b4b4r07/vim-hcl' " syntax for hashi-stuff

" Golang
" Plug 'fatih/vim-go', {'for': 'go'}
Plug 'jodosha/vim-godebug', {'for': 'go'}


" Fuzzy finder using fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" CoC stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/vista.vim'

" Colorschemes {{{
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'whatyouhide/vim-gotham',  {  'as': 'gotham' }
" }}}

call plug#end()
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

" Keyboard Mappings {{{

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

" Vim-Go {{{
let g:go_def_mode = 'godef'
let g:go_rename_command = 'gopls'
" }}}

" Conqueror of Completion {{{

" if hidden is not set, TextEdit might fail.
set hidden

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> ggd :vs<cr><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> gs :CocList symbols<cr>

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <leader><C-d> <Plug>(coc-range-select)
xmap <silent> <leader><C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR> 

" }}} EOC Conqueror of Completion
