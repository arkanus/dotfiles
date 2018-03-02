nnoremap <Leader>i :GoImports<CR>
nnoremap <Leader>t :GoTest<CR>

autocmd! BufWritePost,Bufenter * Neomake

let g:neomake_go_gometalinter_args = ['--disable-all', '--enable=megacheck', '--enable=misspell', '--enable=golint', '--vendor']
