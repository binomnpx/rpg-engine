-- Movement and interaction blocking rules for the world.

collision = {}

function collision:init()
	
	subscribe(player, collision)
	
end

function collision:on_notify(subject, event, data)
	
	if subject == player then
		
		if event == "moved" then
			
			for e in all(locations.current.entities) do
				
				if e.collision and e.x == player.x and e.y == player.y and not e.open then
					
					player.x -= data.dx
					player.y -= data.dy
					
					return
					
				end
				
			end
			
			if player.x < 0 or player.x > 127 or player.y < 0 or player.y > 63 then
				
				player.x = mid(0, player.x, 127)
				player.y = mid(0, player.y, 63)
				
			else
				
				notify(collision, "player moved", data)
				
			end
			
		end
		
	end
	
end

