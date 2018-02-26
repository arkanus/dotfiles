nnoremap <Leader>i :GoImports<CR>
nnoremap <Leader>t :GoTest<CR>

autocmd! BufWritePost,Bufenter * Neomake
