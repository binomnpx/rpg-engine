-- Bags on ground that hold dropped items

burlaps = {}

function burlaps:add(_x, _y, item)
	
	add(locations.current.entities, {
		
		x = _x,
		y = _y,
		
		s = 59,
		inventory = {item},
		
		interactions = {search, leave},
		
		on_interact = function(self, event)
			
			if event == "item taken" then
				
				del(burlaps, self)
				
			end
			
			if event == "player searched" then
				
				self.s = 60
				
			end
			
			if event == "player left" then
				
				if #self.inventory > 0 then
					
					self.s = 59
					
				end
				
			end
			
		end
		
	})
	
end

