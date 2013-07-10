set nocompatible
filetype off	"turn off filetype checks before running vundle (turn back on later)

" Load vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let vundle manage itself
" Note: vundle is a submodule of the dotfiles repo, so it has not tracking
" branch. When running BundleInstall!, you will get an error saying that it
" can't pull the latest master; so effectively vundle must be updated
" manually:
" 1) cd ~/.dotfiles/vim/vim.symlink/bundle/vundle
" 2) git pull origin master
" 3) cd ~/.dotfiles
" 4) gcma "Updated to latest vundle"
" 5) git push
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
Bundle 'hallettj/jslint.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'

" vim-scripts bundles
Bundle 'AutoClose'
Bundle 'bufexplorer.zip'
.
" Non-GitHub bundles
Bundle 'git://repo.or.cz/vcscommand'

filetype plugin indent on
