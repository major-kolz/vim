colorscheme slate
highlight lCursor guifg=NONE guibg=SkyBlue

set expandtab 			" Табы в пробелы
set cindent
set tabstop=4
set shiftwidth=4

" Ищем Makefile где только можно - жалуемся, если ничего не вышло
if !filereadable("Makefile")
	if !filereadable("../Makefile")
		if !filereadable("../build/Makefile")
			if expand('%:e') == 'c'
				set makeprg=gcc\ %\ -g\ -O2\ -pipe\ -Wall\ -pedantic 
			else
				set makeprg=g++\ %\ -g\ -O2\ -pipe\ -Wall\ -pedantic\ -std=gnu++11
			endif
		else
			set makeprg=make\ -C\ ../build
		endif
	else
		set makeprg=make\ -C\ ../
	endif
endif
" Открытие терминала

let &path = &path . "," . expand('%:p:h:h') . "/include"

" Syntastic settings
let g:syntastic_cpp_compiler = 'g++'
" -Og - оптимизация для debug'a
let g:syntastic_cpp_compiler_options = '-g -Og -pipe -Wall -pedantic -std=gnu++11'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
