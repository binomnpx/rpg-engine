-- Camera logic and screen transitions. Controls what part of the world is visible.

cam = {}

function cam:init()
	
	cam.x = 0
	cam.y = 0
	cam.q = {} -- movement queue
	cam.timer = {} -- movement timer/length
	cam.dxy = 0 -- movement step length (retained across entire queue)
	cam.player_shift = false -- shift player during screen transitions
	cam.ctrl = "player" -- remember previous ctrl for when camera is done
	
	subscribe(collision, cam)
	
end

function cam:on_notify(subject, event, data)
	
	if subject == collision then
		
		if event == "player moved" then
			
			local x0 = player.x - data.dx
			local y0 = player.y - data.dy
			
			if player.x % 16 == 0 and
			x0 % 16 == 15
			then
				
				add(cam.q, 1)
				
			end
			
			if player.x % 16 == 15 and
			x0 % 16 == 0
			then
				
				add(cam.q, 0)
				
			end
			
			if player.y % 16 == 0 and
			y0 % 16 == 15
			then
				
				add(cam.q, 3)
				
			end
			
			if player.y % 16 == 15 and
			y0 % 16 == 0
			then
				
				add(cam.q, 2)
				
			end
			
			
			if #cam.q > 0 then
				-- give control to camera
				
				ctrl.state = "camera"
				cam.ctrl = "player"
				
				for i = 1, #cam.q do
					
					add(cam.timer, 64)
					
				end
				
				cam.dxy = 2
				
				-- this tells player.drw
				-- to shift player
				-- when screen is
				-- transitioning
				
				cam.player_shift = true
				
			end
			
		end
		
	end
	
end

function cam:update()
	
	if ctrl.state == "camera" then
		
		local cam_q = cam.q[1]
		
		cam.timer[1] -= 1
		
		if cam_q == 1 then
			
			cam.x += cam.dxy
			
		elseif cam_q == 0 then
			
			cam.x -= cam.dxy
			
		elseif cam_q == 3 then
			
			cam.y += cam.dxy
			
		elseif cam_q == 2 then
			
			cam.y -= cam.dxy
			
		end
		
		if cam.timer[1] == 0 then
			-- camera done moving
			
			deli(cam.q, 1)
			deli(cam.timer, 1)
			
		end
		
		if #cam.q == 0 then
			
			ctrl.state = cam.ctrl
			cam.player_shift = false
			
		end
		
	end
	
end

