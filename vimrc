syntax on
filetype plugin indent on

" Automatic installation of vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'dense-analysis/ale'
Plug 'hashivim/vim-terraform'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Glench/Vim-Jinja2-Syntax'
" New from: https://www.reddit.com/r/golang/comments/rx0xav/anyone_write_go_full_time_using_vim/
Plug 'fatih/vim-go'
Plug 'airblade/vim-gitgutter'
Plug 'prabirshrestha/vim-lsp'
Plug 'liuchengxu/vista.vim' " how is this used?
Plug 'tpope/vim-repeat' " repeats using .
" new VIM specific lsp stuff
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()


let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_powerline_fonts = 1
" let g:airline_theme='murmur'
" let g:airline_theme='base16_dracula'
let g:airline_theme='molokai'
" let g:airline_theme='base16_spacemacs'

" number lines and dark background
set background=dark
set number
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us
autocmd FileType gitcommit setlocal spell spelllang=en_us
set spellfile=~/.vim/spell/en.utf-8.add

set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
" set t_Co=256
set paste " turn off horrible autoindent on buffer paste

set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on          " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

set modeline
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
autocmd filetype ruby setlocal ts=4 sts=4 sw=4 expandtab
autocmd filetype javascript setlocal ts=4 sts=4 sw=4 expandtab
autocmd filetype python setlocal ts=4 sts=4 sw=4 expandtab
autocmd filetype sh setlocal ts=4 sts=4 sw=4 expandtab
autocmd filetype html setlocal ts=4 sts=4 sw=4 expandtab
autocmd filetype json setlocal ts=4 sts=4 sw=4 expandtab
autocmd filetype yaml setlocal ts=4 sts=4 sw=4 expandtab
autocmd filetype jinja setlocal ts=4 sts=4 sw=4 expandtab
autocmd filetype go setlocal ts=4 sts=4 sw=4 expandtab

autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <C-n> :NERDTreeToggle<Enter>
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" adding a space delim for nerdcommenter
let NERDSpaceDelims=1

" allow strikethrough for markdown and disable folding
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_folding_disabled = 1

" ale
let g:ale_fixers = {
\       "*": ["remove_trailing_lines", "trim_whitespace"],
\       "python3": ["black", "isort"],
\}

let g:ale_linter = {
\       "python3": ["flake8", "mypy", "pylint", "vulture"],
\       "go": ["gopls"],
\}
let g:ale_fix_on_save = 1
