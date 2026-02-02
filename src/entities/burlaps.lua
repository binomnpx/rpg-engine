-- Bags on ground that hold dropped items

burlaps = {}

function burlaps:add(_x, _y, item)
	
	add(burlaps, {
		
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


function burlaps:draw()
	
	local il = max(0, flr(cam.x/8)-1)
	local ir = min(127, flr(cam.x/8)+16)
	
	local jl = max(0, flr(cam.y/8)-1)
	local jr = min(63, flr(cam.y/8)+16)
	
	for s in all(burlaps) do
		
		if s.x >= il and s.x <= ir and
		s.y >= jl and s.y <= jr
		then
			palt(0, false)
			spr(s.s, s.x*8, s.y*8)
			palt(0, true)
		end
		
	end
	
	
end

