-- General math helper functions.

function shuffle(n)
	 
		local indices = {}
		
		for i = 0, n-1 do
			 
			 add(indices, i)
			 
		end
		
		for i = #indices, 1, -1 do
			 
			 local j = flr(rnd(i))+1
			 
			 indices[i], indices[j] = indices[j], indices[i]
			 
		end
		
		return indices
	 
end