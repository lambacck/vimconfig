" To bootstrap this on unix, simlink this file to ~/.vimrc
" To bootstrap this on windows copy the following lines into ~/.vimrc
"
" if has("win32")
"    source $HOME/vimfiles/vimrc
" else
"    " Support vim under git bash
"    setg runtimepath=~/vimfiles,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/vimfiles/after
"    source ~/vimfiles/vimrc
" endif
"
" The above will make it work with windows installer vim and git bash vim.
"
let g:pathogen_disabled = []
" Example for disabling a pathogen path
" call add(g:pathogen_disabled, 'vim-css')
call add(g:pathogen_disabled, 'syntastic')

let g:syntastic_less_use_less_lint = 1

set nocompatible

let g:ack_use_dispatch=1
let g:go_version_warning = 0
let g:ale_fix_on_save=1
" Debugging settings to be uncommented
"let g:ale_history_enabled=1
"let g:ale_history_log_output=1
let g:ale_completion_enabled = 1
let g:ale_go_golint_executable = expand('~/go/bin/golint')  " Probably unnecessary if you have GOPATH set everywhere
let g:ale_linters = {'go': ['golint', 'govet'], 'python': ['flake8', 'pylint']}
let g:ale_fixers = {'java': ['google_java_format'], 'python': ['black'], 'go': ['gofmt']}
" ALE Rust
let g:ale_rust_cargo_use_clippy=1
" ALE Java
let g:ale_java_google_java_format_options='-a'

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
    setg grepprg=ag\ --vimgrep
    setg grepformat=%f:%l:%c:%m,%f:%l:%m
endif

if $GITHUB_ENTERPRISE_URLS != ""
    let g:github_enterprise_urls = split($GITHUB_ENTERPRISE_URLS)
endif

let test#strategy='dispatch_background'
let test#python#runner='pytest'
if $PYTEST_EXECUTABLE != ""
    "For example: foreman run -e env.defaults,.env,.env.test pytest
    let test#python#pytest#executable=$PYTEST_EXECUTABLE
endif

if has("win32")
    let g:netrw_cygwin = 0
    let g:netrw_ssh_cmd  = 'C:\"Program Files"\PuTTY\plink.exe -T -ssh'
    let g:netrw_scp_cmd  = 'C:\"Program Files"\PuTTY\pscp.exe -q -scp'
    let g:netrw_sftp_cmd = 'C:\"Program Files"\PuTTY\pscp.exe -q -sftp'
endif

if has("multi_byte")    " if not, we need to recompile
  if &enc !~? '^u'      " if the locale 'encoding' starts with u or U
                        " then Unicode is already set
    if &tenc == ''
      let &tenc = &enc  " save the keyboard charset
    endif
    set enc=utf-8       " to support Unicode fully, we need to be able
                        " to represent all Unicode codepoints in memory
  endif
  set fencs=ucs-bom,utf-8,latin1
  setg bomb             " default for new Unicode files
  setg fenc=utf-8       " default for files created from scratch
else
  echomsg 'Warning: Multibyte support is not compiled-in.'
endif


"set some default values
set modelines=0
set backspace=indent,eol,start
set ruler
set showcmd
set showmode
set et
"set tags=tags,../tags,file.tags,../file.tags,c:/chris/projects\tags
set ts=4
set sw=4
set sts=4
set ai
set cin
set hid
set cmdheight=2
set wildmenu
set wildmode=list:longest
set history=500
set visualbell
set relativenumber
set textwidth=99
"set undofile
"set scrolloff=3
"set ignorecase
"set smartcase
"set gdefault



nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>


runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

"turn on syntax highlighting and search highlighting
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif
if has("gui_running")
    set guioptions+=c
    set guioptions+=a
    if has("gui_macvim")
        set guifont=CaskaydiaCoveNerdFontCompleteM-:h12
    elseif has("gui_gtk2")
        if matchstr($SSH_CLIENT, '^10.66.66.\d\+ .*')
            set guifont=ProggyCleanTT\ 15
        else
            set guifont=ProggyCleanTT\ 12
        endif
    elseif has("gui_win32")
        "win32 
        set guifont=CaskaydiaCove_NF:h12:cANSI:qDRAFT
        if has("multi_byte")
            set guifontwide=NSimSun:h12:cGB2312,Consolas:h12:cGB2312
        endif
    endif
endif
" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78 noai nocin spell spelllang=en_gb
    autocmd FileType tex setlocal textwidth=78 noai nocin spell spelllang=en_gb
    autocmd FileType tex compiler latex
    autocmd FileType bib setlocal nowrap

    autocmd FileType html setlocal spell spelllang=en_gb

    " For all java files set compiler to javac
    autocmd FileType java  compiler javac

    " For makefiles set noet so that tabs work
    autocmd FileType make setlocal noet

    " For mail files turn of cin and ai
    autocmd FileType mail setlocal textwidth=78 noai nocin spell spelllang=en_gb

    " For XML recognize : and - as part of a keyword
    autocmd FileType {xml,xslt} setlocal iskeyword+=\:,-


    " Wiki indentation is 3 spaces
    autocmd FileType twikiSyntax setlocal ts=3 sw=3 noai nocin spell spelllang=en_gb

	" Defaults for working with cioc stuff
	"autocmd FileType aspvbs setlocal noet sw=4 ts=4
    autocmd BufRead,BufNewFile */VirtualServers/* setlocal noet tags=tags

    " fix settings for this python only project
    autocmd BufRead,BufNewFile */VirtualServers/CommunityManager/* setlocal et tags=tags
    autocmd BufRead,BufNewFile */VirtualServers/ClientTracker/* setlocal et tags=tags
    autocmd BufRead,BufNewFile */VirtualServers/ClientTracker/* let g:syntastic_python_flake8_args = '--ignore=E501 --builtins=_'

    autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif

    " Some systax highlighting can get messed up when in the middle of a big
    " comment.  This fixes that.
    autocmd BufEnter * :syntax sync fromstart

    " au FileType python set omnifunc=pythoncomplete#Complete
    autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif
endif " has("autocmd")

"let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

"left over from builds at Evertz
"set makeprg=make\ NOREDIR=1

"some make shortcuts
map <F2> :cp<CR>
map <F3> :cn<CR>
map <F4> :cope<CR>
map <F5> :make!<CR>
map <F6> :Make!<CR>
map <F7> :make! -j4<CR>
map <F8> :make! -j4 install<CR>
map <F9> :SyntasticCheck<CR>

"buffer listing
map <F7> :ls<CR>

command! Cdb call <SID>GoToBufDir()
function! <SID>GoToBufDir()
    let l:dir = substitute(expand("%"), "[/\\\\]\\?[^/\\\\]*$", "", "")
    if(l:dir != "")
        execute("cd " . l:dir)
    endif   
    echomsg "pwd is" getcwd()
endfunction

" Re-indents buffer.
nmap <silent> <Leader>g :call Preserve("normal gg=G")<CR>
" Removes all trailing whitespace in buffer.
nmap <silent> <Leader><space> :call Preserve("%s/\\s\\+$//e")<CR>

if has("gui_running")
    colorscheme darkblue+
endif

let g:template_username="Chris Lambacher"

"tSkeleton Options
let g:tskelBitGroup_aspvbs = ['aspvbs', 'ciocvbs', 'html', 'css']

let g:pyflakes_use_quickfix=0
let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers = ['eslint']
