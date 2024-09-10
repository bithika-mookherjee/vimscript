let s:mirrors = { "{" : "}",
			\	  "(" : ")",
			\ 	  "[" : "]"
			\ 	}


function! IsLeftBrace(c)
	return (a:c == "{" || a:c == "[" || a:c == "(")
endfunction

function! IsRightBrace(c)
	return (a:c == "}" || a:c == "]" || a:c == ")")
endfunction

function! GetExpected(stack) 
	return a:stack->empty() ? "0" : s:mirrors[a:stack[-1]]
endfunction

function! Push(stack, c)
	return a:stack->add(a:c)
endfunction

function! Pop(stack)
	return a:stack[:-2]
endfunction

function! IsPaired(str) 
	let l:stack = []
	let l:expected = "0" 

	if a:str->empty()
		return 1 
	endif

	for c in a:str
		if IsLeftBrace(c)
			let l:stack = Push(l:stack, c)
			let l:expected = GetExpected(l:stack)
		elseif IsRightBrace(c) 
			if c == l:expected
				let l:stack = Pop(l:stack)
				let l:expected = GetExpected(l:stack)
			else
				return 0
			endif
		endif
	endfor

	return (l:stack->empty() ? 1 : 0) 
endfunction
			


