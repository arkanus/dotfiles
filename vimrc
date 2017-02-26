" vim: fdm=marker foldmarker={{,}} foldlevel=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings for Vim
"
" author: Marcos Sánchez
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vundle: Plugin package management without git externals! {{
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'critiqjo/vim-autoclose'
Plugin 'kien/ctrlp.vim'
Plugin 'klen/python-mode'
Plugin 'othree/yajs.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tsaleh/vim-align'
Plugin 'vim-scripts/The-NERD-tree.git'
Plugin 'vitapluvia/vim-gurl'

" Colorschemes
" Plugin 'KeitaNakamura/neodark.vim'
" Plugin 'crusoexia/vim-monokai'
" Plugin 'marcelbeumer/spacedust.vim'
Plugin 'tyrannicaltoucan/vim-quantum'

" Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

call vundle#end()
" }}

" GUI tweaks {{
if $TERM =~ '256color'
	colorscheme quantum
else
	colorscheme elflord
endif

if has("termguicolors")
	set termguicolors
endif

set backspace+=indent,start,eol
syntax on
set autoread "Automatically reload modified files
set autoindent
" set modeline=1
set modelines=1
set laststatus=2
set cursorline
" set ttym=xterm2 "make the mouse to work on iterm2 (osx)
set mouse=a
set visualbell
set t_vb=
"Avoid wait on the <ESC>O key combination
set ttimeoutlen=100
" Show character on line breaks
let &showbreak="↪️ "
" }}

" General {{
set number
set history=1000
set foldlevel=99		"Always unfold
set colorcolumn=80		"Highlight column 80
set showcmd
set clipboard=unnamed	"Use system clipboard
set incsearch
set ignorecase
set smartcase			"Case sensitive search only when the term has mixed cases
set wrap
set linebreak
"Only save tabs, split sizes and current dir on :mksession
"Excludes hidden buffers
set sessionoptions=tabpages,winsize,curdir
set lazyredraw
set scrolloff=3			"Always show at least 3 lines above/below cursor
set wildmenu
set tabstop=4
set shiftwidth=4
set nosmartindent
set tags+=./tags,~/.vim/tags,~/.vim/tags.php "Global tag files
set diffopt+=vertical	"Use vertical splits on diffs

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

"Encrypt
" set cm=blowfish2
" }}

" Keyboard Mappings {{
" Next/Prev quickfix mappings
nmap  <C-k> :cp<CR>
nmap  <C-j> :cn<CR>
" Toggle search result highlighting
map <Leader>h :set invhls <CR>
" Toggle mouse input (useful for terminal emulator copy/paste)
nnoremap <Leader>m :call ToggleMouse()<cr>
" Toggle paste mode (useful for terminal emulator copy/paste)
nnoremap <Leader>p :set paste!<cr>
" Toggle autoclose plugin
nmap <silent> <Leader>c :AutoCloseToggle<cr>
" Toggle line numbers
nmap <silent> <Leader>n :set number!<cr>
" Toggle NERDTree file explorer split
nmap <F3> :NERDTreeToggle<CR>
nmap <S-F3> :NERDTreeMirror<CR>
" Easy diff lines put/get
if &diff
	vnoremap < :diffget<CR>
	vnoremap > :diffput<CR>
endif
" comma to times for autocompletion
inoremap <Leader>, <C-x><C-o>

" jump to tag in new tab
:nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T
" }}

" Enable Persistent Undo {{
if exists("&undodir")
	set undofile
	set undodir=$HOME/.vim/undo
	set undolevels=1000
	set undoreload=10000
endif
" }}

" OmniCppComplete {{
let OmniCpp_ShowScopeInAbbr = 1
" Opciones para autocompletación
set completeopt=preview,menu,menuone,longest
" Lineas en el popup de omnicomplete
set pumheight=12
"cerrar automágicamente la ventana de preview
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
" }}

" UltiSnips {{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" }}

" NERDCommenter {{
" NERDCommenter desactiva los mensajes de error de tipos no soportados
let NERDShutUp=1
" Elimina los espacios posteriores a los caracteres de comentario
let NERDRemoveExtraSpaces=1
"}}
" NERDTree {{
" Ignore these files
let NERDTreeIgnore = ['\.pyc','^tags','\.o','\.a','\.gch','^CMakeFiles','^CMakeCache.txt','^cmake_install.cmake']

" }}

" Autocommands {{
" Use folding on XMLs
let g:xml_syntax_folding=1
au FileType xml,html setlocal foldmethod=syntax

"Abre todos los folds al abrir un archivo
au BufRead * normal zR

"crear tags para los archivos del directorio actual presionando <F12>
au Filetype python map <F12> :!ctags -R --python-kinds=-i --languages=Python . <CR>

" Scons is python!
au BufRead,BufNewFile SCons* setfiletype python

" SaltStack States are YAML
au BufRead,BufNewFile *.sls setfiletype yaml

"}}

" Various Functions {{

"" Recargar snippets SnipMate
function! ReloadSnippets()
	let ft = &filetype
    if strlen( ft ) == 0
        let filetype = "_"
    else
        let filetype = ft
    endif

    call ResetSnippets()
    call GetSnippets( g:snippets_dir, &filetype )
endfunction

function! ToggleMouse()
	if &mouse == 'a'
		set mouse=
		echo "Mouse usage disabled"
	else
		set mouse=a
		echo "Mouse usage enabled"
	endif
endfunction
"}}

" CtrlP {{
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
" }}

" Fugitive {{
" Adds git branch to the statusline
"set statusline=%{fugitive#statusline()}
set statusline=%{fugitive#statusline()}\ %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
" }}

" Pymode {{
" python mode dont show error window
let g:pymode_lint_cwindow = 0
let g:pymode_lint_write = 0
" don't add line numbers & other predefined stuff
let g:pymode_options_other = 0
" Dont fold python code when opening a file
let g:pymode_folding = 0
" let g:pymode_rope_guess_project = 0

" Disable python linting, prefer syntastic
let g:pymode_lint=0

" Override go-to.definition key shortcut to Ctrl-]
let g:pymode_rope_goto_definition_bind = "<C-]>"
let g:pymode_rope_goto_definition_cmd = 'e'
" }}

" Syntastic {{
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

" }}

" Vim-gurl {{
noremap <leader>gr :call Gurl()<CR>
" }}
