-- Locations

locations = {}

function locations:create(width, height)
	
	local location = {
		
		width = width,
		height = height,
		
		tiles = {},
		
		entities = {}
		
	}
	
	add(locations, location)
	
	return location
	
end


function locations:init()
	
	for _ = 1,2 do
		
		locations:create(8, 8)
		
	end
	
	locations.current = locations[1]
	
end


function locations:load(location)
	
	locations.current = location
	
	for i = 0, location.width-1 do
		
		for j = 0, location.height-1 do
			
			mset(i, j, flr(rnd(2)) + 3)
			
		end
		
	end
	
end

