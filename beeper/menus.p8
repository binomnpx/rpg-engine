pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
-- menus

function add_menu(items)
	 
	 local menu = {
	   
	   items = items,
	   pointer = 0,
	   x = 32 + #menus*4,
	   y = 16 + #menus*4
	   
	 }
	 
	 function menu:invoke()
			 
			 self.items[self.pointer+1].invoke()
			 
		end
		
		function menu:drw()
			 
			 local x = self.x
			 local y = self.y
			 
			 rectfill(x, y, x+64, y + 8*#self.items, 0)
			 rect(x, y, x+64, y + 8*#self.items, 7)
			 
			 for i = 1, #self.items do
			 	 
			 	 print(self.items[i].name, x+6, y-6 + 8*i, 7)
			 	 
		  end
		  
		  spr(1, x+2, y+2 + 8*self.pointer)
			 
		end
		
		function menu:upd()
			 
			 if (btnp(⬆️)) self.pointer = (self.pointer-1) % #self.items
			 if (btnp(⬇️)) self.pointer = (self.pointer+1) % #self.items
			 
			 if (btnp(❎)) self:invoke()
			 
			 if (btnp(🅾️)) menus[#menus] = nil
			 
		end
		
		add(menus, menu)
	 
end


function menus_init()
	 
	 menus = {}
	 
end


function menus_upd()
	 
	 if #menus > 0 then
			 
			 menus[#menus]:upd()
			 
		else
		  
		  if(btnp(❎)) add_menu({beeper})
			 
		end
	 
end

function menus_drw()
	 
	 for menu in all(menus) do
		  
		  menu:drw()
		  
		end
	 
end

-->8
-- items

-- add item

beep = {
  
  name = "beep",
  
  invoke = function()
    sfx(0)
  end
  
}


boop = {
  
  name = "boop",
  
  invoke = function()
    sfx(1)
  end
  
}


beeper = {
  
  name = "beeper",
  
  invoke = function()
  	 
  	 add_menu({beep, boop})
  	 
  end
  
}
__gfx__
00000000700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
001000003305000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000001b05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
