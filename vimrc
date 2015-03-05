"vim: set foldmethod=marker foldmarker={{,}} foldlevel=0 spell

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings for Vim
"
" author: Marcos Sánchez
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" GUI tweaks {{
set backspace+=indent,eol,start
syntax on
set nocp " Non compatible with legacy vi editor
set autoread "Automatically reload modified files
set autoindent

set laststatus=2
set cursorline

set ttym=xterm2 "make the mouse to work on iterm2 (osx)
set mouse=a

set visualbell
set t_vb=

"Avoid wait on the <ESC>O key combination
set ttimeoutlen=500

set modeline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle: Plugin package management without git externals!
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/vundle.git/
call vundle#rc()

"Bundle 'fholgado/minibufexpl' "This package is not formated well :/
Bundle 'altercation/vim-colors-solarized'
Bundle 'arkanus/snipmate-snippets'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'ciaranm/inkpot'
Bundle 'edsono/vim-matchit'
Bundle 'fholgado/vim-autoclose'
Bundle 'groenewege/vim-less'
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'kien/ctrlp.vim'
Bundle 'klen/python-mode'
Bundle 'mattn/emmet-vim'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'mivok/vimtodo'
Bundle 'msanders/snipmate.vim'
Bundle 'nanotech/jellybeans.vim'
Bundle 'scrooloose/syntastic'
Bundle 'tomasr/molokai'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/OmniCppComplete'
Bundle 'vim-scripts/The-NERD-tree.git'
Bundle 'vim-scripts/a.vim'
Bundle 'vim-scripts/closetag.vim'
Bundle 'vim-scripts/grep.vim'
Bundle 'ekalinin/Dockerfile.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

colorscheme molokai
"no guardar backups (.swp)
"set nobackup
"set nowritebackup
set history=1000
set showcmd
set incsearch
set ignorecase			"ignorar case por defecto
set smartcase			"Busquedas case sensitive solo si se usan mayusculas

"Wrap stuff
set wrap
set linebreak

"Only save tabs, split sizes and current dir on :mksession
"Excludes hidden buffers 
set sessionoptions=tabpages,winsize,curdir


""" Display
set lazyredraw			"No redibujar cuando los script estan ejecutandose
set scrolloff=3			"Siempre mostrar 3 lineas bajo y sobre el cursor
"set ruler				"Mostar numeros de linea

""" Command Line
set wildmenu


"" Filtros para NERDTree
let NERDTreeIgnore = ['\.pyc','^tags','\.o','\.a','\.gch','^CMakeFiles','^CMakeCache.txt','^cmake_install.cmake']

if &diff
	" Manejo sencillo de diff
	vnoremap < :diffget<CR>
	vnoremap > :diffput<CR>
endif


" Applies filetype plugins
filetype plugin on

" Aplies indentation options specified in ftplugins
filetype plugin indent on

" Sets an easier to press leader key
let mapleader = ","

"Syntaxis coloreada
syntax on

"Identación
"set expandtab
set tabstop=4
set shiftwidth=4
set nosmartindent

set tags+=./tags,~/.vim/tags,~/.vim/tags.php

" Enable Persistent Undo {{{
if exists("&undodir")
	set undofile
	set undodir=$HOME/.vim/undo
	set undolevels=1000
	set undoreload=10000
endif
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""Ajustes del plugin OmniCppComplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let OmniCpp_ShowScopeInAbbr = 1

" Opciones para autocompletación
set completeopt=preview,menu,menuone,longest

" Lineas en el popup de omnicomplete
set pumheight=12

" Control+espacio para autocompletar
"inoremap <C-space> <C-x><C-o>
nmap  <C-k> :cp<CR>
nmap  <C-j> :cn<CR>

"cerrar automágicamente la ventana de preview
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" NERDCommenter desactiva los mensajes de error de tipos no soportados
let NERDShutUp=1
" Elimina los espacios posteriores a los caracteres de comentario
let NERDRemoveExtraSpaces=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Yummy functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searchs up the dir tree for manage.py and apply htmldjango filetype
fun! DetectDjango()
	if findfile('manage.py', expand('%:p').';') != ''
		setlocal ft=htmldjango.html
	endif
endf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands varios
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Activar folding en los XML
let g:xml_syntax_folding=1
au FileType xml,html setlocal foldmethod=syntax

" Abre todos los folds al abrir un archivo
au BufRead * normal zR

"crear tags para los archivos del directorio actual presionando <F12>
au Filetype python map <F12> :!ctags -R --python-kinds=-i --languages=Python . <CR>
" Sets django filetype for all pytohn files
au Filetype python set ft=python.django

au Filetype html exec DetectDjango()

" Bad whitespace
highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" File type extensions {{
autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala setfiletype vala
au BufRead,BufNewFile *.vapi setfiletype vala
au BufRead,BufNewFile *.glsl setfiletype glsl
au BufRead,BufNewFile *.md setfiletype markdown
" }}

" Scons is python!
au BufRead,BufNewFile SCons* setfiletype python

" Disable valadoc syntax highlight
"let vala_ignore_valadoc = 1

" Enable comment strings
let vala_comment_strings = 1

" Highlight space errors
"let vala_space_errors = 1
" Disable trailing space errors
"let vala_no_trail_space_error = 1
" Disable space-tab-space errors
let vala_no_tab_space_error = 1

" Minimum lines used for comment syncing (default 50)
"let vala_minlines = 120

" Misc Mappings {{{

map <Leader>h :set invhls <CR>
noremap <Leader>t :noautocmd vimgrep /\CTODO/j **/*.py<CR> :cw<CR>
nnoremap <Leader>m :call ToggleMouse()<cr>
nnoremap <Leader>p :set paste!<cr>
nmap <silent> <F11> <Plug>ToggleProject
nmap <silent> <Leader>c :AutoCloseToggle<cr>
nmap <F3> :NERDTreeToggle<CR>
nmap <S-F3> :NERDTreeMirror<CR>
nnoremap cj :cnext<CR>
nnoremap ck :cprev<CR>

" Various Functions {{{

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
"}}}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configurations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ruta de Script para  protodef
let g:protodefprotogetter='/home/marcos/.vim/pullproto.pl'

"Busca headers en la ruta absoluta pero reemplazando la palabra source por include
" ej: original home/aa/source/brah -> home/aa/include/brah
let b:fswitchlocs = 'reg:/source/include/'

""[ctrlp] Ignores some files
set wildignore+=*.pyc,*.swp,*.jpg,*.png,*.gif,*.o,*.so,*.gch
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\.git$\|\.hg$\|\.svn$\|cache$\|log$\|ninja_build$\|regress_final$',
	\ 'file': '\.exe$\|\.so$\|\.dll$',
	\ 'link': '',
	\ }
let g:ctrlp_extensions = ['tag', 'buffertag']

""[fugitive] Adds git branch to the statusline 
"set statusline=%{fugitive#statusline()}
set statusline=%{fugitive#statusline()}\ %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

"[Ctrl-P] Only start searching when input stop (in ms)
let g:ctrlp_lazy_update = 250
"[Ctrl-P] Max depth to search files
let g:ctrlp_max_depth = 20
"[Ctrl-P] Disable max number of file to index
let g:ctrlp_max_files = 0

"python mode dont show error window
let g:pymode_lint_cwindow = 0
let g:pymode_lint_write = 0
"don't add line numbers & other predefined stuff
let g:pymode_options_other = 0
"Dont fold python code when opening a file
let g:pymode_folding = 0
"Rope vim autoimport some modules
let g:ropevim_autoimport_modules = ["os.*", "traceback", "logging", "pdb"]
"make project dir in current dir (spped up rope)
let g:rope_guess_project = 0
"For some reason this doesnt work, but loking at the code, it should
"let g:pymode_rope_autoimport_modules = ['os', 'os.path', 'traceback', 'logging', 'pdb']


"" Syntastic

" include some standard cpp header locations
let g:syntastic_c_include_dirs=['src', 'src/include']
let g:syntastic_cpp_include_dirs=['src', 'src/include']
