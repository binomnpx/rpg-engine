-- Menu system and menu stack handling.

menus = {}

function menus:add(items, ...)
	
	if ctrl.state != "menuing" then
		
		-- save state so that we can return to it once menuing is done
		
		menus.state = ctrl.state
		
		-- set state to menuing
		
		ctrl.state = "menuing"
		
	end
	
	add(menus, {
		
		items = items,
		index = 0,
		x = 32 + #menus*4,
		y = 16 + #menus*4,
		
		type = ...
		
	})
	
end


function menus:draw()
	
	for m in all(menus) do
		
		-- this just adds a fake item so an empty menu looks good
		-- also prevents pointer from being drawn if menu is empty
		local empty = 0
		
		if #m.items == 0 then
			empty = 1
		end
		
		-- draw the menu
		local x = m.x
		local y = m.y
		
		-- black rectangle
		rectfill(x, y, x+64, y + 2 + 8*(#m.items+empty), 0)
		
		-- white outline
		rect(x, y, x+64, y + 2 + 8*(#m.items+empty), 7)
		
		-- item names
		for i = 1, #m.items do
			
			print(m.items[i].name, x+8, y-5 + 8*i, 7)
			
		end
		
		-- pointer
		if empty == 0 then
			spr(menus_sprite_pointer, x+3, y+3 + 8*m.index)
		end
		
	end
	
end


-- quit menuing

function menus:quit()
	
	for i = 1, #menus do
		
		deli(menus, 1)
		
	end
	
	ctrl.state = menus.state
	
end

-- delete item from previous menu

function menus:delprev()
	
	local prev = menus[#menus-1]
	
	deli(prev, prev.index+1)
	
	-- shift index up if last item was deleted
	prev.index = min(prev.index, #prev.items-1)
	
end


-- close current menu

function menus:close()
	
	deli(menus, #menus)
	
end


-- get item from current or a previous menu

function menus:get(n)
	
	return menus[#menus-n].items[menus[#menus-n].index+1]
	
end

