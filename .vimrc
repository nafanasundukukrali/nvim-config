call plug#begin()
  Plug 'preservim/nerdtree'
call plug#end()

set number	
set linebreak	
set showbreak=+++	
set textwidth=100
set showmatch	
set spell	
set visualbell	
 
set hlsearch	
set smartcase	
set ignorecase	
set incsearch
 
set autoindent	
set cindent 
set expandtab	
set shiftwidth=4    
set smartindent	
set smarttab
set softtabstop=4	
 
set confirm 
set ruler	
 
set undolevels=1000
set backspace=indent,eol,start

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Start NERDTree and leave the cursor in it.
autocmd VimEnter * NERDTree
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

set clipboard=unnamedplus       " Использовать системный буфер
set mouse=a                     " Включить мышь


" Плагины (через vim-plug)
call plug#begin('~/.vim/plugged')
Plug 'rose-pine/vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " LSP
Plug 'preservim/nerdtree'                        " Файловый менеджер
call plug#end()

" Rose Pine
set background=dark
colorscheme rosepine_moon

" LSP-расширения для coc.nvim
let g:coc_global_extensions = [
  \ 'coc-clangd',               
  \ 'coc-pyright',              
  \ 'coc-sh',                   
  \ 'coc-json',                 
  \ 'coc-snippets',             
  \ ]

" Горячие клавиши для LSP
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" === Умный Tab ===
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <silent><expr> <S-Tab>
      \ pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Подтверждение выбора Enter/Ctrl+Y
inoremap <silent><expr> <CR>
      \ pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction
