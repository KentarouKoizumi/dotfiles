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

set statusline=%F%m%h%w\ %=%<[ENC=%{&fenc!=''?$fenc:&enc}]\ [FMT=%{&ff}]\ [TYPE=%Y]\ [POS=%l/%L(%02v)]
