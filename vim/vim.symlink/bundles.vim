set nocompatible
filetype off	"turn off filetype checks before running vundle (turn back on later)

" Load vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let vundle manage itself
Bundle 'gmarik/vundle'

" GitHub bundles
Bundle 'sukima/xmledit'
Bundle 'altercation/vim-colors-solarized'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
" Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-haml'
Bundle 'kchmck/vim-coffee-script'
Bundle 'scrooloose/nerdtree'
Bundle 'greyblake/vim-preview'
Bundle 'nelstrom/vim-markdown-preview'
Bundle 'majutsushi/tagbar'

" vim-scripts bundles
Bundle 'AutoClose'
Bundle 'bufexplorer.zip'
.
" Non-GitHub bundles
Bundle 'git://repo.or.cz/vcscommand'

filetype plugin indent on
