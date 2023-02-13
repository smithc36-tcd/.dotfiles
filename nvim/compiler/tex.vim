""Local Compiler related keymaps
""nmap <leader>tl <Plug>TexToggleLatexmk
""nnoremap <script> <Plug>TexToggleLatexmk <SID>TexToggleLatex
""nnoremap <SID>TexToggleLatexmk :call <SID>TexToggleLatexmk()<CR>


""pdflatex -file-line-error -halt-on-error -interaction=nonstopmode -output-dir=%:h -synctex=1 %
""latexmk -pdf -output-directory=%:h %

"let s:pdflatex = 'pdflatex -file-line-error -halt-on-error -interaction=nonstopmode -output-dir=%:h -synctex=1 %'
"let s:latexmk = 'latexmk -pdf -output-directory=%:h %'

""Varible to hold the  possible values for 
""the compliler state
"let b:tex_use_latexmk = 0


""Toggles between latexmk and pdflatex
"function! s:TexToggleLatexmk() abort
    "if b:tex_use_latexmk
        "let b:tex_use_latexmk = 0
    "else
        "let b:tex_use_latexmk = 1
    "endif
    "call s:TexSetMakePrg()
"endfunction

"function! s:TexSetMakePrg() abort
    "if b:tex_use_latexmk
        "let &l:makeprg = expand(s:latexmk)
    "else
        "let &l:makeprg = expand(s:pdflatex)
    "endif
"endfunction

"call s:TexSetMakePrg()
"""Local Compiler related keymaps
"nmap <localleader>tl <Plug>TexToggleLatexmk
"nnoremap <script> <Plug>TexToggleLatexmk <SID>TexToggleLatex
"nnoremap <SID>TexToggleLatexmk :call <SID>TexToggleLatexmk()<CR>



" Settings for compiling LaTeX documents
if exists("current_compiler")
	finish
endif
let current_compiler = "tex"

" Set make programs for both pdflatex and latexmk
let s:pdflatex = 'pdflatex -file-line-error -interaction=nonstopmode ' .
      \ '-halt-on-error -synctex=1 -output-directory=%:h %'
let s:latexmk = 'latexmk -pdf -output-directory=%:h %'

" Create variables to store pdflatex/latexmk and shell-escape state
let b:tex_use_latexmk = 0
let b:tex_use_shell_escape = 0


" Search for the minted package in the document preamble.
" Enable b:tex_use_shell_escape if the minted package
" is detected in the tex file's preamble.
" --------------------------------------------- "
silent execute '!sed "/\\begin{document}/q" ' . expand('%') . ' | grep "minted" > /dev/null'
if v:shell_error  " 'minted' not found in preamble
  let b:tex_use_shell_escape = 0  " disable shell escape
else  " 'minted' found in preamble
  let b:tex_use_shell_escape = 1  " enable shell escape
endif


" User-defined functions
" ------------------------------------------- "
" Toggles between latexmk and pdflatex
function! s:TexToggleLatexmk() abort
  if b:tex_use_latexmk    " turn off latexmk
    let b:tex_use_latexmk = 0
  else  " turn on latexmk
    let b:tex_use_latexmk = 1
  endif
  call s:TexSetMakePrg()  " update Vim's `makeprg` option
endfunction

" Toggles shell escape compilation on and off
function! s:TexToggleShellEscape() abort
  if b:tex_use_shell_escape  " turn off shell escape
    let b:tex_use_shell_escape = 0
  else  " turn on shell escape
    let b:tex_use_shell_escape = 1
  endif
  call s:TexSetMakePrg()     " update Vim's `makeprg` option
endfunction

" Sets correct value of `makeprg` based on current values of
" both `b:tex_use_latexmk` and `b:tex_use_shell_escape`
function! s:TexSetMakePrg() abort
  if b:tex_use_latexmk
    let &l:makeprg = expand(s:latexmk)
  else
    let &l:makeprg = expand(s:pdflatex)
  endif
  if b:tex_use_shell_escape
    let &l:makeprg = &makeprg . ' -shell-escape'
  endif
endfunction


" Key mappings for functions
" ---------------------------------------------
" TexToggleShellEscape
nmap <leader>te <Plug>TexToggleShellEscape
nnoremap <script> <Plug>TexToggleShellEscape <SID>TexToggleShellEscape
nnoremap <SID>TexToggleShellEscape :call <SID>TexToggleShellEscape()<CR>

" TexToggleLatexmk
nmap <leader>tl <Plug>TexToggleLatexmk
nnoremap <script> <Plug>TexToggleLatexmk <SID>TexToggleLatexmk
nnoremap <SID>TexToggleLatexmk :call <SID>TexToggleLatexmk()<CR>


" Set Vim's `makeprg` and `errorformat` options
" ---------------------------------------------
call s:TexSetMakePrg()  " set value of Vim's `makeprg` option

" Note: The errorformat used below assumes the tex source file is 
" compiled with pdflatex's -file-line-error option enabled.
setlocal errorformat=%-P**%f
setlocal errorformat+=%-P**\"%f\"

" Match errors
setlocal errorformat+=%E!\ LaTeX\ %trror:\ %m
setlocal errorformat+=%E%f:%l:\ %m
setlocal errorformat+=%E!\ %m

" More info for undefined control sequences
setlocal errorformat+=%Z<argument>\ %m

" More info for some errors
setlocal errorformat+=%Cl.%l\ %m

" Ignore unmatched lines
setlocal errorformat+=%-G%.%#

