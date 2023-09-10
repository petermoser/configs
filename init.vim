set nocompatible              " be iMproved
set shell=/usr/local/bin/zsh
"set shell=/bin/bash
filetype off                  " required!
set modifiable                " allow file operations (delete etc.) in NERDTree

" set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf

" call vundle#begin()
call plug#begin('~/.vim/plugged')
" install Vundle: git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" then run :PluginInstall
Plug 'gmarik/Vundle.vim'
" Plug 'Valloric/YouCompleteMe'
" Plug 'scrooloose/syntastic'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'christoomey/vim-system-copy'
" Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-commentary'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'elzr/vim-json'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
" Plug 'jiangmiao/auto-pairs'
Plug 'dart-lang/dart-vim-plugin'
Plug 'nvim-lua/plenary.nvim'
Plug 'machakann/vim-swap'

" Plug 'wookiehangover/jshint.vim'
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
" Startify: Fancy startup screen for vim {{{
Plug 'mhinz/vim-startify'
    " Don't change to directory when selecting a file
    let g:startify_files_number = 11
    let g:startify_change_to_dir = 0
    let g:startify_custom_header = [ ]
    let g:startify_relative_path = 1
    let g:startify_use_env = 1

    " Custom startup list, only show MRU from current directory/project
    let g:startify_lists = [
    \  { 'type': 'dir',       'header': [ 'Files '. getcwd() ] },
    \  { 'type': 'sessions',  'header': [ 'Sessions' ]       },
    \  { 'type': 'bookmarks', 'header': [ 'Bookmarks' ]      },
    \  { 'type': 'commands',  'header': [ 'Commands' ]       },
    \ ]

    let g:startify_commands = [
    \   { 'up': [ 'Update Plugins', ':PlugUpdate' ] },
    \   { 'ug': [ 'Upgrade Plugin Manager', ':PlugUpgrade' ] },
    \ ]

    let g:startify_bookmarks = [
        \ { 'c': '~/.config/nvim/init.vim' },
        \ { 'g': '~/.gitconfig' },
        \ { 'z': '~/.zshrc' }
    \ ]

    autocmd User Startified setlocal cursorline
    map <C-s> :Startify <CR>
" }}}

call plug#end()
" call vundle#end()
filetype plugin indent on     " required!
filetype plugin on

nnoremap <F10> :NERDTreeToggle <CR>
map <C-n> :NERDTreeFocus <CR>
map <C-g> :NERDTreeFind <CR>
let NERDTreeShowHidden=1
" autocmd vimenter * if !argc() | NERDTree | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q 
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
" let g:syntastic_javascript_checkers = ['jshint']

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ }

" disable the top preview window that shows in YouCompleteMe
" set completeopt-=preview

map <C-p> :Files<CR>
map <C-u> :Ack<CR>
nmap U <C-r>
map <C-y> " * y
" correcting bad indent while pasting
nnoremap p p=`]
" map the Q letter to insert a line and paste
:nmap Q o<esc>p
"
" have space-character insert a character
noremap <silent> <space> :exe "normal i".nr2char(getchar())<CR>
" escape key mapped to jk
inoremap jk <esc>
inoremap fd <esc> :w <CR>
noremap fd :w <CR>
inoremap <Esc> <Esc>:w<CR>

noremap fp :CocCommand prettier.formatFile<CR>

:nnoremap <Leader>q" ciw""<Esc>P
:nnoremap <Leader>q' ciw''<Esc>P

" ack: I don't want to jump to the first result automatically.
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" let g:ale_linters = {'javascript': ['eslint']}
" let b:ale_fixers = {'javascript': ['prettier', 'eslint']}
" let g:ale_completion_enabled = 1
" let g:ale_fix_on_save = 1
" let g:ale_enabled = 0
" let g:ale_javascript_eslint_use_global = 1
" let g:ale_linters = ['eslint']
" let g:ale_linters_explicit = 1
" let g:ale_fix_on_save = 1
" let g:ale_fixers = {
" \   'javascript': ['prettier'],
" \   'css': ['prettier'],
" \}


" delete without yanking
nnoremap D "_D
vnoremap D "_D
nnoremap x "_x
vnoremap x "_x
" replace currently selected text with default register
" without yanking it
vnoremap p "_dP
" insert tab
vnoremap <tab> >
vnoremap <S-tab> <
" quickly switch between windows
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
" ensure that file type json is set
au BufRead,BufNewFile *.json set filetype=json
" set line number on 
set number
set autoread                    "Reload files changed outside vim
" turn on syntax highlighting
syntax on
" magic for auto-completion at the : command line
set wildmenu
" turn ono the ruler status info bar at the bottom of the screen
set ruler
set hidden 
" indent ina a smart way, instead of returning to the left margin all the time
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
" expand tabs to spaces
set expandtab
" Don't wrap text (makes windows ugly)
set nowrap
" highlight all matches in a text when you search
set hlsearch
" do case insensitive searching
set ignorecase
" When a search phrase has uppercase, don't be cause insensitive
set smartcase
" when I want spell checking do it in english
set spelllang=en_us
" set the font color scheme for dark background
set background=dark
" set the constant color from default pink to green
highlight Constant ctermfg=Green  
" set the color of the suggestions menu
highlight Pmenu ctermfg=lightblue ctermbg=darkgrey guifg=#ffffff guibg=#000000
" set the color of the search highlight
highlight Search guifg=#ffffff guibg=#0000ff gui=none ctermfg=white ctermbg=darkblue 

" ======= running python apps using F9 function key =======
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb
" ================ Folds ============================
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default
" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif
" ================ Scrolling ========================
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
" ================ Commenting ========================
autocmd FileType c,cpp,java,javascript,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" Console log from insert mode; Puts focus inside parentheses
imap cll console.log("");<Esc>==f"a
" Console log from visual mode on next line, puts visual selection inside parentheses
vmap cll yocll<Esc>p
" Console log from normal mode, inserted on next line with word your on inside parentheses
nmap cll yiwocll<Esc>p 
imap gll console.log(`value: ${value}`);<Esc>
vmap gll ogll<Esc>p
nmap gll ogll<Esc>p 


" start allow pasting in insert mode without set paste, works with tmux
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif
  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"
  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction
let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
" end allow pasting in insert mode 

" spell checking for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell
" use kspell word completion with ctrl-n in insert mode
set complete+=kspell

" load js require without a .js extension
set path=.,src
set suffixesadd=.js,.jsx

function! LoadMainNodeModule(fname)
    let nodeModules = "./node_modules/"
    let packageJsonPath = nodeModules . a:fname . "/package.json"

    if filereadable(packageJsonPath)
        return nodeModules . a:fname . "/" . json_decode(join(readfile(packageJsonPath))).main
    else
        return nodeModules . a:fname
    endif
endfunction

set includeexpr=LoadMainNodeModule(v:fname)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" allow to exit terminal mode with esc key
tnoremap <Esc> <C-\><C-n>
tnoremap <Esc><Esc> <C-\><c-n>

func! s:my_colors_setup() abort
  highlight CocFloating ctermbg=gray " For background color
  highlight CocErrorFloat ctermfg=black " For text color
endfunc

augroup colorscheme_coc_setup | au!
  au VimEnter * call s:my_colors_setup()
augroup END

let g:term_buf = 0
let g:term_win = 0

function! Term_toggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction


nnoremap <C-t> :call Term_toggle(15)<cr>
tnoremap <C-t> <C-\><C-n>:call Term_toggle(15)<cr>
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

imap <silent> <C-[> <Plug>(copilot-next)
imap <silent> <C-]> <Plug>(copilot-previous)
imap <silent> <C-\> <Plug>(copilot-dismiss)
nnoremap fr gd[{V%::s/<C-R>///gc<left><left><left>
