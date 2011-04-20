" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup	" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set showmode
set wildmenu
set showmatch
set ignorecase
set smartcase

" Whitespace
set list listchars=tab:▸\ ,trail:.,eol:¬

" Status bar
set laststatus=2

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Color scheme
"colorscheme desert256
set background=dark
colorscheme solarized

" Line numbers
set number

" Tabs
set shiftwidth=2
"set expandtab
set smarttab
set tabstop=2
set autoindent

" Set <Leader> to ,
let mapleader=","

" NERDTree stuff
map <Leader>n :NERDTreeToggle<CR>

" Enable filetype plugins
filetype plugin on

" Toggle invisibles
nmap <leader>l :set list!<CR>
