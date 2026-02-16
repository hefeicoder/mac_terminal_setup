set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle
" " required! 
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
map <F2> :NERDTreeToggle<CR>
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-airline'
Plugin 'vim-scripts/a.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tomasr/molokai'
Plugin 'easymotion/vim-easymotion'

call vundle#end()
filetype indent plugin on
filetype plugin on
set laststatus=2

" disable vi compatibility (emulation of old bugs)
 set nocompatible
 " use indentation of previous line
 set autoindent
 " use intelligent indentation for C
 set smartindent
 " configure tabwidth and insert spaces instead of tabs
 set tabstop=4        " tab width is 4 spaces
 set shiftwidth=4     " indent also with 4 spaces
 set expandtab        " expand tabs to spaces
 " wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
 set textwidth=120
 " turn syntax highlighting on
 set t_Co=256
 syntax on
 " turn line numbers on
 set number
 set relativenumber
 " highlight matching braces
 set showmatch
 " intelligent comments
 set comments=sl:/*,mb:\ *,elx:\ */


set nocp

 " Install OmniCppComplete like described on http://vim.wikia.com/wiki/C++_code_completion
 " This offers intelligent C++ completion when typing ‘.’ ‘->’ or <C-o>
 " Load standard tag files
set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/qt4

set omnifunc=ccomplete#Complete

" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>


" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

set gfn=DejaVu\ LGC\ Sans\ Mono\ 12
set vb t_vb=".     
set mouse=a
set hlsearch
syntax enable
"set background=light
colorscheme molokai
hi Comment      ctermfg=184

