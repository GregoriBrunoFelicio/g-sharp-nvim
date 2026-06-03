if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GsharpGetIndent(v:lnum)
setlocal indentkeys+=0=else

function! GsharpGetIndent(lnum)
  let prevlnum = prevnonblank(a:lnum - 1)
  if prevlnum == 0
    return 0
  endif

  let prevline = getline(prevlnum)
  let curline  = getline(a:lnum)
  let previndent = indent(prevlnum)

  " Increase indent after a line ending with 'then' or 'do'
  if prevline =~# '\v\b(then|do)\s*$'
    return previndent + shiftwidth()
  endif

  " Decrease indent on a line that starts with 'else'
  if curline =~# '^\s*\belse\b'
    return previndent - shiftwidth()
  endif

  return previndent
endfunction
