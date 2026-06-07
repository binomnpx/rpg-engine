-- Locations

locations = {}

function locations:init()
	
	add(locations, {
		
		width = 8,
		height = 8,
		
		tiles = {}
		
	})
	
end


function locations:load(location)
	
	for i = 0, location.width-1 do
		
		for j = 0, location.height-1 do
			
			mset(i, j, flr(rnd(2)) + 3)
			
		end
		
	end
	
end

