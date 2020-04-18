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

Plug 'b4b4r07/vim-hcl' " syntax for hashi-stuff
Plug 'critiqjo/vim-autoclose'
Plug 'kien/ctrlp.vim'
Plug 'othree/yajs.vim', {'for': 'javascript'}
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot' " lots syntax and language settings
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
" Plug 'tsaleh/vim-align'
" Plug 'vitapluvia/vim-gurl'
" Plug 'junegunn/vim-emoji'
Plug 'sirtaj/vim-openscad'
" Plug 'craigemery/vim-autotag'
Plug 'ciaranm/securemodelines'

" CoC stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/vista.vim'

" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'

" Open Github for file
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'

" Python
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'jmcantrell/vim-virtualenv', {'for': 'python'}
Plug 'klen/python-mode', {'for': 'python'}

" Golang
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'jodosha/vim-godebug', {'for': 'go'}

" Colorschemes
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'yuttie/hydrangea-vim'
Plug 'skielbasa/vim-material-monokai'
Plug 'mhartington/oceanic-next'
Plug 'connorholyday/vim-snazzy'
Plug 'dracula/vim', { 'as': 'dracula' }

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()
" }}}
"
" General {{{
set number
set history=1000
set foldlevel=99        "Always unfold
set colorcolumn=80        "Highlight column 80
set showcmd
set clipboard+=unnamedplus    "Use system clipboard
set incsearch
set ignorecase
set smartcase            "Case sensitive search only when the term has mixed cases
set wrap
set linebreak
"Only save tabs, split sizes and current dir on :mksession
"Excludes hidden buffers
set sessionoptions=tabpages,winsize,curdir
set lazyredraw
set scrolloff=3            "Always show at least 3 lines above/below cursor
set wildmenu
set tabstop=4
set shiftwidth=4
set nosmartindent
set tags+=./tags,~/.vim/tags,~/.vim/tags.php "Global tag files
set diffopt+=vertical    "Use vertical splits on diffs

set backupdir=~/.vim/backup,.,/tmp
set directory=~/.vim/backup,.,/tmp

" Applies filetype plugins
filetype plugin on
" Applies indentation options specified in ftplugins
filetype plugin indent on
" Sets an easier to press leader key
let mapleader = ","
"Syntaxis coloreada
syntax on

" Hightlight trailing whitespaces on lines
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" let g:python3_host_prog = string(system('which python3'))
let g:loaded_python_provider = 0
let g:python3_host_prog = '/usr/bin/python3'

"Encrypt
" set cm=blowfish2
" }}}

" Enable Persistent Undo {{{
if exists("&undodir")
    set undofile
    set undodir=$HOME/.vim/undo
    set undolevels=1000
    set undoreload=10000
endif
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

" }}}

" Autocommands {{{
" Use folding on XMLs
let g:xml_syntax_folding=1
au FileType xml,html setlocal foldmethod=syntax

"Abre todos los folds al abrir un archivo
au BufRead * normal zR

" Scons is python!
au BufRead,BufNewFile SCons* setfiletype python

" SaltStack States are YAML
au BufRead,BufNewFile *.sls setfiletype yaml

" don't show full path when opening files relative path
" sometimes popening files with tree explorer or opening a dir causes this
autocmd BufReadPost * silent! lcd .

" }}}

" GUI tweaks {{{
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

if has("termguicolors")
    set termguicolors
endif

if $TERM =~ '256color'
    colorscheme dracula
else
    colorscheme elflord
endif

set backspace+=indent,start,eol
syntax on
set autoread "Automatically reload modified files
set autoindent
set modelines=1
set laststatus=2
set cursorline
set mouse=a
set visualbell
"Avoid wait on the <ESC>O key combination
set ttimeoutlen=100
" Show character on line breaks
let &showbreak="↪️ "
" }}}

" LightLine {{{
let g:lightline = {
	\ 'colorscheme': 'one',
\ }
" }}}

" UltiSnips {{{
let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" }}}

" NERDTree {{{
" Ignore these files
let NERDTreeIgnore = ['\.pyc','^tags','\.o','\.a','\.gch','^CMakeFiles','^CMakeCache.txt','^cmake_install.cmake']

" }}}

" CtrlP {{{
" Ignore some files
set wildignore+=*.pyc,*.swp,*.jpg,*.png,*.gif,*.o,*.so,*.gch
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.git$\|\.hg$\|\.svn$\|cache$\|log$\|ninja_build$\|regress_final|node_modules|bower_components)$',
    \ 'file': '\.exe$\|\.so$\|\.dll$',
    \ 'link': '',
    \ }
let g:ctrlp_extensions = ['tag', 'buffertag']
" Only start searching when input stop (in ms)
let g:ctrlp_lazy_update = 250
" Max depth to search files
let g:ctrlp_max_depth = 20
" Disable max number of file to index
let g:ctrlp_max_files = 0
" }}}

" Pymode {{{
" python mode dont show error window
let g:pymode_lint_cwindow = 0
let g:pymode_lint_write = 0
" don't add line numbers & other predefined stuff
let g:pymode_options_other = 0
" Dont fold python code when opening a file
let g:pymode_folding = 0
let g:pymode_rope_regenerate_on_write = 0
" let g:pymode_rope_guess_project = 0

" Disable python linting, prefer syntastic
let g:pymode_lint=0

" Override go-to.definition key shortcut to Ctrl-]
let g:pymode_rope_goto_definition_bind = "<C-]>"
let g:pymode_rope_goto_definition_cmd = 'e'
" }}}

" Syntastic {{{
" include some standard cpp header locations
let g:syntastic_c_include_dirs=['src', 'src/include']
let g:syntastic_cpp_include_dirs=['src', 'src/include']
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": [],
    \ "passive_filetypes": ["go"] }

" Python
let g:syntastic_python_python_exec = '/usr/local/bin/python3'
let g:syntastic_python_checkers = ['flake8']

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_style_error_symbol = "✖︎"
let g:syntastic_style_warning_symbol = "▶︎"
" }}}

" Vim-Go {{{
let g:go_def_mode = 'godef'
let g:go_rename_command = 'gopls'
" }}}

" Conqueror of Completion {{{

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

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

" tyru/open-browser-github.vim {{{
let g:openbrowser_github_url_exists_check="ignore"
xmap <silent> <leader>gh :'<,'>OpenGithubFile<cr><cr>
nmap <silent> <leader>gh V:'<,'>OpenGithubFile<cr><cr>
" }}}
