"------------------------------------------------------------
" Vim-Plug {{{1
"
" Install Vim Plug
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
" :PlugInstall to install plugins
" :PlugUpgrade to upgrade vim-plug
call plug#begin('~/.vim/plugged')

Plug 'arcticicestudio/nord-vim'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'jceb/vim-orgmode'
" Initialize plugin system
call plug#end()


"{{{ Backup System
    set backup
    set undofile
    set noswapfile
    set undodir=~/.vim/tmp/undo
    set backupdir=~/.vim/tmp/backup
    set backupskip=/tmp/*
    set writebackup
    "Meaningful backup name, ex: filename@2015-04-05.14:59
    au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")

"}}}


"{{{ Functions
noremap g= :call Format()<CR>
function! Format() "{{{
    " * Removes trailing white spaces
    " * Removes blank lines at the end of the file
    " * Replaces tabs with spaces
    " * Re-Indent
    "
    " * If: C, CPP, PHP or Java code: format using 'astyle'
    " * If: Rust code: format using 'rustfmt'
    "
    " * Clear 'formatprg' so `gq` can be used with the default
    "   behavior
    let l:winview = winsaveview()

    if &ft ==? 'c' || &ft ==? 'cpp' || &ft ==? 'php'
        setlocal formatprg=astyle\ --mode=c
        silent! execute 'norm! gggqG'
    elseif &ft ==? 'java'
        setlocal formatprg=astyle\ --mode=java\ --style=java
        silent! execute 'norm! gggqG'
    elseif &ft ==? 'rust'
        setlocal formatprg=rustfmt
        silent! execute 'norm! gggqG'
    endif

    silent! call RemoveTrailingSpaces()
    silent! execute 'retab'
    silent! execute 'gg=G'
    call winrestview(l:winview)
    setlocal formatprg=
endfunction
"}}}

function! RemoveTrailingSpaces() "{{{
    silent! execute '%s/\s\+$//ge'
    silent! execute 'g/\v^$\n*%$/norm! dd'
endfunction
"}}}
"}}}

set cursorline

let mapleader = ","
nnoremap <silent> <Leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR>
"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.
 
" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible
 
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on
 
" Enable syntax highlighting
syntax on

" Colorscheme
colorscheme nord
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }


"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch


" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline

" ???
set noshowmode


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Use UTF-8 encoding
set encoding=UTF-8

" Ignore whitespace when diffing
set diffopt+=iwhite

" Set system clipboard
set clipboard^=unnamed,unnamedplus

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2


" Display line numbers on the left
set number
 
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
 
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
 
"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.
 
" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab
 
" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
"set shiftwidth=4
"set tabstop=4
 
"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings
 
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$ 

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>
