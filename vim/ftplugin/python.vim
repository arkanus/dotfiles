
setlocal nosmartindent
setlocal smarttab
setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

"F2 to PyLint only in python buffers
"<buffer> references the current buffer, see _h map-local
nmap <buffer> <F2> :PyLint<CR>
nmap <buffer> <C-F2> :PyLintWindowToggle<CR>

setlocal complete+=t
setlocal formatoptions-=t
setlocal nonumber
setlocal nowrap
setlocal textwidth=79

"Variable to allow autocomplete of Django things
let DJANGO_SETTINGS_MODULE = 'settings'
