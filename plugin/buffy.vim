if exists("g:buffy_loaded")
    finish
endif

let g:buffy_loaded = 1


if !exists('g:buffy_default_key')
    let g:buffy_default_key = 1
endif


function! s:GetBufferNumberFromFileName(buffer_filename, ...) "{{{
    let i = bufnr('$')
    while i >= 1
        if buflisted(i) && bufname(i) == a:buffer_filename
            return i
        endif
        let i -= 1
    endwhile
    return 0
endfunction "}}}

function! s:GetBufferNames(...) "{{{
    let buffers = []
    let i = bufnr('$')
    while i >= 1
        if buflisted(i) && bufname(i) != ''
            let buffers = buffers + [ bufname(i) ]
        endif
        let i -= 1
    endwhile
    return buffers
endfunction "}}}

function! s:GetBufferListText(...) "{{{
    let buffer_names = s:GetBufferNames()
    let buffer_names = sort(buffer_names)
    let buff_list = join(buffer_names, "\n")
    return buff_list
endfunction "}}}

function! s:OpenBuffer(buffer_filename, ...) "{{{
    let buffer_number = s:GetBufferNumberFromFileName(a:buffer_filename)
    execute "b" . buffer_number

    setlocal noreadonly
    setlocal modifiable
    setlocal buftype=
    setlocal buflisted
    setlocal nocursorline

    nnoremap <buffer> <Enter> j
endfunction "}}}

function! s:DeleteBuffer(buffer_filename, ...) "{{{
    let buffer_number = s:GetBufferNumberFromFileName(a:buffer_filename)
    execute "bdelete " . buffer_number

    setlocal modifiable
    setlocal noreadonly

    " delete the corresponding line from the switch
    execute "normal! dd"

    setlocal nomodifiable
    setlocal readonly
endfunction "}}}

function! s:RenderBuffyMenu(...) "{{{
    execute 'enew'
    setlocal buftype=nofile
    setlocal nobuflisted
    setlocal cursorline

    let l:buff_list_text = s:GetBufferListText()

    " clear the buffer
    execute 'normal! ggvGd'

    " put the contents
    execute 'put =l:buff_list_text'

    " remove the last empty line which is always there
    execute 'normal! ggdd'

    nnoremap <buffer> <Enter> :call <sid>OpenBuffer(getline(line('.')))<CR>
    nnoremap <buffer> d :call <sid>DeleteBuffer(getline(line('.')))<CR>
    nnoremap <buffer> x :call <sid>DeleteBuffer(getline(line('.')))<CR>
endfunction "}}}


command! Buffy :call s:RenderBuffyMenu()


if g:buffy_default_key
    nnoremap <Leader>b :Buffy<CR>
endif
