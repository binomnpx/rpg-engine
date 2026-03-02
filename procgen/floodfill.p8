pico-8 cartridge // http://www.pico-8.com
version 43
__lua__


function _init()
	
	cls()
	
	tiles = {}
	
	for i = 0, 127 do
		
		tiles[i] = {}
		
		for j = 0, 127 do
			
			local tile = {}
			
			tile.x = i
			tile.y = j
			
			tile.c = 7
			
			tiles[i][j] = tile
			
		end
		
	end
	
	collapsed = {}
	
	add(collapsed, tiles[flr(rnd(128))][flr(rnd(128))])
	
	collapsed[1].c = 1 << rnd(3)
	
	set(collapsed[1])
	
	modified = {}
	
end


function _update60()
	
	for _ = 1,150 do
	
	if #collapsed > 0 do
		
		local tile = collapsed[#collapsed]
		
		deli(collapsed, #collapsed)
		
		for dir in all(dirs) do
			
			local x = mid(0, tile.x + dir.x, 127)
			local y = mid(0, tile.y + dir.y, 127)
			
			local adjacent = tiles[x][y]
			
			if size(adjacent) > 1 then
				
				adjacent.c = band(bnot(tile.c), adjacent.c)
				
				if size(adjacent) == 1 then
					
					set(adjacent)
					
					del(modified, adjacent)
					
					modified[adjacent] = nil
					
					add(collapsed, adjacent)
					
				else
					
					if not modified[adjacent] then
						
						add(modified, adjacent)
						
						modified[adjacent] = true
						
					end
					
				end
				
			end
			
		end
		
	elseif #modified > 0 then
		
		-- collapse
		
		local tile = rnd(modified)
		
		local bits = {}
		
		for i = 0, 2 do
			if tile.c & (1 << i) != 0 then
				add(bits, i)
			end
		end
		
		tile.c = 1 << rnd(bits)
		
		set(tile)
		
		del(modified, tile)
		
		modified[tile] = nil
			
		add(collapsed, tile)
		
	end
	
	end
	
end


function _draw()
	
	
	
end
-->8
function size(tile)
	
	local a = 0
	local n = tile.c
	
	while n > 0 do
		n = n & (n-1)
		a += 1
	end
	
	return a
	
end

function set(tile)
	
	if tile.c == 1 then
		pset(tile.x, tile.y, 1)
	elseif tile.c == 2 then
		pset(tile.x, tile.y, 2)
	elseif tile.c == 4 then
		pset(tile.x, tile.y, 3)
	end
	
end

dirs = {
	
	{x = 0, y = -1},
	{x = 1, y = 0},
	{x = 0, y = 1},
	{x = -1, y = 0}
	
}

function bitrnd(tile)
	
	local n = tile.c
	
	local bits = {}
	
	for i = 0, 2 do
		if n & (1 << i) != 0 then
			add(bits, i)
		end
	end
	
	return rnd(bits)
	
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
