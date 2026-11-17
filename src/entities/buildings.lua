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
					
					location = locations:create(6,6)
					
					-- warp
					add(locations[#locations].entities,
						warps:create(3, 4, 22, location, locations[1], x+1, y+1)
					)
					
					-- potted plant
					add(locations[#locations].entities,
						{collision = true, x = 1, y = 3, s = 96}
					)
					
					-- bookshelf
					add(locations[#locations].entities,
						{collision = true, x = 2, y = 0, s = 97}
					)
					
					-- bed
					add(locations[#locations].entities,
						{collision = true, x = 4, y = 2, s = 112}
					)
					
					-- background
					locations[#locations].draw = function(self)
						
						for i = 0, self.width*self.height - 1 do
							
							spr(101 - (i%2), (i % self.width)*8, flr(i/self.width)*8)
							
						end
						
						rect(0, 0, self.width*8-1, self.height*8-1, 2)
						rect(1, 1, self.width*8-2, self.height*8-2, 14)
						
					end
					
					destination = location
					destination_x = 3
					destination_y = 3
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

