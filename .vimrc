"----------------------------------------------------------------------
" Leader Mappings (leader = ,)
" ============================
" Key	Description																							Mode
" ---	-----------																							----
" n		Toggles NERDTree open/closed													|	All
" l		Toggles invisible characters (line breaks, tabs etc.)	|	Normal
" a		Toggles autoclose plugin
" t		Toggles Tagbar open/closed														| All
" ew	Edit file in directory of current file, in new window	|	All
" es	Edit file in directory of current file, in new split	|	All
" ev	Edit file in directory of current file, in new vsplit	|	All
" et	Edit file in directory of current file, in new tab		| All
" s		Toggles spell checking on/off													| Normal
" v		Edit .vimrc file in a new vsplit											| Normal
"
"	Other Mappings
"	==============
" F5	Toggle Gundo tree
" CTRL-↑	Bubble line(s) up
" CTRL-↓	Bubble line(s) down
"
" Plugin Cheatsheets
" ==================
" NERDTree:
" 	SHIFT-B	Toggle bookmarks
" 	SHIFT-I	Toggle hidden files
" 	SHIFT-F	Toggle files
" 	SHIFT-C Set current dir as tree root
"
" Autoclose:
" 	Use double {{ to open a new line between the braces
"
" Fugitive:
" 	:Git			Run any git command
" 	:Gwrite		Stage current file
" 	:Gread		Checkout current file
" 	:Gremove	Unstage current file
" 	:Gmove		Rename current file
" 	:Gcommit	Commit the staged files
" 	:Gstatus	Open status window
" 	-					Stage/unstage files in status window
" 	<Enter>		Open the selected file in status window
" 	SHIFT-C		Commit from status window
"
" Preview:
" 	:PreviewMarkdown	view the current *.md file in a browser
"----------------------------------------------------------------------

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Load pathogen
"call pathogen#runtime_append_all_bundles()
"call pathogen#helptags()

" Load vundler
source ~/.vim/bundles.vim

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
set hidden		" allow easy switching from a modified buffer
set showtabline=2 " always show tabs

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
filetype plugin indent on

" Toggle invisibles
nmap <leader>l :set list!<CR>

" Toggle tagbar
map <Leader>t :TagbarToggle<CR>

" Edit file shortcuts
cnoremap %% <C-R>=expand('%:h').'/'<CR>
" edit a file from the same directory as the current file, in the current window
map <leader>ew :e %%
" as above, in a new window split
map <leader>es :sp %%
" as above, in a new vertical split"
map <leader>ev :vsp %%
" as above, in a new tab"
map <leader>et :tabe %%

" Toggle spell checking
nmap <silent> <leader>s :set spell!<CR>
set spelllang=en_au

" Autocommands
if has("autocmd")
	" Editing and reloading this file
	autocmd bufwritepost .vimrc source $MYVIMRC

" Automatically delete fugitive buffers
	autocmd BufReadPost fugitive://* set bufhidden=delete
endif

" Quick edit .vimrc
fun! SplitIfBufferModified()
	" If the current buffer has no name and is not modifed (eg. when vim is first launched),
	" open the .vimrc file in the current window; otherwise open in a new vsplit
	if empty(bufname("%")) && &modified == 0
		e $MYVIMRC
	else
		vsp $MYVIMRC
	endif
endfun

nmap <leader>v :call SplitIfBufferModified()<CR>

" Bubble single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp

" Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]

" Toggle Gundo
nnoremap <F5> :GundoToggle<CR>

" Show git branch in status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Preview plugin settings
let g:PreviewBrowsers='google-chrome'

" Treat .asp files as javascript
let g:filetype_asp = 'javascript'
