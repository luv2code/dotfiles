set nocompatible
set encoding=utf-8
let mapleader = ","
" inoremap jj <Esc>
" nnoremap JJJJ <Nop>
" let NERDTreeDirArrows=0
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set softtabstop=4
set autoindent
set bs=2
set background=dark
set wrapmargin=8
set ruler
set guifont=Consolas\ 13
syntax on
"colorscheme badwolf
set number
if has("autocmd")
	filetype plugin indent on
endif
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set ignorecase          " Do case insensitive matching
set smartcase           " Do smart case matching
set incsearch           " Incremental search
set hidden              " Hide buffers when they are abandoned
set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar
set guioptions+=LlRrb "remove scrollbar
set guioptions-=LlRrb "remove scrollbar
set statusline=%{fugitive#statusline()}%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%c\",getftime(expand(\"%:p\")))}%=\ l:%l\,%L\ c:%c%V\ %P
" Coffee Script handling
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
au BufNewFile,BufReadPost *.iced setl foldmethod=indent nofoldenable
au BufNewFile,BufReadPost *.iced setl shiftwidth=2 expandtab
" type "set go+=m or go+=T or r to add te things back in on the fly
let g:indent_guides_guide_size = 1
let g:tagbar_type_javascript = { 'ctagsbin' : 'jsctags'  }
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>
map <Leader>k :bnext<cr>
map <Leader>j :bprevious<cr>
map <Leader>l :tabnext<cr>
map <Leader>h :tabprevious<cr>
map <Leader>n :NERDTree<cr>
map <Leader>fd :FufDir<cr>
map <Leader>ff :FufFile<cr>
map <Leader>fb :FufBuffer<cr>
map <Leader>fj :FufJumpList<cr>
map <Leader>fq :FufQuickfix<cr>
map <Leader>fl :FufLine<cr>
map <Leader>ft :FufTag<cr>
map <Leader>ftc :FufTagWithCursorWord<cr>
map <Leader>t :TagbarToggle<cr>
imap <C-Space> <C-x><C-o>
call pathogen#infect()
call pathogen#helptags()
colorscheme Tomorrow-Night
