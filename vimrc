set nocompatible 				" Disable vi-compatibility

" Vundle config
set rtp+=~/.vim/bundle/vundle/
"call vundle#begin()
call vundle#rc()
Plugin 'gmarik/vundle'

" Bundles
"Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'

Plugin 'fatih/vim-go'
Plugin 'chrisbra/csv.vim'
Plugin 'rhysd/vim-grammarous'
Plugin 'terrastruct/d2-vim'

"Plugin 'altercation/vim-colors-solarized'
"Plugin 'nanotech/jellybeans.vim'
"Plugin 'crusoexia/vim-dracula'
"Plugin 'dikiaap/minimalist'
"Plugin 'jonathanfilip/vim-lucius'
"Plugin 'jpo/vim-railscasts-theme'
"Plugin 'chriskempson/base16-vim'
"Plugin 'chriskempson/tomorrow-theme'
Plugin 'morhetz/gruvbox'
"Plugin 'tomasr/molokai'
colorscheme gruvbox

syntax on
syntax enable
filetype plugin indent on

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='dark'

" Performance
set nocursorcolumn
set nocursorline
set ttyfast				" Improves redrawing
set lazyredraw          " Don't update while in macro
syntax sync fromstart

" Display
set equalalways 		" Display split windows equally
set background=dark
set t_Co=256			" Number of colors in terminal
set guioptions-=L 		" Remove left scroll bar
set guioptions-=r 		" Remove right scroll bar
set ruler				" Show line number
set number 				" Line numbers
set laststatus=2 		" Status bar
set showcmd 			" Show commands
set splitbelow          " Split windows below current window
"set cursorline 		" Underline current line
"hi CursorLine term=bold cterm=bold guibg=#fff

" Text
set autoindent
set encoding=utf-8 		" Necessary to show Unicode glyphs
set expandtab           " Use spaces instead of tab
set nowrap 				" Overflow scroll
set smartindent
set tabstop=4
set shiftwidth=4
set lbr					" Linebreak
set tw=80				" Linebreak at 80 char
autocmd BufNewFile,BufRead *.txt,*.tex,*.md setlocal spell spelllang=en_us " Set locale for spell check on tex and txt files
set nojoinspaces
set clipboard=unnamed,unnamedplus   " Connect to clipboard
set backspace=2                     " either the clipboard or the version of vim breaks backspace, this fixes it

" Searching
set hlsearch
set incsearch			" Search while typing query
set showmatch
" Search for highlighted text
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Keyboard mappings
let mapleader = ","
imap jk <Esc>
" imap jj <Esc>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Go
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on
syntax on

" Trailing whitespace
function! <SID>StripTrailingWhitespaces()
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" Do the business
	%s/\s\+$//e
	" Clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l,c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Android
au BufNewFile,BufReadPost *.java,*.xml setl shiftwidth=4 expandtab

" Python
au BufNewFile,BufReadPost *.py setl syntax=python shiftwidth=4 expandtab tw=79

" Markdown
au BufRead,BufNewFile *.md set syntax=markdown
