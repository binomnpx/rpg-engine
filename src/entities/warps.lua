-- Warps

warps = {}

function warps:init()
	
	add(locations.current.entities, {
	
		collision = true,
		
		x = 4,
		y = 12,
		
		s = 22,
		
		destination = locations[1],
		
		destination_x = 4,
		destination_y = 6,
		
		interactions = {warp, leave}
		
	})
	
end

