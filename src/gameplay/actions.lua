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
		
		menus:quit()
		
	end
	
}


unequip = {
	
	name = "unequip",
	
	invoke = function()
		
		player.hand = nil
		
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
		
		player.actions = {scan, walk}
		
		menus:quit()
		
	end
	
}


walk = {
	
	name = "walk",
	
	invoke = function()
		
		player.running = false
		
		player.actions = {scan, runn}
		
		menus:quit()
		
	end
	
}

