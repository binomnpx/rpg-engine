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
	
	-- player ---------------------------------------------------------------------------------------------------------
	
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
			
			local inv
			local act
			
			-- invoke object
			
			for e in all({npcs, containers, burlaps}) do
				
				for i in all(e) do
					
					if i.x == player.x + player.xos and i.y == player.y + player.yos then
						
						inv = function()
							i:invoke()
						end
						
						act = i.invoke_action
						
					end
					
				end
				
			end
			
			local items = {}
			
			if inv then
				add(items, {name = act, invoke = inv})
			end
			
			for a in all(player.actions) do
				add(items, a)
			end
			
			menus:add(items)
			
		end
		
	-- menuing ------------------------------------------------------------------------------------------------------
		
	elseif ctrl.state == "menuing" then
		
		-- get current menu
		local menu = menus[#menus]
		
		if btnp(2) then
		-- up
			
			menus[#menus].index = (menu.index-1) % #menu.items
			
		elseif btnp(3) then
		-- down
			
			menus[#menus].index = (menu.index+1) % #menu.items
			
		elseif btnp(4) then
		-- O
			
			menus[#menus] = nil
			
			if #menus == 0 then
				ctrl.state = menus.state
			end
			
		elseif btnp(5) then
		-- X
			
			if #menu.items > 0 then
				
				if menu.type == "burlap" then
					
					menus:add({take})
					
				else
					
					menu.items[menu.index+1]:invoke()
					
				end
				
			end
			
		end
		
	-- scanning -----------------------------------------------------------------------------------------------------------------
		
	elseif ctrl.state == "scanning" then
		
		if #cam.q == 0 then
			if btnp(0) then
				add(cam.q, 0)
			elseif btnp(1) then
				add(cam.q, 1)
			elseif btnp(2) then
				add(cam.q, 2)
			elseif btnp(3) then
				add(cam.q, 3)
			end

			if #cam.q > 0 then
				ctrl.state = "camera"
				cam.state = "scanning"

				add(cam.timer, 8)
				cam.dxy = 1
			end
		end

		if ctrl.state != "camera" and btnp(4) then
			local dx = scan.cam_x - cam.x
			local dy = scan.cam_y - cam.y

			if dx != 0 then
				
				add(cam.q, (dx > 0 and 1 or 0))

				add(cam.timer, abs(dx))
				
			end

			if dy != 0 then
				
				add(cam.q, (dy > 0 and 3 or 2))

				add(cam.timer, abs(dy))
				
			end
			
			cam.dxy = 1

			cam.ctrl = "player"
			ctrl.state = "camera"
			
			if dx == 0 and dy == 0 then
				ctrl.state = "player"
			end
		end
	end
	
end

