set nocompatible 				" Disable vi-compatibility

" Vundle config
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Bundles
Bundle 'tpope/vim-fugitive'
Bundle 'nanotech/jellybeans.vim'
Bundle 'Lokaltog/vim-powerline'

"syntax on
syntax enable
filetype plugin indent on

" Powerline
let g:Powerline_symbols = 'fancy'

" Performance
set nocursorcolumn
set nocursorline
set ttyfast				" Improves redrawing
set lazyredraw          " Don't update while in macro
syntax sync fromstart

" Display
"colorscheme solarized
colorscheme jellybeans
set equalalways 		" Display split windows equally
set background=light
set t_Co=256			" Number of colors in terminal
set guioptions-=L 		" Remove left scroll bar
set guioptions-=r 		" Remove right scroll bar
set ruler				" Show line number
set number 				" Line numbers
set laststatus=2 		" Status bar
set showcmd 			" Show commands
set splitbelow          " Split windows below current window
"set cursorline 		" Underline current line

" Text
set autoindent
set encoding=utf-8 		" Necessary to show Unicode glyphs
set expandtab
set nowrap 				" Overflow scroll
set smartindent
set tabstop=4
set shiftwidth=4
set lbr					" Linebreak
set tw=90				" Linebreak at 90 char
autocmd BufNewFile,BufRead *.txt,*.tex setlocal spell spelllang=en_us " Set locale for spell check on tex and txt files

" Searching
set hlsearch
set incsearch			" Search while typing query
set showmatch
" Search for highlighted text
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Keyboard mappings
imap jk <Esc>
imap jj <Esc>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Go
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on
syntax on

" Rails
au BufRead,BufNewFile *.rb,*.rhtml,*.js,*.html,*.css.less set shiftwidth=2 tabstop=2 smartindent expandtab
augroup myfiletypes
	autocmd FileType ruby,eruby,yaml,rabl set ai sw=2 sts=2 et
augroup END

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

" Drools
au BufNewFile,BufReadPost *.drl setl syntax=java

" Python
au BufNewFile,BufReadPost *.py setl syntax=python shiftwidth=4 expandtab
