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
set updatetime=300
set mouse=

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

" Autocomplete
set completeopt=menu,noinsert,preview
inoremap <expr><CR> pumvisible() ? "\<C-Y>" : "\<CR>"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Navigate Splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Colemak hack
nnoremap <C-I> :TmuxNavigateRight<CR>

" Plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
    " Theme
    Plug 'altercation/vim-colors-solarized'
    Plug 'lifepillar/vim-solarized8'
    Plug 'itchyny/lightline.vim'

    " Format & Move
    Plug 'junegunn/vim-easy-align'
    Plug 'phaazon/hop.nvim'
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
    Plug 'tpope/vim-projectionist'

    " CoC
    Plug 'neoclide/coc.nvim', {
          \ 'branch': 'release',
          \ 'do': { -> coc#util#install()},
          \ 'for': [ 'clojure' ]
          \ }
    Plug 'josa42/vim-lightline-coc'

    " Completion
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " Clojure
    Plug 'guns/vim-sexp',    {'for': 'clojure'}
    Plug 'liquidz/vim-iced', {'for': 'clojure'}
    Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}

    " File Formats
    Plug 'plasticboy/vim-markdown'
    Plug 'stephpy/vim-yaml'
call plug#end()

" Appearance
set background=light
if (has('termguicolors'))
    set termguicolors
endif

function! AdaptColorscheme()
    hi! link SignColumn LineNr
    hi! MatchParen cterm=bold ctermbg=14 gui=bold guifg=#dc322f guibg=#eee8d5
endfunction

autocmd vimenter * ++nested colorscheme solarized8
autocmd vimenter * :call AdaptColorscheme()

let g:extra_whitespace_ignored_filetypes = ['unite', 'mkd', 'grep', 'search']

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight link ColorColumn LineNr
endif

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \     'left': [ [ 'mode', 'paste' ],
      \               [ 'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings' ],
      \               [ 'coc_status' ]]
      \ },
      \ }
call lightline#coc#register()

" CoC
nmap <silent> <leader>cc <Plug>(coc-diagnostic-next)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Projectionist
function! s:init_projectionist()
    nmap <silent> <leader>gt :AV<CR>
    let g:projectionist_heuristics = {
          \   'project.clj': {
          \     'src/*.clj':
          \       {'type': 'source', 'alternate': 'test/{}_test.clj', 'template': ['(ns {dot|hyphenate})']},
          \     'src/*.cljc':
          \       {'type': 'source', 'alternate': 'test/{}_test.cljc', 'template': ['(ns {dot|hyphenate})']},
          \     'test/*_test.clj':
          \       {'type': 'test', 'alternate': 'src/{}.clj', 'template': ['(ns {dot|hyphenate}-test)']},
          \     'test/*_test.cljc':
          \       {'type': 'test', 'alternate': 'src/{}.cljc', 'template': ['(ns {dot|hyphenate}-test)']},
          \   }
          \ }
endfunction

" Clojure
let g:iced_enable_default_key_mappings = v:true
let g:iced_enable_auto_indent = v:false
aug VimIced
  au!
  au FileType clojure nmap <buffer> <leader>e! <Plug>(iced_eval_and_comment)<Plug>(sexp_outer_list)
  au FileType clojure nmap <buffer> <leader>gtt <Plug>(iced_cycle_src_and_test)
  au FileType clojure nmap <buffer> <leader>gt :vs<CR><Plug>(iced_cycle_src_and_test)
aug end

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
nmap ]c <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)
highlight GitGutterAdd    ctermfg=2 ctermbg=7
highlight GitGutterChange ctermfg=3 ctermbg=7
highlight GitGutterDelete ctermfg=1 ctermbg=7

" Hop
lua require'hop'.setup()
nmap <silent> s :HopChar2<CR>

" EasyAlign
nmap ga <plug>(EasyAlign)
xmap ga <plug>(EasyAlign)

" Markdown
au FileType markdown :set textwidth=80
let g:vim_markdown_folding_disabled = 1

" YAML
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

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
endif

noremap <C-P>            :Files<CR>
noremap <leader>b        :Buffers<CR>
noremap <leader><leader> :Rg<CR>

" To maintain vim-tmux-navigator functionality, C-I (which also maps to TAB)
" is remapped to C-L in tmux.conf. This breaks TAB in insert mode, so we need
" to fix it.
inoremap <C-L> <TAB>
