let $VIMRUNTIME ="C:/Program Files (x86)/Vim/vim81"
set rtp+=$VIMRUNTIME
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
behave mswin

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
set showmatch
set hlsearch
set autoindent
set smartindent 

nnoremap ; :
nnoremap <silent><nowait> [ {
nnoremap <silent><nowait> ] }

function! MakeBracketMaps()
    nnoremap <silent><nowait><buffer> [ :<c-u>exe 'normal '.v:count.'{'<cr>
    nnoremap <silent><nowait><buffer> ] :<c-u>exe 'normal '.v:count.'}'<cr>
endfunction

augroup bracketmaps
    autocmd!
    autocmd FileType * call MakeBracketMaps()
augroup END
