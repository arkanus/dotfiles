"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Interfaz Gráfica
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on

"Sacar los menus "despegables" y la barra de herramientas
set guioptions-=tT

"Esquema de color
colorscheme desert
"colorscheme kib_darktango
"colorscheme darkZ
"colorscheme wombat

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
"Bundle 'vim-scripts/snippetsEmu'
Bundle 'vim-scripts/The-NERD-Commenter'
Bundle 'vim-scripts/taglist.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'vim-scripts/The-NERD-tree.git'
Bundle 'honza/snipmate-snippets'
"Bundle 'robhudson/snipmate_for_django'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-surround'
Bundle 'Townk/vim-autoclose'
Bundle 'vim-scripts/closetag.vim'
Bundle 'vim-scripts/AutoTag.git'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"no guardar backups (.swp)
set nobackup
set nowritebackup
set history=50
set showcmd
set incsearch
set ignorecase			"ignorar case por defecto
set smartcase			"Busquedas case sensitive solo si se usan mayusculas


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
let NERDTreeIgnore = ['\.pyc',]

if &diff
	" Manejo sencillo de diff
	vnoremap < :diffget<CR>
	vnoremap > :diffput<CR>
endif


"Aplica plguins según tipo de fichero
filetype plugin on

"Aplica opciones de indentacion segun el tipo de archivo
filetype plugin indent on

" Setear la tecla leader
"let mapleader = ","

"Syntaxis coloreada
syntax on

"Cambiar automágicamente al directorio del archivo a editar
"set autochdir

"Identación
"set expandtab
set tabstop=4

""Indentado al estilo C
"set cindent

set shiftwidth=4

set nosmartindent
"set noexpandtab

set tags+=~/.vim/tags,~/.vim/tags.php

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Esqueletos para distintos tipos de archivos
"" 		(se encuentran en ~/.vim/skel/tmpl.<tipo_de_archivo>)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd! BufNewFile * silent! 0r ~/.vim/skel/tmpl.%:e

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Activar folding en los XML
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
" Abre todos los folds al abrir un archivo
au BufRead * normal zR

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""Ajustes del plugin OmniCppComplete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocp
map <C-F12> :!ctags -R -f ~/.vim/tags --c++-kinds=+p --fields=+iaS --extra=+q --languages=c++,c,php /usr/include /usr/local/include /usr/share/php <CR>
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --languages=c++,c . <CR>

map <Leader>h :set invhls <CR>

"" crear tags para todos los lenguajes
"map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q . <CR>

let OmniCpp_ShowScopeInAbbr = 1

" Opciones para autocompletación
set completeopt=preview,menu,menuone,longest

" Control+espacio para autocompletar
inoremap <C-space> <C-x><C-o>

"cerrar automágicamente la ventana de preview
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

""" Variable de entorno para poder autocompletar cosas de django
"let $DJANGO_SETTINGS_MODULE = 'settings'

"" SnippetsEmu -- estamos usando django superior a 2
let django_version = 1

"" Setear la tecla de code_complete
let g:completekey = "<S-tab>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VTreeExplorer: explorador de archivos
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" abrir el exlorador en una división vertical
let treeExplVertical=1

" Expresión regular para archivos ocultos:
" actualmente:
" * archivos ocultos (.*.*) --por defecto--
" * bytecode python (*.pyc)
let treeExplHidePattern= '^.*\.\(pyc\)$'

" Los directorios van primero en la lista
let treeExplDirSort=1

" NERDCommenter desactiva los mensajes de error de tipos no soportados
let NERDShutUp=1
" Elimina los espacios posteriores a los caracteres de comentario
let NERDRemoveExtraSpaces=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands varios
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"setear filetypes para usar snippets
au Filetype htmldjango set ft+=.html.django_template
au Filetype python set ft+=.django

"crear tags para los archivos del directorio actual presionando <F12>
au Filetype python map <F12> :!ctags -R --python-kinds=-i --languages=Python . <CR>

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

"" Ctrl P 

" ignora algunos archivos
set wildignore+=*.pyc,*.swp,*.jpg,*.png,*.gif
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\.git$\|\.hg$\|\.svn$',
	\ 'file': '\.exe$\|\.so$\|\.dll$',
	\ 'link': '',
	\ }
let g:ctrlp_extensions = ['tag', 'buffertag']

