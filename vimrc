set nocompatible

let $VIMRUNTIME ="C:/Program Files (x86)/Vim/vim81"
set rtp+=$VIMRUNTIME
set rtp+=~/vimfiles/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'junegunn/vim-easy-align'

call vundle#end()

source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim

set encoding=utf-8
set list listchars=tab:→\ ,eol:↲,nbsp:␣,space:·,trail:•,extends:⟩,precedes:⟨
set list

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

:filetype indent plugin on
syntax on
hi Comment ctermfg=darkgreen
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set number
set showcmd
set cursorline
hi CursorLine cterm=NONE ctermbg=darkgray
set showmatch
set hlsearch
set autoindent
set smartindent 


nnoremap ; :
nnoremap w <s-w>
nnoremap b <s-b>
nnoremap <silent><nowait> [ {
nnoremap <silent><nowait> ] }

xmap aa :EasyAlign 2/\w\+/dal <CR><bar> gv <bar> :EasyAlign */\[/rm0 <CR><bar> gv <bar> :EasyAlign -/\w\+/dalrm0 <CR>

xmap acp :EasyAlign /)/rm0lm0 <CR>
xmap aop :EasyAlign /(/rm0 <CR>
xmap ac :EasyAlign /,/lm0 <CR>
xmap alw :EasyAlign -/\w\+/dalrm0 <CR>

function! MakeBracketMaps()
    nnoremap <silent><nowait><buffer> [ :<c-u>exe 'normal '.v:count.'{'<cr>
    nnoremap <silent><nowait><buffer> ] :<c-u>exe 'normal '.v:count.'}'<cr>
endfunction

augroup bracketmaps
    autocmd!
    autocmd FileType * call MakeBracketMaps()
augroup END

set backupdir=~/.vim_backups//
set directory=~/.vim_backups//
set undodir=~/.vim_backups//
