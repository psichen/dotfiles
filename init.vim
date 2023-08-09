call plug#begin('~/.vim/plugged')

Plug 'dracula/vim'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'easymotion/vim-easymotion'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdcommenter'
Plug 'luochen1990/rainbow'
Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lervag/vimtex'
Plug 'kmonad/kmonad-vim'

call plug#end()

" :PlugInstall
" :PlugUpdate
" :PlugUpgrade
" :PlugClean

" User custom
colorscheme dracula
set termguicolors
let mapleader = " "
set nu rnu
set tabstop=4
set expandtab
set nojoinspaces
set ignorecase
set smartcase
set scrolloff=3
set sidescrolloff=5
set noswapfile
set nobackup
set autowrite
set conceallevel=2
set foldmethod=indent

au BufNewFile,BufRead *.ejs set filetype=html

nmap <Leader>1 "1p
nmap <Leader>2 "2p
nmap <Leader>3 "3p
nmap <Leader>4 "4p
nmap <Leader>5 "5p
nmap <Leader>6 "6p
nmap <Leader>7 "7p
nmap <Leader>8 "8p
nmap <Leader>9 "9p
nmap <Leader>0 "0p

set hlsearch
nnoremap <c-j> 20j
nnoremap <c-k> 20k
vnoremap <c-j> 20j
vnoremap <c-k> 20k
inoremap <c-j> 20j
inoremap <c-k> 20k
nnoremap <silent> <leader>s :set spell<cr>
nnoremap <silent> <leader><cr> :noh<cr>:set nospell<cr>

map <Leader>r :call CompileRun()<CR>

func! CompileRun()
        exec "w"
if &filetype == 'wls'
        exec "!wolframscript -print -f %"
elseif &filetype == 'python'
        exec "!python3 % | more"
endif
endfunc

"  NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>
let NERDTreeShowLineNumbers = 1

"" markdown-preview.nvim
"let g:mkdp_refresh_slow=1
"let g:mkdp_command_global=0
"nmap <Leader>p <Plug>MarkdownPreview

" vim-instant-markdown
let g:instant_markdown_autostart = 0
let g:instant_markdown_mathjax = 1
let g:instant_markdown_mermaid = 1
let g:instant_markdown_autoscroll = 0
nmap <Leader>p :InstantMarkdownPreview<CR>

" lightline
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'method' ] ]
      \ },
      \ 'component_function': {
      \   'method': 'NearestMethodOrFunction'
      \ },
      \ }

" Rainbow Parentheses Improved
let g:rainbow_active = 1

" auto-pairs
let g:AutoPairsFlyMode = 0

" tabular
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a\| :Tabularize /\|<CR>
vmap <Leader>a\| :Tabularize /\|<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME."/Documents/Github/psichen.github.io/.scripts"]

" vim-surround
nmap <Leader>" yst)"

" vim-pandoc
let g:pandoc#modules#disabled = ['folding', 'spell']

" vim-pandoc-syntax
let g:pandoc#syntax#conceal#cchar_overrides = {"\\(" : ""}
let g:pandoc#syntax#conceal#cchar_overrides = {"\\)" : ""}
let g:pandoc#syntax#conceal#cchar_overrides = {"\\[" : ""}
let g:pandoc#syntax#conceal#cchar_overrides = {"\\]" : ""}

" vimtex
map <leader>l :w<CR>:VimtexCompileSS<CR>:VimtexView<CR>
filetype plugin indent on
syntax enable
let g:vimtex_view_method='sioyek'
let g:vimtex_quickfix_mode=0
"let g:vimtex_indent_enabled=0
