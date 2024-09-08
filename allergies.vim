
" Given a person's allergy score, determine whether or not they're allergic to
" a given item, and their full list of allergies.
"
"   eggs          1
"   peanuts       2
"   shellfish     4
"   strawberries  8
"   tomatoes      16
"   chocolate     32
"   pollen        64
"   cats          128
"
" Examples:
"
"   :echo AllergicTo(5, 'shellfish')
"   1
"
"   :echo List(5)
"   ['eggs', 'shellfish']
"
let s:map = { 'cats' 		: 128,
	\		  'pollen' 		: 64,
	\		  'chocolate' 	: 32,
	\  		  'tomatoes' 	: 16, 
	\		  'strawberries': 8,
	\		  'shellfish' 	: 4, 
	\		  'peanuts' 	: 2,   
	\		  'eggs' 		: 1 }

""" Returns true if the score covers the given allergy. 
""" False otherwise.
function! AllergicTo(score, allergy) abort
	return and(a:score, s:map[a:allergy]) > 0 
endfunction


""" Returns a sorted list of all allergies covered by score
function! List(score) abort
	if a:score == 0 
		return [] 
	endif

	return s:map->items()
			\ ->filter({idx, val -> AllergicTo(a:score, val[0])})	
			\ ->sort({a, b -> a[1] - b[1]})
			\ ->reduce({acc, val -> acc->add(val[0])}, [])	
endfunction

	
