" Only do this when not done yet for this buffer
if exists("b:did_ftaspcioc")
  finish
endif
let b:did_ftaspcioc = 1

if !exists(":CIOCTransAdd")
    command -buffer CIOCTransAdd call s:CIOCTransAdd()
endif

if exists("s:loaded_functions")
    finish
endif
let s:loaded_functions = 1

let s:culture_prefixes = {'FRENCH': 'TRANSLATE_FR -- ', 'ENGLISH': '', 'CHINESE': 'TRANSLATE_ZH -- '}

function s:CIOCTransAdd()
    " return the cursor back here later
    let l:curPos = getpos('.')

    " where are we now?
    let l:line = line('.')

    let l:matchexpr = '^\c\(dim\)\?\s\+\(TXT_[A-Z_0-9]\+\)\s*\(,\s*_\?\s*\)\?$'

    " are things as we expect them?
    if match(getline(l:line), l:matchexpr) == -1
        echoerr "Not on a proper TXT_ variable declaration line"
        call setpos('.', l:curPos)
        return
    endif

    if search('CULTURE_FRENCH_CANADIAN', 'Wen') == 0
        let l:default_culture_prefix = 'TRANSLATE_FR -- '
    else
        let l:default_culture_prefix = ''
    endif
    
    let l:txtval = substitute(getline(l:line), l:matchexpr, '\2', '')

    let l:prev_needs_continuation = 0
    if match(getline(l:line - 1), l:matchexpr) != -1
        " previous line is a TXT Entry too, lets use this to anchor our
        " target lines
        let l:adjust_append = 0
        let l:srch_txt = substitute(getline(l:line - 1), l:matchexpr, '\2', '')
        let l:prev_needs_continuation = match(getline(l:line-1), ',\s\+_\s*$') == -1
        
    elseif match(getline(l:line + 1), l:matchexpr) != -1
        " next line is a TXT Entry too, lets use this to anchor our taget
        " lines
        let l:adjust_append = -1
        let l:srch_txt = substitute(getline(l:line + 1), l:matchexpr, '\2', '')
    else
        "First one: error out
        echoerr "Is this the first entry?  I can't handle that!"
        call setpos('.', l:curPos)
        return
    endif

    let l:this_needs_continuation =  (match(getline(l:line + 1), l:matchexpr) == 0 && match(getline(l:line), ',\s\+_\s*$') == -1)

    " look for target insert point anchors
    let l:insert_points = []
    call cursor(l:line + 1, 99999)
    let l:next_insert_point = search(l:srch_txt . '\s*=', 'We')
    while l:next_insert_point != 0
        "echomsg join(getpos('.'), ",")
        let l:lang_desc = search('Case ', 'Wben')
        if l:lang_desc != 0 
            let l:lang_desc = getline(l:lang_desc)
            "echomsg l:lang_desc
            if match(l:lang_desc, 'CULTURE_') == -1
                "echomsg 'Default: ' . l:default_culture_prefix
                call add(l:insert_points, [l:next_insert_point, l:default_culture_prefix])
            else
                let l:lang_desc = substitute(l:lang_desc, '^\s*Case CULTURE_\([^_]\+\).*$', '\1', '')
                if has_key(s:culture_prefixes, l:lang_desc)
                    "echomsg 'Prefix: ' . s:culture_prefixes[l:lang_desc]
                    call add(l:insert_points, [l:next_insert_point, s:culture_prefixes[l:lang_desc]])
                else
                    echoerr "Unknown culture: " . l:lang_desc
                    call setpos('.', l:curPos)
                    return
                endif
            endif
            
        endif
        let l:next_insert_point = search(l:srch_txt . '\s*=', 'We')
    endwhile

    if len(l:insert_points) < 2
        echoerr "Could not find message insert points"
        call setpos('.', l:curPos)
        return
    endif

    let l:english = input("Text String: ")

    call reverse(l:insert_points) "reverse order so that locations continue to be correct
    for [l:insert_point, l:prefix] in l:insert_points
        "echomsg l:insert_point, l:adjust_append
        let l:lineprefix = substitute(getline(l:insert_point), '^\(\s\+\)\S.*$', '\1', '')
        call append(l:insert_point + l:adjust_append, l:lineprefix . l:txtval . ' = "' . l:prefix . l:english . '"')
    endfor

    if l:prev_needs_continuation
        call setline(l:line - 1, getline(l:line - 1) . ', _')
    endif
    if l:this_needs_continuation
        call setline(l:line, getline(l:line) . ', _')
    endif
    
    call setpos('.', l:curPos)

endfunction
