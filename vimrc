" General
set nocompatible
call pathogen#infect()
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
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set secure
set exrc
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif
set clipboard=unnamed

" Leader
let mapleader=","
let maplocalleader=","
let g:mapleader=","

" Mappings
nnoremap <C-@> :nohl<CR>
nnoremap <F6> :set number!<CR>
noremap <leader>ss :w !sudo tee % > /dev/null<CR>

" Force my Hand
inoremap jj <ESC>
inoremap <ESC> <NOP>
noremap <UP> <NOP>
noremap <DOWN> <NOP>
noremap <LEFT> <NOP>
noremap <RIGHT> <NOP>

" Navigate Splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Microbe Bundles
"bundle altercation/vim-colors-solarized
"bundle bling/vim-airline
"bundle bronson/vim-trailing-whitespace
"bundle christoomey/vim-tmux-navigator
"bundle guns/vim-clojure-static
"bundle guns/vim-sexp
"bundle juvenn/mustache.vim
"bundle Lokaltog/vim-easymotion
"bundle pangloss/vim-javascript
"bundle Shougo/unite
"bundle Shougo/neomru
"bundle Shougo/vimproc.vim
"bundle tpope/vim-dispatch
"bundle tpope/vim-fireplace
"bundle tpope/vim-fugitive
"bundle tpope/vim-leiningen
"bundle tpope/vim-projectionist
"bundle tpope/vim-sexp-mappings-for-regular-people

" Appearance
set background=dark
silent! colorscheme solarized
let g:extra_whitespace_ignored_filetypes = ['unite', 'mkd', 'grep', 'search']

" Clojure
function! SetupClojure()
    " vim-fireplace + vim-sexp
    nmap <buffer> cee :%Eval<CR>
    nmap <buffer> css :Eval<CR>
    nmap <buffer> ctt :RunTests<CR>
    nmap <buffer> cpc :cclose<CR>
    nmap <buffer> caa :A<CR>
    nmap <buffer> cac :AV<CR>
    nmap <buffer> crc :let g:leiningen_no_auto_repl=1<CR>:Connect nrepl://
    nmap <buffer> <Leader>S  <Leader>@

    " vim-clojure-static
    if !exists('g:clojure_loaded')
        let g:clojure_fuzzy_indent = 1
        let g:clojure_special_indent_words .= ',fact,facts,defprotocol+,defcomponent,defsystem'
        let g:clojure_align_multiline_strings = 1
        let g:clojure_loaded = 1
    endif
endfu
autocmd BufNewFile,BufRead *.cljx set filetype=clojure
autocmd FileType clojure :call SetupClojure()

" Unite
let g:unite_winheight = 10
let g:unite_source_history_yank_enable = 1
let g:unite_split_rule = 'botright'
let g:unite_source_grep_command = 'ack'
let g:unite_source_grep_default_opts = '-i --no-heading --no-color -k -H'
let g:unite_source_grep_recursive_opt = ''
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file_rec/async','sorters','sorter_rank')
nnoremap <C-P>      :<C-U>Unite -start-insert file_rec/async -default-action=vsplit<CR>
nnoremap <leader>uu :<C-U>Unite -buffer-name=recent file_mru -default-action=vsplit<CR>
nnoremap <leader>un :<C-U>Unite -start-insert file/new -default-action=vsplit<CR>
nnoremap <leader>ug :<C-U>Unite -no-split -buffer-name=grep grep:.:<CR>

" Fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gc :Gcommit<CR>

" EasyMotion
let g:EasyMotion_smartcase = 1
nmap s <plug>(easymotion-s2)
map <leader>j <plug>(easymotion-j)
map <leader>k <plug>(easymotion-k)
