""" Common

  set nocompatible
  set encoding=utf-8

  set number
  "set relativenumber
  "set rnu!

  set mouse=a

  set autoindent
  set expandtab
  set smarttab
  set tabstop=2
  set shiftwidth=2

  filetype plugin indent on

""" Plugins
  " :PlugInstall
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
  call plug#begin('~/.vim/bundle')

    """ Themes
    Plug 'tribela/vim-transparent'

    Plug 'Lokaltog/vim-monotone'
    Plug 'lifepillar/vim-solarized8'
    Plug 'alexanderheldt/monokrom.vim'

    """ Statusbar
    Plug 'itchyny/lightline.vim'

    """ fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

  call plug#end()

""" Appearance

  colorscheme monokrom

  set cursorline
  set ttimeoutlen=10

  let &t_SI.="\e[5 q"
  let &t_SR.="\e[3 q"
  let &t_EI.="\e[2 q"

  highlight EndOfBuffer ctermfg=16

""" Lightline

  let g:lightline = {
    \ 'colorscheme': 'jellybeans',
    \ 'mode_map': {
      \ 'n' : '',
      \ 'i' : 'I',
      \ 'R' : 'R',
      \ 'v' : 'V',
      \ 'V' : 'L',
      \ "\<C-v>": 'B',
      \ 'c' : 'C',
      \ 's' : 'S',
      \ 'S' : 'SL',
      \ "\<C-s>": 'SB',
      \ 't': 'T',
    \ },
  \ }

  set laststatus=2
  set noshowmode

""" fzf

  let $FZF_DEFAULT_OPTS='--preview-window sharp'

  nnoremap <C-o> :Buffers<cr>
  nnoremap <C-p> :Files<cr>
  nnoremap <C-e> :Explore<cr>

  nnoremap <C-f> :Ag<cr>
  nnoremap <C-g> :Ag <c-r><c-w><cr>

""" Copy'n'paste

  nnoremap <silent><C-c> :call system('xclip -i -selection clipboard', @@)<cr>
