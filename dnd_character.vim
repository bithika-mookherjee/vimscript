"
" Calculates the constitution modifier using the passed ability score
"
function! Modifier(score) abort
	return float2nr(floor((a:score - 10.0) / 2.0))
endfunction


"
" Calculates an ability score randomly by summing the top three of four randomly generated numbers
"
function! Ability() abort
	" create an array of 4 randome values
	let l:rolls = range(4)->map({-> 1 + rand() % 6})
	
	" sort and extract the top 3
	let l:top3 = l:rolls->sort({a, b -> b - a})[0:2]

	" sum the top 3
	return l:top3->reduce({sum, val -> sum + val}, 0)

endfunction


"
" Returns a dictionary representing a D&D character with randomly generated ability scores
"
function! Character() abort
	let l:char_dict = {'strength': Ability(), 'dexterity': Ability(), 'constitution': Ability(), 'intelligence': Ability(), 'wisdom': Ability(), 'charisma': Ability()}

	let l:char_dict.hitpoints = 10 + Modifier(l:char_dict['constitution'])

	return l:char_dict
endfunction

