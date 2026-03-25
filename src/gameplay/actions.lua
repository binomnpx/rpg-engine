-- Actions found in menus

eat = {
	
	name = "eat",
	
	invoke = function()
		
		messages:add("yum", player.x, player.y)
		
		deli(player.inventory, menus[#menus-1].index+1)
		
		menus:quit()
		
	end
	
}

drink = {
	
	name = "drink",
	
	invoke = function()
		
		messages:add("glug", player.x, player.y)
		
		deli(player.inventory, menus[#menus-1].index+1)
		
		menus:quit()
		
	end
	
}


toss = {
	
	name = "toss",
	
	invoke = function()
		
		burlaps:add(player.x, player.y, menus:get(1))
		
		deli(player.inventory, menus[#menus-1].index+1)
		
		menus:delprev()
		
		menus:close()
		
	end
	
}


search = {
	
	name = "search",
	
	invoke = function()
		
		menus:quit()
		
		menus:add(player.subject.inventory, "inventory")
		
		interact("player searched")
		
	end
	
}


take = {
	
	name = "take",
	
	invoke = function()
		
		local item = menus:get(1)
		
		messages:add(item.name, player.x, player.y)
		
		add(player.inventory, item)
		
		del(player.subject.inventory, item)
		
		interact("item taken")
		
		menus:quit()
		
		interact("player left")
		
	end
	
}


leave = {
	
	name = "leave",
	
	invoke = function()
		
		menus:quit()
		
		interact("player left")
		
	end
	
}


equip = {
	
	name = "equip",
	
	invoke = function()
		
		player.hand = menus:get(1)
		
		local missing = true
		
		for a in all(player.actions) do
			
			if (a == attack) missing = false
			
		end
		
		if (missing) add(player.actions, attack)
		
		menus:quit()
		
	end
	
}


unequip = {
	
	name = "unequip",
	
	invoke = function()
		
		player.hand = nil
		
		del(player.actions, attack)
		
		menus:quit()
		
	end
	
}


scan = {
	
	name = "scan",
	cam_x = nil,
	cam_y = nil,

	invoke = function()
		
		scan.cam_x = cam.x
		scan.cam_y = cam.y
		
		menus:quit()
		
		ctrl.state = "scanning"
		cam.ctrl = "scanning"
		
	end,
	
	draw = function()
		
		if cam.ctrl == "scanning" then
			--[[ ?"\^o0ff☉", 119, 121, 7 ]]
			spr(29, 120, 120)
			pset(123 - flr(scan.cam_x/8) + flr(cam.x/8), 123 - flr(scan.cam_y/8) + flr(cam.y/8), 8)
		end
		
	end
}


talk = {
	
	name = "talk",
	
	invoke = function()
		
		interact("player talked")
		
	end
	
}


open = {
	
	name = "open",
	
	invoke = function()
		
		interact("player opened")
		
		menus:quit()
		
	end
	
}


close = {
	
	name = "close",
	
	invoke = function()
		
		interact("player closed")
		
		menus:quit()
		
	end
	
}


runn = {
	
	name = "run",
	
	invoke = function()
		
		player.running = true
		
		del(player.actions, runn)
		add(player.actions, walk)
		
		menus:quit()
		
	end
	
}


walk = {
	
	name = "walk",
	
	invoke = function()
		
		player.running = false
		
		del(player.actions, walk)
		add(player.actions, runn)
		
		menus:quit()
		
	end
	
}


attack = {
	
	name = "attack",
	
	invoke = function()
		
		local obj
		
		for e in all({npcs, containers, burlaps, doors}) do
			
			for i in all(e) do
				
				if i.x == player.x + player.xos and i.y == player.y + player.yos then
					
					obj = i
					break
					
				end
				
			end
			
		end
		
		if obj and obj.hp then
			
			messages:add("-"..player.hand.power.." hp", obj.x, obj.y)
			
		end
		
		menus:quit()
		
	end
	
}


target = {
	
	name = "target",

	invoke = function()
		
		menus.state = "targeting"
		
		player.target = {x = player.x + player.xos, y = player.y + player.yos}
		
		menus:quit()
		
	end,
	
	draw = function()
		
		if ctrl.state == "targeting" then
			
			local x = player.target.x*8
			local y = player.target.y*8
			
			rect(x,y,x+7,y+7,7)
			
		end
		
	end
}


teleport = {
	
	name = "teleport",
	
	invoke = function()
		
		menus.state = "targeting"
		
		player.targeting = teleport
		
		player.target = {x = player.x + player.xos, y = player.y + player.yos}
		
		menus:quit()
		
	end,
	
	targeting = function()
		
		player.x = player.target.x
		player.y = player.target.y
		
		ctrl.state = "player"
		
	end
	
}