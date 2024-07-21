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
set nocompatible

let g:ack_use_dispatch=1
let g:go_version_warning = 0
"let g:ale_fix_on_save=1
" Debugging settings to be uncommented
"let g:ale_history_enabled=1
"let g:ale_history_log_output=1
"let g:ale_completion_enabled = 1
" if executable('tan')
"     let g:ale_python_black_executable='tan'
" endif

if has("nvim")
    let g:python3_host_prog = $HOME . '/.virtualenvs/neovimpython/bin/python'
    let g:ruby_host_prog = '/opt/homebrew/Cellar/ruby/3.2.2/bin/ruby'
    let g:node_host_prog = '/opt/homebrew/bin/neovim-node-host'
endif

"let g:ale_c_clangd_executable = "arch"
"let g:ale_cpp_clangd_executable = "arch"
"let g:ale_c_clangformat_use_local_file = 1
"let g:ale_c_clangd_options = "-x86_64 clangd --clang-tidy --background-index"
"let g:ale_cpp_clangd_options = " -x86_64 clangd --clang-tidy --background-index"
"let g:ale_go_golint_executable = expand('~/go/bin/golint')  " Probably unnecessary if you have GOPATH set everywhere
"let g:ale_linters = {'go': ['golint', 'govet'], 'python': ['flake8', 'pylint']}
"", "c": ['clangd'], 'cpp': ['clangd']}
"let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'java': ['google_java_format'], 'python': ['black'], 'go': ['gofmt'], 'cpp': ['clang-format', 'clangtidy'], 'c': ['clang-format', 'clangtidy']}
"let g:ale_linters_ignore = { 'cc': ['clangd', 'clangtidy', 'cc'], 'cpp': ['clangd', 'clangtidy', 'cc'], 'c': ['clangd', 'clangtidy', 'cc'] }
"" ALE Rust
"let g:ale_rust_cargo_use_clippy=1
"" ALE Java
"let g:ale_java_google_java_format_options='-a'
let g:pydocstring_doq_path = $HOME . '/.local/bin/doq'
let g:pydocstring_formatter = 'google'

let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-pyright', 'coc-clangd', 'coc-java', 'coc-css', 'coc-docker', 'coc-eslint', 'coc-html', 'coc-sh', 'coc-sql', 'coc-toml', 'coc-vimlsp']

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
    setg grepprg=ag\ --vimgrep
    setg grepformat=%f:%l:%c:%m,%f:%l:%m
endif

if $GITHUB_ENTERPRISE_URLS != ""
    let g:github_enterprise_urls = split($GITHUB_ENTERPRISE_URLS)
endif

let test#strategy='dispatch'
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
  setg nobomb             " default for new Unicode files
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
"set textwidth=99
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

set rtp+=/opt/homebrew/opt/fzf

runtime vimplug_config.vim
"runtime bundle/pathogen/autoload/pathogen.vim
"call pathogen#infect()

"turn on syntax highlighting and search highlighting
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif
if has("gui_running")
    set guioptions+=c
    set guioptions+=a
    if has("gui_macvim")
        set guifont=CaskaydiaCoveNF-Regular:h14
    elseif has("gui_gtk2")
        if matchstr($SSH_CLIENT, '^10.66.66.\d\+ .*')
            set guifont=ProggyCleanTT\ 15
        else
            set guifont=ProggyCleanTT\ 12
        endif
    elseif has("gui_win32")
        "win32
        set guifont=CaskaydiaCove_NF:h12:cEASTEUROPE:qDRAFT,Lucida_Console:h12:cEASTEUROPE:qDRAFT,Consolas:h12:cEASTEUROPE:qDRAFT
        if has("multi_byte")
            set guifontwide=CascadiaCode:h12:cGB2312,Consolas:h12:cGB2312
        endif
    endif
endif
" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " For all text files
    autocmd FileType text setlocal noai nocin spell spelllang=en_gb
    autocmd FileType tex setlocal tnoai nocin spell spelllang=en_gb
    autocmd FileType tex compiler latex
    autocmd FileType bib setlocal nowrap

    autocmd FileType html setlocal spell spelllang=en_gb

    " For all java files set compiler to javac
    autocmd FileType java  compiler javac

    " For makefiles set noet so that tabs work
    autocmd FileType make setlocal noet

    " For mail files turn of cin and ai
    autocmd FileType mail setlocal noai nocin spell spelllang=en_gb

    " For XML recognize : and - as part of a keyword
    autocmd FileType {xml,xslt} setlocal iskeyword+=\:,-


    " Wiki indentation is 3 spaces
    autocmd FileType twikiSyntax setlocal ts=3 sw=3 noai nocin spell spelllang=en_gb

    " Defaults for working with cioc stuff
    autocmd FileType aspvbs setlocal noet sw=4 ts=4 bomb
    " autocmd BufRead,BufNewFile *.asp setlocal noet tags=tags

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
    let g:everforest_background = 'hard'
    set background=light
    colorscheme everforest
endif

let g:template_username="Chris Lambacher"

"tSkeleton Options
let g:tskelBitGroup_aspvbs = ['aspvbs', 'ciocvbs', 'html', 'css']

let g:pyflakes_use_quickfix=0
let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers = ['eslint']
" function! LinterStatus() abort
"   let l:counts = ale#statusline#Count(bufnr(''))

"   let l:all_errors = l:counts.error + l:counts.style_error
"   let l:all_non_errors = l:counts.total - l:all_errors

"   return l:counts.total == 0 ? '✨ all good ✨' : printf(
"         \   '😞 %dW %dE',
"         \   all_non_errors,
"         \   all_errors
"         \)
" endfunction

set statusline=
set statusline+=%m
set statusline+=\ %f
set statusline+=%=
set statusline+=%c
set statusline+=,
set statusline+=%l
set statusline+=/
set statusline+=%L

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)
nnoremap <silent> gh :CocCommand clangd.switchSourceHeader<CR>
