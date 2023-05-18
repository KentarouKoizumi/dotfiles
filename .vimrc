set fenc=utf-8
set wildmenu
set autoread
set hidden

set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch

set visualbell
set showmatch matchtime=1
" set cinoptions+=:0
set laststatus=2
set showcmd
set display=lastline
set list
set listchars=tab:^\ ,trail:~
set expandtab
set shiftwidth=2
set tabstop=2
set guioptions+=a
set showmatch
set smartindent
set title
set clipboard=unnamed,autoselect
syntax on
nnoremap <Esc><Esc> :nohlsearch <CR><Esc>
set number

colorscheme molokai
let g:molokai_original=1
set background=dark
set termguicolors

set statusline=%F%m%h%w\ %=%<[ENC=%{&fenc!=''?$fenc:&enc}]\ [FMT=%{&ff}]\ [TYPE=%Y]\ [POS=%l/%L(%02v)]

""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif
""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')
Plug 'nathanaelkane/vim-indent-guides'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
call plug#end()
let g:indent_guides_enable_on_vim_startup=1
set noshowmode
let g:lightline = {
      \ 'colorscheme' : 'wombat',
      \ 'active':{
      \   'left': [ [ 'mode', 'paste',],
      \             [ 'readonly', 'gitbranch', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B',
      \   'lineinfo': '%l[%L]:%c',
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }



