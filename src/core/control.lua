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
	
	function inrange(x0, y0, x1, y1, range)
		
		if (x0 - x1)^2 + (y0 - y1)^2 <= range^2 + range then
			 
			 return(true)
			 
		end
		
	end
	
end

function ctrl:update()
	
	-- player ---------------------------------------------------------------------------------------------------------
	
	if ctrl.state == "player" then
		
		if btnp(0) then
			-- left
			
			if not player.flip_x and player.s == player_sprite_frontleft then
				
				move(player, -1, 0)
				
			else
				
				player.s = player_sprite_frontleft
				player.flip_x = false
				player.xos = -1
				player.yos = 0
				
				if player.running then
					
					move(player, -1, 0)
					
				end
				
			end
			
		end
		
		if btnp(1) then
			-- right
			
			if player.flip_x and player.s == player_sprite_frontleft then
				
				move(player, 1, 0)
				
			else
				
				player.s = player_sprite_frontleft
				player.flip_x = true
				player.xos = 1
				player.yos = 0
				
				if player.running then
					
					move(player, 1, 0)
					
				end
				
			end
			
		end
		
		if btnp(2) then
			-- up
			
			if player.s == player_sprite_back then
				
				move(player, 0, -1)
				
			else
				
				player.s = player_sprite_back
				player.facefront = false
				player.xos = 0
				player.yos = -1
				
				if player.running then
					
					move(player, 0, -1)
					
				end
				
			end
			
		end
		
		if btnp(3) then
			-- down
			
			if player.s == player_sprite_front then
				
				move(player, 0, 1)
				
			else
				
				player.s = player_sprite_front
				player.facefront = true
				player.xos = 0
				player.yos = 1
				
				if player.running then
					
					move(player, 0, 1)
					
				end
				
			end
			
		end
		
		if btnp(4) then
			-- O
			
			-- open inventory
			
			menus:add(player.inventory)
			
		elseif btnp(5) then
			-- X
			
			local obj
			
			for e in all({npcs, containers, burlaps, doors}) do
				
				for i in all(e) do
					
					if i.x == player.x + player.xos and i.y == player.y + player.yos then
						
						obj = i
						
					end
					
				end
				
			end
			
			local items = {}
			
			if obj and #obj.interactions > 0 then
				
				add(items, {name = "interact", invoke = function() menus:quit(); menus:add(obj.interactions) end})
				
				player.subject = obj
				
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
			
			menus:close()
			
			if #menus == 0 then
				
				ctrl.state = menus.state
				
				interact("player left")
				
			end
			
		elseif btnp(5) then
		-- X
			
			if #menu.items > 0 then
				
				if menu.type == "inventory" then
					
					menus:add({take, leave})
					
				else
					
					menu.items[menu.index+1]:invoke()
					
				end
				
			end
			
		end
		
	-- scanning -----------------------------------------------------------------------------------------------------------------
		
	elseif ctrl.state == "scanning" then
		
		if #cam.q == 0 then
			
			local x = flr(cam.x/8)
			local y = flr(cam.y/8)
			local q
			
			if btnp(0) then
				x -= 1
				q = 0
			elseif btnp(1) then
				x += 1
				q = 1
			elseif btnp(2) then
				y -= 1
				q = 2
			elseif btnp(3) then
				y += 1
				q = 3
			end
			
			if inrange(x, y, flr(scan.cam_x/8), flr(scan.cam_y/8), 3) then
				
				add(cam.q, q)
				
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
	
	elseif ctrl.state == "targeting" then
		
		if (btnp(0)) player.target.x -= 1
		if (btnp(1)) player.target.x += 1
		if (btnp(2)) player.target.y -= 1
		if (btnp(3)) player.target.y += 1
		
		if (btnp(4)) ctrl.state = "player"
		
	end
	
end

