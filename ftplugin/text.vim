set showbreak=
set iminsert=1
set nonumber

function! Count()
  execute "tabnew ./temp"
  normal "+gP
  execute "w"
  let symbCount = system( 'wc -m ./temp' )
  let symbCount = strpart( symbCount, 1, match(symbCount, ' ') )
  execute "q!"
  let @a = symbCount
  normal "api символов
  call system( 'rm ./temp' )
endfunction

nmap <leader>c :call Count()<CR>
