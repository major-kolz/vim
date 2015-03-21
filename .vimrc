set nocompatible
syntax on

"{ Vim-Plug 
if empty(glob("~/.vim/autoload/plug.vim"))   " Автоматическая установка
    execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')
Plug 'Raimondi/delimitMate'                  " Автоматическое закрытие скобок и кавычек
Plug 'tpope/vim-surround'                    " Создание/замена/добавление 'окружающих' элементов
Plug 'altercation/vim-colors-solarized'      " Цветовая схема http://ethanschoonover.com/solarized
Plug 'simnalamburt/vim-mundo'                " Древовидная 'отмена' (undo)
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'vim-scripts/DoxygenToolkit.vim', { 'for': ['c', 'cpp', 'python'] }
Plug 'vim-scripts/DoxyGen-Syntax', { 'for': ['c', 'cpp', 'java'] }
Plug 'klen/python-mode', {'for': 'python'}
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'derekwyatt/vim-scala', {'for': 'scala'}
Plug 'major-kolz/vim-instead', {'for': 'lua'}
call plug#end()

" Brief help
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
set lcs=tab:_ ,trail:◦,eol:¬	" Задаем вид непечатных символов: trail - лишние пробелы в конце
set lazyredraw						" Не перерисовывать экран без необходимости
let mapleader=';'					" Лидер - клавиша, с которой начинаются пользовательские комбинации символов
au FocusLost * :wa				" Авто-сохранение при потере фокуса

"=== For mundo plugin. Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undo

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
set autoindent						" Копирует отступы с текущей строки при добавлении новой 
set wrap								" Включаем перенос строк
set linebreak							" Перенос строк по словам, а не по буквам
set showbreak=▸\ \ 					" Помечать перенос вот таким треугольником и двумя пробелами
au FileType Makefile set noexpandtab


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
au BufNewFile,BufRead *.book setfiletype text " text - predefined category
au Filetype c,cc,cpp,h,hpp runtime! ftplugin/cfamily.vim

" Дополнительный, специфические для разных типов файлов настройки лежат в ~/.vim/ftplugin
