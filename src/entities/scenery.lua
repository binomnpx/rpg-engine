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
			
			add(scenery, {
				
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


function scenery:draw()
	
	local il = max(0, flr(cam.x/8)-1)
	local ir = min(127, flr(cam.x/8)+16)
	
	local jl = max(0, flr(cam.y/8)-1)
	local jr = min(63, flr(cam.y/8)+16)
	
	for s in all(scenery) do
		
		if s.x >= il and s.x <= ir and
		s.y >= jl and s.y <= jr
		then
			palt(0, false)
			spr(s.s, s.x*8, s.y*8)
			palt(0, true)
		end
		
	end
	
	
end

