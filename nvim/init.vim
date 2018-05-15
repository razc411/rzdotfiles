set nocompatible              " be iMproved, required
filetype off                  
" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'ervandew/supertab'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'scrooloose/nerdtree'
Plugin 'flazz/vim-colorschemes'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'bling/vim-airline'
Plugin 'gorodinskiy/vim-coloresque'
Plugin 'w0rp/ale'
Plugin 'jacoborus/tender.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'altercation/vim-colors-solarized'
Plugin 'elzr/vim-json'
Plugin 'chriskempson/base16-vim'
Plugin 'mileszs/ack.vim'
Plugin 'ekalinin/dockerfile.vim'
Plugin 'vimwiki/vimwiki'
Plugin 'hashivim/vim-terraform'
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
" Put your non-Pluginkstuff after this line
set number
set runtimepath^=~/.config/nvim/bundle/ctrlp.vim
set backupdir=~/.cache/nvim
set autoread
set scrolloff=1
set sidescrolloff=5
syntax enable
set wrap
set confirm
set hidden
set nowrap
set history=1000
set undolevels=1000
" search options
set hlsearch
set ignorecase
set incsearch
set smartcase
" tab options
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set shiftround
set smarttab
set textwidth=200
"
" Protect large files from sourcing and other overhead.
" Files become read only
if !exists("my_auto_commands_loaded")
  let my_auto_commands_loaded = 1
  " Large files are > 10M
  " Set options:
  " eventignore+=FileType (no syntax highlighting etc
  " assumes FileType always on)
  " noswapfile (save copy of file)
  " bufhidden=unload (save memory when other file is viewed)
  " buftype=nowrite (file is read-only)
  " undolevels=-1 (no undo possible)
  let g:LargeFile = 1024 * 1024 * 10
  augroup LargeFile
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
    augroup END
  endif

let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'
let g:SuperTabCrMapping=1
let mapleader="\\"

let g:ackprg = 'ag --vimgrep --smart-case'                                                   
cnoreabbrev ag Ack                                                                           
cnoreabbrev aG Ack                                                                           
cnoreabbrev Ag Ack                                                                           
cnoreabbrev AG Ack  

" vim-js-configs
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0
syntax enable
colorscheme tender
" colorscheme spacegray
" colorscheme base16-default-dark

hi Search ctermbg=LightBlue ctermfg=black    
" ctrlP config
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark 
map <leader>nf :NERDTreeFind<cr>

let g:ctrlp_map = '<c-f>'

map <F4> :%s///gn <CR>
noremap i <Up>
noremap j <Left>
noremap k <Down>
noremap h i
nnoremap ; :
nnoremap <F3> :noh<CR>

noremap <C-j> <C-w>h
noremap <C-i> <C-w>k
noremap <C-k> <C-w>j
noremap <C-l> <C-w>l

let g:NERDTreeMapOpenSplit = 'h'
let g:NERDTreeMapPreviewSplit = 'gh'

nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP
noremap <leader>c gg<C-v>GI//<Esc>
noremap <leader>nc gg<C-v>Glx<Esc>

nnoremap <silent> <leader>s :set spell!<cr>
noremap <Esc> <C-\><C-n> 
set pastetoggle=<F2>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\node_modules\|\build\|\.git$\|\.yardoc\|\log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

" Custom Commands
"

""" Search and Replace
:"Search and replace func
function! SearchAndReplaceCDO(original, replacement, scope)
  let scope = 'g'
  if a:scope
    scope = 'gc' 
  endif
  execute ":cdo s/" . a:original . "/" . a:replacement . "/" . scope . " | update" 
endfunction


command! -nargs=* -complete=file -bar Scr call SearchAndReplaceCDO(<f-args>)<CR> 

command! Writesudo execute ":w !sudo tee %"

" Ctrl S save shortcut
" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
command! -nargs=0 -bar Update if &modified 
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif
nnoremap <silent> <C-S> :<C-u>Update<CR>

function! FindAtCursor(original, replacement) 
    execute ",$s/" + a:original + "/" + a:replacement + "/gc|1,\'\'-&&"
endfunction

command! -nargs=* -bar SR call FindAtCursor(<f-args>)<CR>

function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction



function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>e :call ToggleList("Quickfix List", 'c')<CR>

