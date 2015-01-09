
let s:local_edit_mode = 'tabedit'
let s:notes_dir = $HOME . '/Dropbox/notes'

function! s:mkdirifnoex(dir)
    if !isdirectory(a:dir)
        call mkdir(a:dir, 'p')
    endif
endfunction

function! dropnote#mkblog()
    call dropnote#mknoteinput('blog','blog')
endfunction

function! dropnote#mknoteinput(cate,ex)
    let l:dir = s:notes_dir
    if !empty(a:cate)
        let l:dir = l:dir . '/' . a:cate
    endif
    call s:mkdirifnoex(l:dir)
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
    call s:mkdirifnoex(l:tmpdir)
    call s:echodirectory(l:tmpdir)

    let l:filename = input('File Name:')
    call dropnote#mkbasesubex(l:filename,l:cate,l:subcate,a:ex)
endfunction

function! s:echodirectory(directory)
    let l:directories=glob(fnameescape(a:directory).'/{,.}*', 1, 1)
    call map(l:directories, 'fnamemodify(v:val, ":h:t")')
    echo l:directories
endfunction

function! dropnote#mkbase(filename,cate)
    call dropnote#mkbasesubex(a:filename,a:cate,'','')
endfunction

function! dropnote#mkbasesubex(infilename,cate,subcate,ex)

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

