if exists('g:loaded_dropnotevim')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim
command! -nargs=0 MakeStorm call dropnote#mkstorm()
command! -nargs=0 MakeStormOpen call dropnote#mkstormo()
command! -nargs=0 MakeStormMonth call dropnote#mkstormmonth()
command! -nargs=0 MakeStormMonthOpen call dropnote#mkstormmontho()
command! -nargs=0 MakeNote call dropnote#mknoteinput('','')
command! -nargs=0 MakeTodo call dropnote#mktodo()
command! -nargs=0 MakeBlog call dropnote#mkblog()

let g:loaded_dropnotevim = 1
if empty(g:global_notes_dir)
    let g:global_notes_dir = expand('$HOME/Desktop/notes')
endif

let &cpo = s:save_cpo
unlet s:save_cpo
