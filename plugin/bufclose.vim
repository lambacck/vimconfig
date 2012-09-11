" Vim global plugin for closing buffers without effecting window layout
" Last Change 23 July, 2002
" Maintainer: Christopher Lambacher <lambacck@ieee.org>
" Maintainer: Vincent Silvestri

if exists("loaded_bufclose")
    finish
endif
let loaded_bufclose = 1

let s:save_cpo = &cpo
set cpo&vim
if !exists(":Bc")
    command -bang -nargs=? -complete=buffer Bc :call s:BufcloseCloseIt(<q-args>, "<bang>")
endif

function! s:SwapoutBuf(bufnum)
if a:bufnum == bufnr("%") 
    if buflisted(bufnr("#")) 
        buffer # 
    else 
        bnext 
        if(a:bufnum == bufnr("%"))
            bnext 
            if(a:bufnum == bufnr("%"))
                enew
                blast
                set buftype=nofile
                set bufhidden=hide
                setlocal noswapfile
            endif
        endif
    endif 
endif

endfunction

function! s:BufcloseCloseIt(bufn, force)
    "echomsg a:bufn
    "echomsg a:force
    if(a:bufn != "" && a:bufn + 0 == a:bufn)
        let l:curBufNum = a:bufn
    else
        let l:curBufNum = bufnr(a:bufn)
    endif
    if(l:curBufNum == -1)
        echohl ErrorMsg | echo "specified buffer does not exist" | echohl None
    endif
    let l:curWinNum = winnr()
    let l:bangon = a:force
    let l:bufmod = getbufvar("%", "&mod")
    let l:buftyp = getbufvar("%", "&buftype")

    if(l:bangon == "!" || l:buftyp == "nofile" || l:buftyp == "nowrite" || !l:bufmod)
        windo call <SID>SwapoutBuf(l:curBufNum)
        execute(l:curWinNum . " wincmd w")
        execute("bd". l:bangon . " " . l:curBufNum)
    else
        echohl ErrorMsg | echo "buffer modified, use !" | echohl None
    endif

endfunction 

let &cpo = s:save_cpo
