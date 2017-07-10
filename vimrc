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
set secure
set exrc
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif
if $TMUX == ''
    set clipboard=unnamed
endif
set wildmenu
set wildmode=longest:full,full

" Characters
set lcs=tab:▸\ ,nbsp:·
set list
inoremap   <space>

" Leader
let mapleader=","
let maplocalleader=","
let g:mapleader=","

" Mappings
nnoremap <C-@> :nohl<CR>
nnoremap <F6> :set number!<CR>
noremap <leader>ss :w !sudo tee % > /dev/null<CR>
noremap q: :q

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
"bundle airblade/vim-gitgutter
"bundle altercation/vim-colors-solarized
"bundle asciidoc/vim-asciidoc
"bundle bling/vim-airline
"bundle bronson/vim-trailing-whitespace
"bundle christoomey/vim-tmux-navigator
"bundle easymotion/vim-easymotion
"bundle ekalinin/Dockerfile
"bundle guns/vim-clojure-static
"bundle guns/vim-sexp
"bundle junegunn/vim-easy-align
"bundle juvenn/mustache.vim
"bundle lambdatoast/elm.vim
"bundle luochen1990/rainbow
"bundle pangloss/vim-javascript
"bundle Shougo/neomru
"bundle Shougo/unite
"bundle Shougo/vimproc.vim
"bundle sjl/gundo
"bundle tomtom/tcomment_vim
"bundle tpope/vim-dispatch
"bundle tpope/vim-fireplace
"bundle tpope/vim-fugitive
"bundle tpope/vim-markdown
"bundle tpope/vim-projectionist
"bundle tpope/vim-repeat
"bundle tpope/vim-salve
"bundle tpope/vim-sexp-mappings-for-regular-people
"bundle tpope/vim-sleuth
"bundle wellle/targets

" Appearance
set background=light
silent! colorscheme solarized
let g:extra_whitespace_ignored_filetypes = ['unite', 'mkd', 'grep', 'search']

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=254
endif

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

" Unite
let g:unite_winheight = 10
let g:unite_source_history_yank_enable = 1
let g:unite_split_rule = 'botright'
if executable('pt')
    let g:unite_source_grep_command = 'pt'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_grep_encoding = 'utf-8'
elseif executable('ack')
    let g:unite_source_grep_command = 'ack'
    let g:unite_source_grep_default_opts = '-i --no-heading --no-color -k -H'
    let g:unite_source_grep_recursive_opt = ''
endif
call unite#custom#source('file_rec/async','sorters','sorter_rank')
call unite#custom#source('file_rec/async','matchers',['converter_relative_word', 'matcher_fuzzy'])
call unite#custom#source(
            \ 'file_rec/async',
            \ 'ignore_pattern',
            \ '\(\/\(target\|out\|node_modules\)\/\|\.\(nrepl\|lein\)-.*\|pom\.xml\|pom\.xml\.asc\)'
            \ )
nnoremap <C-P>      :<C-U>Unite -buffer-name=files -start-insert file_rec/async<CR>
nnoremap <C-I><C-P> :<C-U>Unite -buffer-name=files -start-insert file_rec/async -default-action=vsplit<CR>
nnoremap <C-I><C-I> :<C-U>Unite -buffer-name=buffers -start-insert buffer<CR>
nnoremap <C-I><C-O> :<C-U>Unite -buffer-name=recent-files -start-insert file_mru<CR>
nnoremap <C-I><C-U> :<C-U>Unite -buffer-name=grep grep:.:<CR>
nnoremap <C-I><C-K> :<C-U>Unite -start-insert file/new<CR>

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

" Paste
set pastetoggle=<leader>pp

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
