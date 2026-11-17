-- Locations

locations = {}

function locations:create(width, height)
	
	local location = {
		
		width = width,
		height = height,
		
		draw = map,
		
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
	
end

