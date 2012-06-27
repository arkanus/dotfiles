"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Interfaz Gráfica
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme desert
syntax on
set nocp " Non compatible with legacy vi editor
set autoread "Automatically reload modified files

"Siempre una barra de estado visible
set laststatus=2

"Resaltar la línea en que se trabaja
set cursorline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle: Manejo de paquetes de plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/vundle.git/
call vundle#rc()

Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/The-NERD-Commenter'
Bundle 'vim-scripts/taglist.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'vim-scripts/The-NERD-tree.git'
Bundle 'honza/snipmate-snippets'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-surround'
Bundle 'fholgado/vim-autoclose'
Bundle 'vim-scripts/closetag.vim'
Bundle 'vim-scripts/AutoTag.git'
Bundle 'nanotech/jellybeans.vim'
Bundle 'ciaranm/inkpot'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
Bundle 'vim-scripts/grep.vim'
Bundle 'edsono/vim-matchit'
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'groenewege/vim-less'
Bundle 'xolox/vim-reload'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"no guardar backups (.swp)
"set nobackup
"set nowritebackup
set history=50
set showcmd
set incsearch
set ignorecase			"ignorar case por defecto
set smartcase			"Busquedas case sensitive solo si se usan mayusculas

"Only save buffers, tabs, split sizes and current dir on :mksession
set sessionoptions=buffers,tabpages,winsize,curdir


""" Display
set lazyredraw			"No redibujar cuando los script estan ejecutandose
set scrolloff=3			"Siempre mostrar 3 lineas bajo y sobre el cursor
set ruler				"Mostar numeros de linea

""" Command Line
set wildmenu

""" Mapeos
nmap <silent> <F11> <Plug>ToggleProject
nmap <F3> :NERDTreeToggle<CR>
nmap <S-F3> :NERDTreeMirror<CR>


"" Filtros para NERDTree
let NERDTreeIgnore = ['\.pyc','tags']

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

set tags+=~/.vim/tags,~/.vim/tags.php

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Esqueletos para distintos tipos de archivos
"" 		(se encuentran en ~/.vim/skel/tmpl.<tipo_de_archivo>)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"autocmd! BufNewFile * silent! 0r ~/.vim/skel/tmpl.%:e


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""Ajustes del plugin OmniCppComplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let OmniCpp_ShowScopeInAbbr = 1

" Opciones para autocompletación
set completeopt=preview,menu,menuone,longest

" Control+espacio para autocompletar
inoremap <C-space> <C-x><C-o>

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
		set ft=htmldjango.html
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

"" Settings para Vala
autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala            setfiletype vala
au BufRead,BufNewFile *.vapi            setfiletype vala

au BufRead,BufNewFile *.glsl setfiletype glsl

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mapeos Varios
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <Leader>h :set invhls <CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Funciones Varias
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuraciones de Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ruta de Script para  protodef
let g:protodefprotogetter='/home/marcos/.vim/pullproto.pl'

"Busca headers en la ruta absoluta pero reemplazando la palabra source por include
" ej: original home/aa/source/brah -> home/aa/include/brah
let b:fswitchlocs = 'reg:/source/include/'

""[ctrlp] Ignores some files
set wildignore+=*.pyc,*.swp,*.jpg,*.png,*.gif
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\.git$\|\.hg$\|\.svn$\|cache$\|log$',
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
"[CloseTag] to prevent error messages
let b:unaryTagsStack = []
