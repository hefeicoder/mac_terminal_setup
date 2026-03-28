" ── Plugin Manager (vim-plug) ─────────────────────────────────────────────
" First-time setup: install vim-plug, then open vim and run :PlugInstall
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'           " File browser sidebar
Plug 'preservim/nerdcommenter'      " Toggle comments with <leader>cc
Plug 'vim-airline/vim-airline'      " Informative status bar
Plug 'airblade/vim-gitgutter'       " Git diff markers in the sign column
Plug 'easymotion/vim-easymotion'    " Jump anywhere with <leader><leader>w
Plug 'tomasr/molokai'               " Dark colorscheme

call plug#end()

" ── General ───────────────────────────────────────────────────────────────
set nocompatible            " Disable Vi compatibility mode
set hidden                  " Allow switching buffers without saving first
set mouse=a                 " Enable mouse support in all modes
set clipboard=unnamed       " Yank/paste uses the system clipboard

" ── Appearance ────────────────────────────────────────────────────────────
set t_Co=256                " Tell vim the terminal supports 256 colors
syntax enable               " Enable syntax highlighting
colorscheme molokai         " Dark theme with vivid colors
hi Comment ctermfg=184      " Brighter yellow for comments (easier to read)
set number                  " Show line number on the current line
set relativenumber          " Show relative numbers on all other lines
set laststatus=2            " Always show the status bar (required by airline)
set showmatch               " Briefly highlight matching bracket when inserted

" ── Indentation ───────────────────────────────────────────────────────────
filetype indent plugin on   " Enable filetype-aware indentation and plugins
set autoindent              " Copy indent level from the previous line
set smartindent             " Add extra indent after { and similar tokens
set tabstop=4               " A tab character appears 4 spaces wide
set shiftwidth=4            " >> and << indent/dedent by 4 spaces
set expandtab               " Insert spaces when Tab is pressed

" ── Search ────────────────────────────────────────────────────────────────
set hlsearch                " Highlight all matches for the current search
set incsearch               " Show matches incrementally as you type
set ignorecase              " Case-insensitive search by default
set smartcase               " Switch to case-sensitive if query has uppercase

" ── Key Mappings ──────────────────────────────────────────────────────────
map <F2> :NERDTreeToggle<CR>    " F2 toggles the file browser sidebar
