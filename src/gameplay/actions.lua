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
			?"\^o0ff☉", 119, 121, 7
		end
		
	end
}


talk = {
	
	name = "talk",
	
	invoke = function()
		
		interact("player talked")
		
	end
	
}