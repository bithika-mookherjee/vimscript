""" The map for an allergy to a bit flag
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

	
