set nocompatible
filetype off	"turn off filetype checks before running vundle (turn back on later)

" Load vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let vundle manage itself
" Note: vundle is a submodule of the dotfiles repo, so it has not tracking
" branch. When running PluginInstall!, you will get an error saying that it
" can't pull the latest master; so effectively vundle must be updated
" manually:
" 1) cd ~/.dotfiles/vim/vim.symlink/bundle/vundle
" 2) git pull origin master
" 3) cd ~/.dotfiles
" 4) gcma "Updated to latest vundle"
" 5) git push
Plugin 'gmarik/vundle'

" ==========================================
" GitHub bundles
" ==========================================
Plugin 'sukima/xmledit'
Plugin 'altercation/vim-colors-solarized'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
" Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-haml'
" Plugin 'kchmck/vim-coffee-script'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'greyblake/vim-preview'
Plugin 'nelstrom/vim-markdown-preview'
Plugin 'majutsushi/tagbar'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mileszs/ack.vim'
" Plugin 'Valloric/YouCompleteMe'       " Disabled with switch to vscode as default editor
Plugin 'marijnh/tern_for_vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'Raimondi/delimitMate'
Plugin 'SirVer/ultisnips'
Plugin 'cosminadrianpopescu/filesync'

" Support for .editorconfig
Plugin 'editorconfig/editorconfig-vim'

" Typescript syntax
Plugin 'leafgarland/typescript-vim'

" Yet Another JavaScript Syntax (for ES6)
Plugin 'othree/yajs.vim'

" ==========================================
" vim-scripts bundles
" ==========================================
"Plugin 'AutoClose'
Plugin 'scratch'
.
" ==========================================
" Non-GitHub bundles
" ==========================================
Plugin 'git://repo.or.cz/vcscommand'

filetype plugin indent on
