set nocompatible
syntax on
filetype off                  " vundle required

"{ Vundle 
set rtp+=~/.vim/bundle/Vundle.vim/	"setup set the runtime path to include Vundle and initialize
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'vim-scripts/DoxyGen-Syntax'
Plugin 'sjl/gundo.vim'
Plugin 'klen/python-mode'
Plugin 'davidhalter/jedi-vim'
Plugin 'file:///home/major/.vim/excelenter-vim-instead'
Plugin 'derekwyatt/vim-scala'
Plugin 'tpope/vim-surround'
Plugin 'Raimondi/delimitMate'

"=== Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins

call vundle#end()
"} Vundle end

"=== Общее
filetype plugin indent on
set history=70 					" Sets how many lines of history VIM has to remember
set autoread						" Set to auto read when a file is changed from the outside
set showcmd							" Вводимая команда отображается в нижнем правом углу экрана
set spell spelllang=ru,en		" Правописание
set fileencodings=utf-8,cp1251 "Распознавание кодировок
set nobackup                  " Не создавать файлы с резервной копией (filename.txt~)
set history=50                " Сохранять 50 строк в истории командной строки
set visualbell                " Экран мигает на ошибки
set number							" Нумерация строк
set lcs=tab:_ ,trail:◦			" Задаем вид непечатных символов: trail - лишние пробелы в конце
set lazyredraw						" Не перерисовывать экран без необходимости
let mapleader=';'					" Лидер - клавиша, с которой начинаются пользовательские комбинации символов
au FocusLost * :wa				" Авто-сохранение при потере фокуса

"=== Клавиатура
set keymap=prog-dvorak			" Правленый dvorak-jcuken 
set iminsert=0                " Раскладка по-умолчанию: английская
set imsearch=0
highlight lCursor guifg=NONE guibg=DarkRed

"=== Принудительного разворачивания нового сниппета (vim-snipmate) 
imap <C-Tab> <Plug>snipMateTrigger 
"=== Сохранить 
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a
"=== Выход
nmap <C-q> :q<CR>
imap <C-q> <Esc>:q<CR>
"=== Для разворачивания скобок с курсором посередине
imap <C-Cr> <Cr><Esc>O<Tab>
"--- Включение\выключение относительной нумерации (удобно при замене на фрагменте текста)
nmap <leader>n :set rnu<CR>
nmap <leader>N :set nornu<CR>
"--- Подсветка непечатных символов
nmap <leader>l :set list<CR>
nmap <leader>L :set nolist<CR>
"--- Запуск Gundo
nmap <leader>g :GundoToggle<CR>

"=== Форматирование текста
set smarttab						" Табы в начале строки
set ai
set tabstop=3
set shiftwidth=3
au FileType Makefile set noexpandtab
set autoindent						" Копирует отступы с текущей строки при добавлении новой 
set wrap								" Включаем перенос строк
set linebreak							" Перенос строк по словам, а не по буквам
set showbreak=▸\ \ 					" Помечать перенос вот таким треугольником и двумя пробелами


"=== Окно
if has("gui_running")
	set lines=100
	set columns=133
endif

"=== Поиск
set hlsearch						" Highlight search terms (very useful!)
set incsearch						" Show search matches while typing

"=== Запоминаем позицию курсора
autocmd! bufreadpost * call LastPosition()
     function! LastPosition()
         if line("'\"") && line("'\"")<=line('$')
             normal! `"
        endif
endfunction

autocmd VimLeave * nested if (!isdirectory($HOME . "/.vim")) |
    \ call mkdir($HOME . "/.vim") |
    \ endif |
    \ execute "mksession! " . $HOME . "/.vim/Session.vim"

autocmd VimEnter * nested if argc() == 0 && filereadable($HOME . "/.vim/Session.vim") |
    \ execute "source " . $HOME . "/.vim/Session.vim"

au BufNewFile,BufRead *.doxygen setfiletype doxygen
au BufNewFile,BufRead *.book,*.txt setfiletype txt
au Filetype c,cc,cpp,h,hpp runtime! ftplugin/cfamily.vim

" Дополнительный, специфические для разных типов файлов настройки лежат в ~/.vim/ftplugin
