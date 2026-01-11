-- Control-mode and state routing. Determines which system handles input, update, and draw.

-- player

ctrl = {}

function ctrl:init()
	
	ctrl.state = "player"
	
	function move(actor, dx, dy)
		
		actor.x += dx
		actor.y += dy
		
		notify(actor, "moved", {dx = dx, dy = dy})
		
	end
	
end

function ctrl:update()
	
	if ctrl.state == "player" then
		
		if btnp(0) then
			-- left
			
			move(player, -1, 0)
			--[[ if player.facefront then ]]
			player.s = player_sprite_frontleft
			--[[ else ]]
			--[[ player.s = player_sprite_backleft ]]
			--[[ end ]]
			player.flip_x = false
			player.xos = -1
			player.yos = 0
			
		end
		
		if btnp(1) then
			-- right
			
			move(player, 1, 0)
			--[[ if player.facefront then ]]
			player.s = player_sprite_frontleft
			--[[ else ]]
			--[[ player.s = player_sprite_backleft ]]
			--[[ end ]]
			player.flip_x = true
			player.xos = 1
			player.yos = 0
			
		end
		
		if btnp(2) then
			-- up
			
			move(player, 0, -1)
			player.s = player_sprite_back
			player.facefront = false
			player.xos = 0
			player.yos = -1
			
		end
		
		if btnp(3) then
			-- down
			
			move(player, 0, 1)
			player.s = player_sprite_front
			player.facefront = true
			player.xos = 0
			player.yos = 1
			
		end
		
		if btnp(4) then
			-- O
			
			-- open inventory
			
			menus:add(player.inventory)
			
		elseif btnp(5) then
			-- X
			
			-- invoke object
			
			for e in all({npcs, containers}) do
				
				for i in all(e) do
					
					if i.x == player.x + player.xos and i.y == player.y + player.yos then
						
						i:invoke()
						
						return
						
					end
					
				end
				
			end
			
		end
		
	elseif ctrl.state == "menuing" then
		
		local menu = menus[#menus]
		
		if btnp(2) then
			menus[#menus].index = (menu.index-1) % #menu.items
		elseif btnp(3) then
			menus[#menus].index = (menu.index+1) % #menu.items
		elseif btnp(4) then
			menus[#menus] = nil
			
			if #menus == 0 then
				ctrl.state = menus.state
			end
			
		elseif btnp(5) then
			menu.items[menu.index+1]:invoke()
		end
		
	end
	
end
