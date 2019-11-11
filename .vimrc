set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/nerdcommenter'

Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
Plugin 'google/vim-searchindex'

Plugin 'Valloric/YouCompleteMe'

Plugin 'w0rp/ale'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'airblade/vim-gitgutter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'bazelbuild/vim-bazel'
Plugin 'bazelbuild/vim-ft-bzl'
Plugin 'SirVer/ultisnips'
Plugin 'beomyeol/vim-snippets'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'lervag/vimtex'
Plugin 'plasticboy/vim-markdown'
Plugin 'majutsushi/tagbar'
Plugin 'vim-misc' "required for easytags
Plugin 'easytags.vim'
"Plugin 'brookhong/cscope.vim'
"Plugin 'rdnetto/YCM-Generator'
Plugin 'mileszs/ack.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'Yggdroot/indentLine'

Plugin 'altercation/vim-colors-solarized'
Plugin 'kristijanhusak/vim-hybrid-material'
Plugin 'rakr/vim-one'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set t_Co=256
syntax on
set number
set ruler
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set backspace=indent,eol,start
set linespace=1
set autoindent
set cindent
set cinoptions+=g1,h2
set hlsearch
set incsearch

" ============================ Color schemes =================================
if has('osx')
  " MacOS
  if has('gui_running')
    set background=dark
    let g:airline_theme = "hybrid"
    set linespace=3
    set guifont=Menlo\ for\ Powerline:h12
    colorscheme hybrid_material
  else
    " One
    "Credit joshdick
    "Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
    "If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
    "(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
    "if (empty($TMUX))
      "if (has("nvim"))
      ""For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
      "let $NVIM_TUI_ENABLE_TRUE_COLOR=1
      "endif
      ""For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
      ""Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
      "" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
      "if (has("termguicolors"))
        "set termguicolors
      "endif
    "endif
    "set background=light
    "let g:one_allow_italics=1
    "colorscheme one

    " Solarized
    let g:solarized_termtrans=1
    set background=dark
    colorscheme solarized
  endif
else
  if has('gui_running')
    set guifont=Meslo\ LG\ S\ for\ Powerline\ 10
    set linespace=0
  endif
  " Solarized
  let g:solarized_termtrans=1
  set background=dark
  colorscheme solarized
endif

set colorcolumn=80
set cursorline

" ======================= Plugin configurations ==============================

let g:ale_lint_on_save = 1
let g:ale_python_pylint_use_global = 1
let g:ale_python_pylint_options = '--max-line-length=80'

" NERDTree
silent! map <F2> :NERDTreeToggle<CR>
"silent! map <F3> :NERDTreeFind<CR>
"let g:NERDTreeMapActivateNode="<F3>"

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let g:nerdtree_tabs_open_on_gui_startup=0

" YCM
"let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
au FileType c,cpp,python nnoremap <F12> :YcmCompleter GoTo<CR>
"nnoremap <C-F12> :YcmCompleter GoToDeclaration<CR>

" Eclim
"let g:EclimCompletionMethod = 'omnifunc'

" ctags
set tags=./tags;
" Easytags
"let g:easytags_dynamic_files=2
let g:easytags_dynamic_files=1
let g:easytags_async=1

" Tabs
nnoremap <C-t> :tabnew<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>

" fugitive
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gl :Git log --graph --pretty=format:"\%Cred\%h\%Creset -\%C(yellow)\%d\%Creset \%s \%Cgreen(%cr) \%C(bold blue)<\%an>\%Creset" --abbrev-commit<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gp :Git push<CR>

" Airline
let g:airline_powerline_fonts = 1
set laststatus=2

" Spell
"setlocal spell spelllang=en_us
autocmd FileType gitcommit setlocal spell spelllang=en_us
autocmd FileType tex setlocal spell spelllang=en_us

" Latex
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
let g:vimtex_compiler_latexmk = {'callback' : 0}
let g:tex_conceal = ""

function CreateTags()
  let curNodePath = g:NERDTreeFileNode.GetSelected().path.str()
  exec ':!ctags -R --languages=c++,python -f ' . curNodePath . '/tags ' . curNodePath
endfunction
nmap <silent> <F4> :call CreateTags()<CR>

" CScope
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>

" s: Find this C symbol
nnoremap <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>

" Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack! <cword><CR>

" glaive
call glaive#Install()
Glaive codefmt plugin[mappings] clang_format_style='google'
if !has('osx')
  Glaive codefmt clang_format_executable='clang-format-4.0'
endif

" google codefmt
"augroup autoformat_settings
  "autocmd FileType bzl AutoFormatBuffer buildifier
  "autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  "autocmd FileType dart AutoFormatBuffer dartfmt
  "autocmd FileType go AutoFormatBuffer gofmt
  "autocmd FileType gn AutoFormatBuffer gn
  "autocmd FileType html,css,json AutoFormatBuffer js-beautify
  "autocmd FileType java AutoFormatBuffer google-java-format
  "autocmd FileType python AutoFormatBuffer yapf
  "" Alternative: autocmd FileType python AutoFormatBuffer autopep8
"augroup END

" vim-better-whitespace / automatically remove whitespace
autocmd BufEnter * EnableStripWhitespaceOnSave

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

set clipboard^=unnamed,unnamedplus

set pastetoggle=<F3>
command! -nargs=* Py !python % <args>

" indentLine
let g:indentLine_fileTypeExclude = ['json', 'markdown']
let g:vim_markdown_conceal=0
let g:vim_markdown_folding_disabled=1
let g:vim_json_conceal=0
