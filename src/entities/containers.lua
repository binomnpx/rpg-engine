-- Chests, etc.

-- containers

containers = {}

function containers:init()
	
	local indices = shuffle(128*64)
	
	for i = 1,100 do
		
		local x = indices[i] % 128
		local y = flr(indices[i] / 128)
		
		add(locations.current.entities, {
			
			collision = true,
			
			x = x,
			y = y,
			
			s = 56,
			
			inventory = {rnd({apple, orange, banana})},
			
			interactions = {search, leave},
			
			on_interact = function(self, event)
				
				if event == "player searched" then
					
					self.s = 57
					
					if #self.inventory == 0 then
						
						messages:add("empty", self.x, self.y)
						
						menus:quit()
						
					end
					
				end
				
				if event == "player left" then
					
					if #self.inventory > 0 then
						
						self.s = 56
						
					end
					
				end
				
				if event == "item taken" and
					#self.inventory == 0
				then
					
					self.interactions = {}
					
				end
				
			end
			
		})
		
	end
	
end

