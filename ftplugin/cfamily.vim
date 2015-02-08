colorscheme slate
highlight lCursor guifg=NONE guibg=SkyBlue

set expandtab 			" Табы в пробелы
set cindent
set tabstop=4
set shiftwidth=4

" If some kind of C/C++ file is opened, check for Makefile and:
" - if file is present, bind F5 to make
" - if file is absent, bind F5 to "make without Makefile"
" In any case, if compilation wasn't successful, error list will be displayed
" http://habrahabr.ru/blogs/vim/40369/
if filereadable("Makefile")
  set makeprg=make
	map <f5>      :w<cr>:make<cr>:cw<cr>
  imap <f5> <esc>:w<cr>:make<cr>:cw<cr>
else
	map <f5>      :w<cr>:make %:r<cr>:cw<cr>
  imap <f5> <esc>:w<cr>:make %:r<cr>:cw<cr>
endif

echo "yes, baby"
