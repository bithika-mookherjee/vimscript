" Returns true if for every left parenthesis (or square brace, or curly 
" brace) in the given string, there is a right one to match.  

" NB if a right brace is encountered, then to be a valid pair, it 
" has to match the most recently encountered left bracket.
" 
" For each char in the string do:
" 	if char is a right brace then
" 		if it does not match top of stack 
" 			return false	
" 		else
" 			pop the stack
" 		end
"   else if it is a left brace, 
" 		push to the stack
" 	else
" 		do nothing, just continue
" 	end
"
let s:mirror = { '{' : '}',
		\		 '(' : ')',
		\ 		 '[' : ']'
		\ 	   }
function! IsLeftBrace(c)
	return s:mirror->has_key(a:c) 
endfunction

function! IsRightBrace(c)
	return get(s:mirror, a:c, 0) 
endfunction

function! AreMatchingBrackets(left, right)
	return s:mirror[a:left] = a:right 
endfunction

function! Process(c, braces) abort
	let l:result = a:braces 

	" is this a right brace?
	" and does it match the top of the stack? 
	if IsRightBrace(a:c) && AreMatchingBrackets(l:result[-1], a:c)
		" pop the last item from the list 
		let l:result = l:result[:-2]
	else
		" is this a left brace?
		if IsLeftBrace(a:c) 
			" push the last item to the list
			let l:result = add(l:result, a:c)
		endif
	endif
	return l:result 
endfunction

function! IsPaired(str) abort
	let l:braces = []
  	for c in a:str
		let l:braces = Process(c, l:braces) 
	endfor
	echo l:braces
endfunction

" vader gave me:
" Success/Total: 12/20
" Success/Total: 12/20 (assertions: 12/20)
" Elapsed time: 0.27 sec.


