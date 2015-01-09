if exists('g:loaded_dropnotevim')
  finish
endif

let s:save_cpo = &cpo
set cpo&vim
command! -nargs=0 MakeStorm call dropnote#mkbase('','storm')
command! -nargs=0 MakeNote call dropnote#mknoteinput('','')
command! -nargs=0 MakeTodo call dropnote#mkbase('','todo')
command! -nargs=0 MakeBlog call dropnote#mkblog()

let g:loaded_dropnotevim = 1

let &cpo = s:save_cpo
unlet s:save_cpo
