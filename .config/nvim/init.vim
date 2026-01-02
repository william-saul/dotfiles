set nocompatible
filetype plugin on
syntax on

set number
set relativenumber

autocmd FileType vimwiki nnoremap <buffer> <leader>x :call ToggleTodo()<CR>

function! ToggleTodo()
  let l:line = getline('.')
  if l:line =~ '\[ \]'
    call setline('.', substitute(l:line, '\[ \]', '[x]', ''))
  elseif l:line =~ '\[x\]'
    call setline('.', substitute(l:line, '\[x\]', '[ ]', ''))
  endif
endfunction

nnoremap <leader>t :tabnew<CR>
nnoremap <leader>ct :tabclose<CR>
nnoremap <leader>m :Ex<CR>
nnoremap <leader>h :noh<CR>

" groff
nnoremap <leader>gg :w<CR>:silent !groff -ms -Tpdf % > %:r.pdf<CR>

" Lilypond
nnoremap <leader>ff :w<CR>:silent !lilypond --pdf %:r<CR>

" spelling
nnoremap <leader>ss :set spell!<CR>
nnoremap <leader>sf ]s
nnoremap <leader>sd [s
nnoremap <C-Space> z=
command! -nargs=? AddWord execute 'spellgood ' . (empty(<q-args>) ? expand('<cword>') : <q-args>)
command! -nargs=? RemoveWord execute 'spellwrong ' . (empty(<q-args>) ? expand('<cword>') : <q-args>)

" 4 spaces for tabs in HTML/CSS/JS:
autocmd FileType html,css,javascript setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
