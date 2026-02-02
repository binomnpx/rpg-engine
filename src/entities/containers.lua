-- Chests, etc.

-- containers

containers = {}

function containers:init()
	
	local indices = shuffle(128*64)
	
	for i = 1,100 do
		
		local x = indices[i] % 128
		local y = flr(indices[i] / 128)
		
		add(containers, {
			
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



function containers:draw()
	
	local il = max(0, flr(cam.x/8)-1)
	local ir = min(127, flr(cam.x/8)+16)
	
	local jl = max(0, flr(cam.y/8)-1)
	local jr = min(63, flr(cam.y/8)+16)
	
	for s in all(containers) do
		
		if s.x >= il and s.x <= ir and
		s.y >= jl and s.y <= jr
		then
			palt(0, false)
			spr(s.s, s.x*8, s.y*8)
			palt(0, true)
		end
		
	end
	
	
end

