-- Player simulation and behavior. Does not read raw input directly.

player = {}

function player:init()

	player.x = 8
	player.y = 8
	player.s = player_sprite_frontleft
	--[[ player.facefront = true ]]
	
	-- direction player is facing
	player.xos = -1
	player.yos = 0
	
	player.flip_x = false
	
	player.inventory = {trident}
	
	player.hand = nil
	
end


function player:draw()
		
		-- keep player visible in
		-- current screen before
		-- transitioning
		
		local xos = 0
		local yos = 0
		
		if cam.player_shift and
			cam.timer[1] > 2
		then
			-- camera is moving
			
			for q in all(cam.q) do
				
				if q == 0 then
					
					xos += 8
					
				elseif q == 1 then
					
					xos -= 8
					
				elseif q == 2 then
					
					yos += 8
					
				elseif q == 3 then
					
					yos -= 8
					
				end
				
			end
			
		end
		
		
		local px = player.x * 8 + xos
		local py = player.y * 8 + yos
		
		-- draw player
		
		spr(player.s, px, py, 1, 1, player.flip_x)
		
		
		-- draw hand
		
		if player.hand then
			
			player.hand.draw(px, py)
			
		end
		
end

