if exists("g:loaded_drop_note")
    finish 
endif
let g:loaded_drop_note = 1

let s:save_cpo = &cpo
set cpo&vim

let s:local_edit_mode = 'tabedit'
let s:notes_dir = '~/Dropbox/notes'

function! s:mkblog()
    call s:mknoteinput('blog','blog')
endfunction

function! s:mknoteinput(cate,ex)
    let l:dir = s:notes_dir
    if !empty(a:cate)
        let l:dir = l:dir . '/' . a:cate
    endif
    call s:echodirectory(l:dir)

    let l:cate= a:cate
    let l:subcate = ''
    let l:tmpimt = input('Category:')
    if empty(l:cate)
        let l:cate = l:tmpimt
    else
        let l:subcate = l:tmpimt
    endif

    let l:tmpdir = l:dir  . '/' . l:subcate
    call s:echodirectory(l:tmpdir)

    let l:filename = input('File Name:')
    call s:mkbasesubex(l:filename,l:cate,l:subcate,a:ex)
endfunction

function! s:echodirectory(directory)
    let l:directories=glob(fnameescape(a:directory).'/{,.}*', 1, 1)
    call map(l:directories, 'fnamemodify(v:val, ":h:t")')
    echo l:directories
endfunction

function! s:mkbase(filename,cate)
    call s:mkbasesubex(a:filename,a:cate,'','')
endfunction

function! s:mkbasesubex(infilename,cate,subcate,ex)

    let l:filename = strftime('%Y%m%d')
    if !empty(a:infilename)
        let l:filename = a:infilename
    endif

    let l:cate = 'other'
    if !empty(a:cate)
        let l:cate = a:cate
    endif

    let l:ex = 'md'
    if !empty(a:ex)
        let l:ex = a:ex
    endif

    let l:memo_dir = s:notes_dir . '/' . l:cate . '/'
    if !empty(a:subcate)
        let l:memo_dir = l:memo_dir . a:subcate .'/'
    endif
    let l:path = l:memo_dir . l:filename . '.' .l:ex
    if !isdirectory(l:memo_dir)
        call mkdir(l:memo_dir, 'p')
    endif
    execute s:local_edit_mode . ' ' . l:path 
endfunction

command! -nargs=0 MakeStorm call s:mkbase('','storm')
command! -nargs=0 MakeNote call s:mknoteinput('','')
command! -nargs=0 MakeTodo call s:mkbase('','todo')
command! -nargs=0 MakeBlog call s:mkblog()

let &cpo = s:save_cpo
unlet s:save_cpo
