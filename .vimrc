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
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

Plugin 'The-NERD-tree'
Plugin 'majutsushi/tagbar' 
Plugin 'vim-misc'
Plugin 'easytags.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-airline'
Plugin 'vim-latex/vim-latex'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'brookhong/cscope.vim'
"Plugin 'rdnetto/YCM-Generator'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
"Plugin 'LaTeX-Box-Team/LaTeX-Box'
"Plugin 'wincent/command-t'
"Plugin 'crusoexia/vim-monokai'

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

" solarized
if has('gui_running')
  if has('gui_gtk2')
    set guifont=Meslo\ LG\ S\ for\ Powerline\ 10
  else
    " For MacVim
    set linespace=3
  endif
else
  let g:solarized_termtrans=1
  let g:solarized_termcolors=256
  "let g:solarized_contrast='normal'
endif
colorscheme solarized
set background=dark

" NERDTree
silent! map <F2> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>
let g:NERDTreeMapActivateNode="<F3>"

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" YCM
"let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
nnoremap <F12> :YcmCompleter GoToDefinition<CR>
nnoremap <C-F12> :YcmCompleter GoToDeclaration<CR>

" Eclim
"let g:EclimCompletionMethod = 'omnifunc'

" ctags
set tags=./.git/tags,.tags;
" Easytags
"let g:easytags_dynamic_files=2
let g:easytags_dynamic_files=1

" Tagbar
nmap <F8> :TagbarToggle<CR>

" fugitive
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
"nnoremap <Leader>gL :exe ':!cd ' . expand('%:p:h') . '; git la'<CR>
"nnoremap <Leader>gl :exe ':!cd ' . expand('%:p:h') . '; git las'<CR>
"nnoremap <Leader>gh :Silent Glog<CR>
"nnoremap <Leader>gH :Silent Glog<CR>:set nofoldenable<CR>
"nnoremap <Leader>gr :Gread<CR>
"nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gp :Git push<CR>
"nnoremap <Leader>g- :Silent Git stash<CR>:e<CR>
"nnoremap <Leader>g+ :Silent Git stash pop<CR>:e<CR>

" Airline
let g:airline_powerline_fonts = 1
set laststatus=2

" Spell
"setlocal spell spelllang=en_us
autocmd FileType gitcommit setlocal spell spelllang=en_us
autocmd FileType tex setlocal spell spelllang=en_us


" Latex
if has('osx')
  let g:Tex_ViewRule_pdf = 'open -a /Applications/PDF\ Expert.app'
elseif has('unix')
  let g:Tex_DefaultTargetFormat='pdf'
  let g:Tex_ViewRule_pdf='okular --unique 2>/dev/null'
endif

function CreateTags()
  let curNodePath = g:NERDTreeFileNode.GetSelected().path.str()
  exec ':!ctags -R --languages=c++,python -f ' . curNodePath . '/tags ' . curNodePath
endfunction
nmap <silent> <F4> :call CreateTags()<CR>

function! SetupPython()
  " Here, you can have the final say on what is set.  So
  " fixup any settings you don't like.
  setlocal softtabstop=2
  setlocal tabstop=2
  setlocal shiftwidth=2
endfunction
command! -bar SetupPython call SetupPython()

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

