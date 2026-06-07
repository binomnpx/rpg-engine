-- Warps

warps = {}

function warps:init()
	
	add(warps, {
		
		home = {},
		
		x = 4,
		y = 12,
		
		destination = locations[1],
		
		destination_x = 4,
		destination_y = 6,
		
		interactions = {warp, leave},
		
		draw = function(self)
			
			spr(22, self.x*8, self.y*8)
			
		end
		
	})
	
end

function warps:draw()
	
	for w in all(warps) do
		
		w:draw()
		
	end
	
end
