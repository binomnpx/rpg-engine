-- Rocks, coral, etc.

-- scenery

scenery = {}

function scenery:init()
	
	local indices = shuffle(128*64)
	
	for i = 1,400 do
		
		local s = 48+flr(rnd(8))
		
		for _ = 1, ceil(rnd(4)) do
			
			local x = mid(0, indices[i] % 128 + flr(rnd(5)), 127)
			local y = mid(0, flr(indices[i] / 128) + flr(rnd(5)), 63)
			
			add(locations.current.entities, {
				
			collision = true,
			
				x = x,
				y = y,
				
				s = s,
				
				♥ = 1,
				
				upd = function(self)
					
					if self.♥ <= 0 then
						
						mset(self.x, self.y, 3)
						
					end
					
				end,
				
				drw = function(self)
					
					spr(self.s, self.x*8, self.y*8)
					
				end
				
			})
			
		end
		
	end
	
end

