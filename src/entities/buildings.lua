-- buildings

buildings = {}

function buildings:init()
	
	local indices = shuffle(128*64)
	
	for i = 1,40 do
		
		local x = mid(0, indices[i] % 128 + flr(rnd(5)), 126)
		local y = mid(0, flr(indices[i] / 128) + flr(rnd(5)), 62)
		
	
		for u = 0, 1 do
			
			for v = 0, 1 do
				
				local destination
				local destination_x
				local destination_y
				local interactions
				
				if u+v == 2 then
					
					location = locations:create(8,8)
					
					add(locations[#locations].entities,
						warps:create(4, 7, 22, location, locations[1], x+1, y+1)
					)
					
					destination = location
					destination_x = 4
					destination_y = 6
					interactions = {warp, leave}
					
				end
				
				add(locations.current.entities, {
					
					collision = true,
					
					x = x+u,
					y = y+v,
					
					s = 64 + u + v*16,
					
					destination = destination,
					destination_x = destination_x,
					destination_y = destination_y,
					interactions = interactions
					
				})
				
			end
		end
		
	end
	
end

