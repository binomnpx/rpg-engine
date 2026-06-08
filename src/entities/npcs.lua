-- Non-player character definitions and behavior.


npcs = {}

function npcs:init()
	
	local indices = shuffle(128*64)
	
	for i = 1, 100 do
		
		local x = indices[i] % 128
		local y = flr(indices[i] / 128)
		
		add(locations.current.entities, {
			
			collision = true,
			combat = true,
			
			x = x,
			y = y,
			
			s = 32+flr(rnd(4)),
			
			hp = 0,
			
			interactions = {talk, leave},
			
			on_interact = function(self, event)
				
				if event == "player talked" then
					
					local msg = rnd({"hey", "yo", "sup"})
					
					messages:add(msg, self.x, self.y)
					
					--[[ add_menu({hi, bye}) ]]
					
					menus:quit()
					
				end
				
			end
			
		})
		
	end
	
end

