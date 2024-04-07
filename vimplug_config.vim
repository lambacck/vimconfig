call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

Plug 'tpope/vim-pathogen'
Plug 'othree/html5.vim'
Plug 'lambacck/mako.vim'
Plug 'lambacck/VisIncr'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'lambacck/aspvbs.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'vim-python/python-syntax'
Plug 'sjl/gundo.vim'
Plug 'maksimr/vim-jsbeautify'
Plug 'lambacck/vim-matchit'
Plug 'lambacck/python_matchit'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lambacck/preserve-vim'
Plug 'groenewege/vim-less'
Plug 'hail2u/vim-css3-syntax'
Plug 'tpope/vim-obsession'
Plug 'mitsuhiko/vim-python-combined'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-sleuth'
" Plug 'dense-analysis/ale'
Plug 'fatih/vim-go'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'mileszs/ack.vim'
Plug 'vim-test/vim-test'
Plug 'tpope/vim-dispatch'
Plug 'editorconfig/editorconfig-vim'
Plug 'heavenshell/vim-pydocstring'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'joshdick/onedark.vim'
Plug 'sainnhe/everforest'
Plug 'hashivim/vim-terraform'
Plug 'tartansandal/vim-compiler-pytest'
Plug 'hashivim/vim-terraform'
Plug 'neoclide/jsonc.vim'
Plug 'jremmen/vim-ripgrep'

" Initialize plugin system
call plug#end()
