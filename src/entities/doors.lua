-- Doors

doors = {}


function doors:init()
	
	for i = 1,1 do
		
		add(locations.current.entities, {
			
			collision = true,
			
			x = 2,
			y = 2,
			
			s = 61,
			
			interactions = {open, leave},
			
			on_interact = function(self, event)
				
				if event == "player opened" then
					
					self.s = 62
					
					self.interactions = {close, leave}
					
					self.collision = false
					
				end
				
				if event == "player closed" then
					
					self.s = 61
					
					self.interactions = {open, leave}
					
					self.collision = true
					
				end
				
			end
			
		})
		
	end
	
end

