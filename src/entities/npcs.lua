-- Non-player character definitions and behavior.


npcs = {}

function npcs:init()
	
	local indices = shuffle(128*64)
	
	for i = 1, 100 do
		
		local x = indices[i] % 128
		local y = flr(indices[i] / 128)
		
		add(npcs, {
			
			x = x,
			y = y,
			
			s = 32+flr(rnd(4)),
			
			♥ = 0,
			
			invoke = function(self)
				
				local msg = rnd({"hey", "yo", "sup"})
				
				messages:add(msg, self.x, self.y)
				
				--[[ add_menu({hi, bye}) ]]
				
				menus:quit()
				
			end,
			
			invoke_action = "talk"
			
		})
		
	end
	
end


function npcs:draw()
	
	local il = max(0, flr(cam.x/8)-1)
	local ir = min(127, flr(cam.x/8)+16)
	
	local jl = max(0, flr(cam.y/8)-1)
	local jr = min(63, flr(cam.y/8)+16)
	
	for s in all(npcs) do
		
		if s.x >= il and s.x <= ir and
		s.y >= jl and s.y <= jr
		then
			palt(0, false)
			spr(s.s, s.x*8, s.y*8)
			palt(0, true)
		end
		
	end
	
	
end