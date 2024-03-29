set nocompatible
set encoding=utf-8
set backupdir=./.backup,/tmp,/home/matt/.backup
"set directory=.,/home/matt/.backup,./.backup,/tmp
set directory=/home/matt/.backup,./.backup,/tmp
let mapleader = "\<Space>"
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
" inoremap jj <Esc>
" nnoremap JJJJ <Nop>
" let NERDTreeDirArrows=0
if has("gui_running")
  autocmd GUIEnter * set vb t_vb=
endif
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set softtabstop=2
set autoindent
set bs=2
set background=dark
set wrapmargin=8
set ruler
set guifont=JetBrains\ Mono\ 12
syntax on
"colorscheme badwolf
set number
if has("autocmd")
	filetype plugin indent on
    autocmd FileType json setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2
endif
au BufNewFile,BufReadPost *.template setl shiftwidth=2 expandtab tabstop=2 softtabstop=2

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
map <Leader>p "+p
map <Leader>y "+y
map <Leader>P "*p
map <Leader>Y "*y

" Mini tabs, small "m":
map \m <Esc>:set expandtab tabstop=2 shiftwidth=2<CR>
map \M <Esc>:set expandtab tabstop=4 shiftwidth=4<CR>

imap <C-Space> <C-x><C-o>
call plug#begin('~/.vim/plugged')

" YCM autocompletion 
Plug 'ycm-core/YouCompleteMe'

" git integration
Plug 'tpope/vim-fugitive'

" vim go tools
Plug 'fatih/vim-go'

" navigation side bar - toggle with <leader>-n
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" comment tools <leader>c c
Plug 'scrooloose/nerdcommenter'

" indent guides <leader> i g
Plug 'nathanaelkane/vim-indent-guides'

" <leader> f f  fuzzy finder
Plug 'vim-scripts/L9' | Plug 'vim-scripts/FuzzyFinder'

" quick buffer switching 
" Plug 'vim-scripts/QuickBuf'

" common editor settings .editorconfig support
Plug 'editorconfig/editorconfig-vim'

" typescript syntax settings
Plug 'HerringtonDarkholme/yats.vim'

call plug#end()
colorscheme Tomorrow-Night
highlight LineNr guifg=#AAAAAA
let g:neocomplete#enable_at_startup = 1
