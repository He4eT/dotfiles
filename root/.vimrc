""" Common

  set nocompatible
  set encoding=utf-8

  set number

  set mouse=a

  set nowrap
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
    Plug 'pgdouyon/vim-yin-yang'
    Plug 'widatama/vim-phoenix'
    """ Plug 'Lokaltog/vim-monotone'
    """ Plug 'alexanderheldt/monokrom.vim'

    """ Statusline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    """ Navigation
    Plug 'justinmk/vim-sneak'
  call plug#end()

  let g:sneak#label = 1

""" Appearance

  """ colorscheme monotone
  autocmd ColorScheme * hi Sneak guifg=black guibg=white ctermfg=black ctermbg=white
  autocmd ColorScheme * hi SneakScope guifg=black guibg=white ctermfg=black ctermbg=white
  autocmd ColorScheme * hi SneakLabel guifg=black guibg=white ctermfg=black ctermbg=white
  colorscheme yin

  set cursorline
  set ttimeoutlen=10

  let &t_SI.="\e[5 q"
  let &t_SR.="\e[3 q"
  let &t_EI.="\e[2 q"

  highlight EndOfBuffer ctermfg=16

""" Statusline

  let g:airline_theme='minimalist'
  let g:airline_section_x = airline#section#create(['%l:%v'])
  let g:airline_section_y = airline#section#create([''])
  let g:airline_section_z = airline#section#create(['%p%%'])

  set laststatus=2
  set noshowmode

""" Copy'n'paste

  nnoremap <silent><C-c> :call system('xclip -i -selection clipboard', @@)<cr>
