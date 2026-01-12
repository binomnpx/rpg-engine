-- Tile-based world representation and helpers for querying and iterating tiles.

grid = {}

function grid:init()
	
	for i = 0, 127 do
		
		grid[i] = {}
		
		for j = 0, 63 do
			
			grid[i][j] = nil
			
		end
		
	end
	
end

function grid:draw()
	-- grid objects
	
	local il = max(0, flr(cam.x/8)-1)
	local ir = min(127, flr(cam.x/8)+16)
	
	local jl = max(0, flr(cam.y/8)-1)
	local jr = min(63, flr(cam.y/8)+16)
	
	for i = il, ir do
		
		for j = jl, jr do
			
			local obj = grid[i][j]
			
			if obj then
				
				palt(0, false)
				spr(obj.s, obj.x*8, obj.y*8)
				palt(0, true)
				
			end
			
		end
		
	end
end
