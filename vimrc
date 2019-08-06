" General
set nocompatible
syntax on
filetype plugin indent on

"" Tabstops/Search/...
set expandtab
set softtabstop=4
set shiftwidth=4
set hlsearch
set incsearch
set showcmd
set number
set laststatus=2
set textwidth=0
set splitbelow
set splitright
set bs=2
set whichwrap+=<,>,[,]
set noeol
set scrolloff=3
set secure
set exrc
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif
if $TMUX != ''
    set clipboard=unnamed
endif
set wildmenu
set wildmode=longest:full,full
set tags=tags;/
set updatetime=100

" Python
let g:python3_host_prog = '/usr/local/bin/python3'

" Characters
set lcs=tab:▸\ ,nbsp:·
set list
inoremap   <space>

" Leader
let mapleader=","
let maplocalleader=","
let g:mapleader=","

" Mappings
nnoremap <C-Space> :nohl<CR>
nnoremap <F6> :set number!<CR>
noremap <leader>ss :w !sudo tee % > /dev/null<CR>
noremap q: :q

" Navigate Splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
    " Theme
    Plug 'altercation/vim-colors-solarized'
    Plug 'itchyny/lightline.vim'

    " Format & Move
    Plug 'junegunn/vim-easy-align'
    Plug 'easymotion/vim-easymotion'
    Plug 'bronson/vim-trailing-whitespace'
    Plug 'wellle/targets.vim'
    Plug 'tpope/vim-sleuth'

    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " Integration
    Plug 'christoomey/vim-tmux-navigator'

    " Utils
    Plug 'Shougo/vimproc.vim', {'do' : 'make'}
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-surround'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'ludovicchabant/vim-gutentags'

    " Completion
    Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " Clojure
    Plug 'tpope/vim-dispatch'
    Plug 'tpope/vim-fireplace'
    Plug 'tpope/vim-salve'
    Plug 'tpope/vim-projectionist'
    "Plug 'guns/vim-clojure-static'
    Plug 'guns/vim-sexp'
    Plug 'tpope/vim-sexp-mappings-for-regular-people'
    Plug 'luochen1990/rainbow'

    " TypeScript
    Plug 'HerringtonDarkholme/yats.vim'

    " GraphQL
    Plug 'jparise/vim-graphql'

    " Markdown
    Plug 'plasticboy/vim-markdown'
call plug#end()

" Appearance
set background=light
silent! colorscheme solarized
let g:extra_whitespace_ignored_filetypes = ['unite', 'mkd', 'grep', 'search']

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=254
endif

let g:lightline = {
      \ 'colorscheme': 'solarized',
  \ }

" Clojure
function! SetupClojure()
    " vim-fireplace + vim-sexp
    nmap <buffer> cee :%Eval<CR>
    nmap <buffer> css :Eval<CR>
    nmap <buffer> ctt :RunTests<CR>
    nmap <buffer> cpc :cclose<CR>
    nmap <buffer> caa :A<CR>
    nmap <buffer> cac :AV<CR>
    nmap <buffer> crc :silent unlet g:salve_auto_start_repl<CR>:Connect nrepl://
    nmap <buffer> <Leader>S  <Leader>@

    " vim-clojure-static
    if !exists('g:clojure_loaded')
        let g:clojure_fuzzy_indent = 1
        let g:clojure_align_multiline_strings = 1
        let g:clojure_loaded = 1
    endif

    let g:salve_auto_start_repl = 1
endfu
autocmd BufNewFile,BufRead *.cljx set filetype=clojure
autocmd FileType clojure :call SetupClojure()

" rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
            \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
            \   'ctermfgs': ['darkyellow', 'darkred', 'darkblue', 'darkcyan', 'darkmagenta', 'darkblue'],
            \   'operators': '_,_',
            \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
            \   'separately': {
            \       '*': {},
            \       'clojure': {
            \           'ctermfgs': ['darkred', 'darkcyan', 'darkyellow', 'darkblue', 'darkcyan', 'darkmagenta', 'darkblue'],
            \       },
            \       'tex': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
            \       },
            \       'vim': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
            \       },
            \       'html': {
            \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
            \       },
            \       'css': 0,
            \   }
            \}

" Fugitive
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>gm :Gmove<CR>
nnoremap <leader>gp :Dispatch Git push<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gw :Gwrite<CR>

" GitGutter
nnoremap <leader>gg :GitGutterToggle<CR>
nmap ]c <Plug>GitGutterNextHunk
nmap [c <Plug>GitGutterPrevHunk
highlight GitGutterAdd    ctermfg=2 ctermbg=7
highlight GitGutterChange ctermfg=3 ctermbg=7
highlight GitGutterDelete ctermfg=1 ctermbg=7

" EasyMotion
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-s2)
nmap  <Leader>f <Plug>(easymotion-f)
nmap  <Leader>F <Plug>(easymotion-F)
nmap  <Leader>L <Plug>(easymotion-bd-jk)

" EasyAlign
nmap ga <plug>(EasyAlign)
xmap ga <plug>(EasyAlign)

" Gundo
nnoremap <leader>m :GundoToggle<CR>

" Markdown
au FileType markdown :set textwidth=80
let g:vim_markdown_folding_disabled = 1

" Plain
let g:PlainBufferSet = 0
function! PlainBuffer()
    if g:PlainBufferSet == 0
        GitGutterDisable
        set nonumber
        let g:PlainBufferSet = 1
    else
        GitGutterEnable
        set number
        let g:PlainBufferSet = 0
    endif
endfu

nmap <Leader>P :call PlainBuffer()<CR>

" Language Server (coc)
set updatetime=300

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

nmap <silent> [h <Plug>(coc-diagnostic-prev)
nmap <silent> ]h <Plug>(coc-diagnostic-next)
nmap <silent> gh <Plug>(coc-diagnostic-info)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)

" Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Fuzzy Finder
let g:fzf_layout = { 'down': '~20%' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --iglob "!.git"'
  noremap <C-B> :Rg<CR>
endif

noremap <C-P>      :Files<CR>
noremap <C-I><C-I> :Buffers<CR>
