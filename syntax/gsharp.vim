if exists("b:current_syntax")
  finish
endif

" Keywords
syntax keyword gsharpKeyword   if then else for in do while main
syntax keyword gsharpBoolean   true false
syntax keyword gsharpBuiltin   println print head tail last len empty nth reverse concat str
syntax keyword gsharpStorage   let

" Let binding: highlight the name after 'let'
syntax match gsharpLetName "\(\blet\s\+\)\@<=[a-zA-Z_][a-zA-Z0-9_]*"

" Function definitions (inline): name params =>
syntax match gsharpFunction "^\s*\zs[a-zA-Z_][a-zA-Z0-9_]*\ze\s\+\([a-zA-Z_][a-zA-Z0-9_]*\s*\)*=>"

" Function definitions (block): name params at end of line (no =>)
syntax match gsharpFunction "^\s*\zs[a-zA-Z_][a-zA-Z0-9_]*\ze\(\s\+[a-zA-Z_][a-zA-Z0-9_]*\)\+\s*$"

" Arrow operator
syntax match gsharpArrow "=>"

" Operators
syntax match gsharpOperator "==\|!=\|<=\|>=\|&&\|||\|[+\-*/=<>!%]"

" Numbers
syntax match gsharpNumber "\b\d\+\(\.\d\+\)\?[fdmFDM]\?\b"

" Strings with escape sequences
syntax region gsharpString start=/"/ end=/"/ contains=gsharpEscape oneline
syntax match  gsharpEscape "\\." contained

" Comments
syntax match gsharpComment "//.*$"

" Highlight links
highlight default link gsharpKeyword   Keyword
highlight default link gsharpBoolean   Boolean
highlight default link gsharpBuiltin   Function
highlight default link gsharpStorage   StorageClass
highlight default link gsharpLetName   Identifier
highlight default link gsharpFunction  Function
highlight default link gsharpArrow     Operator
highlight default link gsharpOperator  Operator
highlight default link gsharpNumber    Number
highlight default link gsharpString    String
highlight default link gsharpEscape    SpecialChar
highlight default link gsharpComment   Comment

let b:current_syntax = "gsharp"
