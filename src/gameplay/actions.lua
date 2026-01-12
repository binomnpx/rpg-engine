-- Actions found in menus

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
		
		deli(player.inventory, menus[#menus-1].index+1)
		
		menus:delprev()
		
		menus:close()
		
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


