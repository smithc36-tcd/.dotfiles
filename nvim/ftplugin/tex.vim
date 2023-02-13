let g:vimtex_view_method = 'zathura' 
" Close viewers when VimTeX buffers are closed (see :help vimtex-events)
function! CloseViewers()
  if executable('xdotool')
        \ && exists('b:vimtex.viewer.xwin_id')
        \ && b:vimtex.viewer.xwin_id > 0
    call system('xdotool windowclose '. b:vimtex.viewer.xwin_id)
  endif
endfunction

augroup vimtex_event_close
  au!
  au User VimtexEventQuit call CloseViewers()
augroup END

