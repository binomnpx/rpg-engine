-- Warps

warps = {}

function warps:create(x, y, s, location, destination, destination_x, destination_y)
	
	return {
	
		collision = true,
		
		x = x,
		y = y,
		
		s = s,
		
		destination = destination,
		
		destination_x = destination_x,
		destination_y = destination_y,
		
		interactions = {warp, leave}
		
	}
	
end


function warps:init()
		
end

