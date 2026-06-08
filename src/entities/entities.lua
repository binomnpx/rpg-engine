-- Entities

entities = {}

-- locations:load(location) populates this list
-- collision and interaction loop through it

function entities:draw()
	
	local il = max(0, flr(cam.x/8)-1)
	local ir = min(127, flr(cam.x/8)+16)
	
	local jl = max(0, flr(cam.y/8)-1)
	local jr = min(63, flr(cam.y/8)+16)
	
	for e in all(locations.current.entities) do
		
		if e.x >= il and e.x <= ir and
		e.y >= jl and e.y <= jr
		then
			palt(0, false)
			spr(e.s, e.x*8, e.y*8)
			palt(0, true)
		end
		
	end
	
end
