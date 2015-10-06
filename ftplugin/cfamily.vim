colorscheme slate
highlight lCursor guifg=NONE guibg=SkyBlue

set expandtab 			" Табы в пробелы
set cindent
set tabstop=4
set shiftwidth=4

" Ищем Makefile где только можно - компилируем открытый файл, если не нашли
if !filereadable("Makefile")
	if !filereadable("../Makefile")
		if !filereadable("../build/Makefile")
			if expand('%:e') == 'c'
				set makeprg=gcc\ %\ -g\ -Og\ -pipe\ -Wall\ -pedantic
			else
				set makeprg=g++\ %\ -g\ -Og\ -pipe\ -Wall\ -pedantic\ -std=gnu++11
			endif
		else
			set makeprg=make\ -C\ ../build
		endif
	else
		set makeprg=make\ -C\ ../
	endif
endif

let &path = &path . "," . expand('%:p:h:h') . "/include"
