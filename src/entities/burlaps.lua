-- Bags on ground that hold dropped items

burlaps = {}

function burlaps:add(_x, _y, item)
	
	add(burlaps, {
		
		x = _x,
		y = _y,
		
		s = 59,
		inventory = {item},
		
		invoke = function(self)
			
			menus:add(self.inventory, "burlap")
			
		end,
		
		invoke_action = "open"
		
	})
	
end


function burlaps:update()
	
	for b in all(burlaps) do
		
		if #b.inventory == 0 then
			
			del(burlaps, b)
			
		end
		
	end
	
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

