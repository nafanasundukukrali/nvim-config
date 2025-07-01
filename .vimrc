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

" Настройки буфера обмена (clipboard)
set clipboard=unnamedplus       " Использовать системный буфер обмена (+ регистр)
set mouse=a                      " Включить мышь во всех режимах

" Автоматическое чтение файла при изменении извне
set autoread
au FocusGained,BufEnter * checktime

" Плагины (через vim-plug)
call plug#begin('~/.vim/plugged')

" Менеджер LSP (coc.nvim)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Дополнительные плагины (опционально)
Plug 'preservim/nerdtree'        " Файловый менеджер
Plug 'vim-airline/vim-airline'   " Статусная строка
Plug 'tpope/vim-commentary'      " Комментирование кода

call plug#end()

" ==================== Настройки coc.nvim ====================
" Проверяем, установлен ли node (обязательно для coc.nvim)
if !executable('node')
  echo "Node.js не установлен! Coc.nvim требует Node.js."
endif

" Автодополнение и LSP
let g:coc_global_extensions = [
  \ 'coc-clangd',               " C/C++
  \ 'coc-pyright',              " Python
  \ 'coc-sh',                   " Bash
  \ 'coc-json',                 " JSON
  \ 'coc-snippets',             " Сниппеты
  \ ]

" Горячие клавиши для coc.nvim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> K :call CocAction('doHover')<CR>

" Enter для подтверждения автодополнения
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" ==================== Дополнительные настройки ====================
syntax enable
set expandtab                   " Заменять табы на пробелы

" Автоотступ
filetype plugin indent on
