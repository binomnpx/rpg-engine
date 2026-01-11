pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
-- main

-- world
-- biotic
--   -resources
--   -level/experience
--   -player
--     -controls
--   -npcs
--     -ai
--   -gear
--   -abilities
--   -consumables
-- abiotic
--   -buildings
--   -roads
--   -terrain
--   -biomes
--   -obstacles
--   -containers
-- encounters
--   -npcs
--   -gear
--   -containers
--   -abilities
--   -obstacles
-- quests
--   -npcs
--   -items
--   -obstacles
-- character creation
-- adventure creation

-- generation
--  world
--    -biome
--      -terrain
--        -buildings
--          -roads
--          -npcs (homeful)
--        -npcs (homeless)
--        -obstacles
--  adventure
--    -quest
--      -encounter
--        -npcs
--        -items
--        -obstacles
--        -containers
--          -gear
--          -abilities

-- adventure
--   -starting area
--     -gear
--     -npcs
--     -consumables
--     -abilities
--   -middle areas
--     -keys
--     -doors
--   -ending area
--     -npc (villain)
--     -lair

-- ui
--  -message boxes
--  -menus
--  -status bars
--  -map

function _init()
		
		-- global vars
		
		ctrl = "player"
		
end


function _update60()
		
		
		-- player input
		
		if ctrl == "player" then
    
		  player:upd()
    
  elseif ctrl == "inventory" then
  	 
  	 inventory:upd()
  	 
  end
		
		
		-- handle screen transition
		
		if ctrl == "camera" then
		-- camera movement queued
		  
		  cam:upd()
			 
		end
		
		
		-- update messages
		
		for m in all(messages) do
			 
			 m:upd()
			 
		end
		
end


function _draw()
		
		cls()
		
		camera(cam.x, cam.y)
		
		
		-- background
		
		map()
		
		
		-- player
		
		player:drw()
		
		
		-- messages
		
		for m in all(messages) do
			 
			 m:drw()
			 
		end
		
		
		-- inventory menu
		
		if ctrl == "inventory" then
			 
				camera()
				
			 inventory:drw()
			 
		end
		
end
-->8
-- map and cam


-- map

for x = 0, 255 do

	 for y = 0, 255 do
	 	 
	 	 local r = ceil(sqrt(rnd(25)))
	 	 
	 	 mset(x, y, r)
	 	 
  end
	 
end


-- cam

cam = {
  
  x = 0,
  y = 0,
  q = {},
  ⧗ = 0,
  
  upd = function()
    
    if cam.⧗ == 0 then
				-- start moving
				  
					 cam.⧗ = 64
					 
			 else
				-- camera is moving
				  
				  cam.⧗ -= 1
		    
					 if cam.q[1] == "➡️" then
					   
					 	 cam.x += 2
					 	 
					 elseif cam.q[1] == "⬅️" then
					   
					 	 cam.x -= 2
					 	 
					 elseif cam.q[1] == "⬇️" then
					   
					 	 cam.y += 2
					 	 
					 elseif cam.q[1] == "⬆️" then
					   
					 	 cam.y -= 2
					 	 
					 end
					 
				end
					 
				if cam.⧗ == 0 then
				-- camera done moving
				  
					 deli(cam.q, 1)
					 
				end
				
				if #cam.q == 0 then
					 
					 ctrl = "player"
					 
				end
    
  end
  
}

function handle_camera_movement()
	 
	 
	 
end
-->8
-- player and inventory

player = {

  x = 8,
  y = 8,
  s = 16,
  
  flip_x = false,
  
  upd = function(player)
    
    --------------
    -- movement --
    --------------
    
    local x0 = player.x
    local y0 = player.y
    
    -- movement and sprites
    
    if btnp(⬅️) then
    	 
    	 player.x -= 1
    	 player.s = 16
    	 player.flip_x = false
    	 
    end
    
    if btnp(➡️) then
    	 
    	 player.x += 1
    	 player.s = 16
    	 player.flip_x = true
    	 
    end
    
    if btnp(⬆️) then
    	 
    	 player.y -= 1
    	 player.s = 17
    	 
    end
    
    if btnp(⬇️) then
    	 
    	 player.y += 1
    	 player.s = 18
    	 
    end
    
    -- collision and screen
    --  transition
    
    if fget(mget(player.x, player.y)) > 0 then
    -- collided, so dont move
    
    	 player.x = x0
    	 player.y = y0
    	 
    else
    -- player moved
    
      -- queue camera transition
    	 
    	 if player.x % 16 == 0 and
    	    x0 % 16 == 15
    	 then
    	 	 
    	 	 add(cam.q, "➡️")
    	 	 
      end
      
      if player.x % 16 == 15 and
    	    x0 % 16 == 0
    	 then
    	 	 
    	 	 add(cam.q, "⬅️")
    	 	 
      end
      
      if player.y % 16 == 0 and
    	    y0 % 16 == 15
    	 then
    	 	 
    	 	 add(cam.q, "⬇️")
    	 	 
      end
      
      if player.y % 16 == 15 and
    	    y0 % 16 == 0
    	 then
    	 	 
    	 	 add(cam.q, "⬆️")
    	 	 
      end
      
      
      if #cam.q > 0 then
		    -- give control to camera
		      
		      ctrl = "camera"
		      
		    end
    	 
    end
    
    
    -----------------
    -- interaction --
    -----------------
    
    -- interact with object
    
    if btnp(❎) then
    	 
    	 local xos = 0
    	 local yos = 0
    	 
    	 -- get offsets in
    	 --  direction player
    	 --  is facing
    	 
    	 if player.s == 16 then
    	 -- left/right
    	 
    	 	 if player.flip_x then
    	 	 -- right
    	 	 
    	 	 	 xos = 1
    	 	 	 
    	 	 else
    	 	 -- left
    	 	 
    	 	 	 xos = -1
    	 	 	 
        end
    	 	 
      elseif player.s == 17 then
      -- up
      
        yos = -1
        
      else
      -- down
      
        yos = 1
        
      end
    	 
    	 
    	 -- determine object
    	 --  then act
    	 
    	 local ox = player.x+xos
    	 local oy = player.y+yos
    	 
    	 local objflags = fget(mget(ox, oy))
    	     	 
    	 if objflags == 0b1 then
    	 -- rock
    	   
    	   -- destroy rock
    	   
    	 	 mset(ox, oy, 3)
    	 	 
      elseif objflags == 0b10 then
      -- npc
      	 
      	 -- display message
      	 
        local msg = rnd({"hey", "yo", "sup"})
	             	 
      	 add_message(msg, ox, oy)
      	 
      elseif objflags == 0b100 then
      -- closed chest
        
    	 	 mset(ox, oy, 57)
    	 	 
    	 	 local item = rnd({"apple", "orange", "banana"})
    	 	 
    	 	 add(inventory, item)
    	 	 
    	 	 add_message(item, ox, oy)
    	 	 
      elseif objflags == 0b1000 then
      -- closed chest
      	 
      	 
      elseif objflags == 0b10000 then
      -- enemy
      	 
      	 -- display message
      	 
        local msg = rnd({"grr", "...", "sss"})
	             	 
      	 add_message(msg, ox, oy)
      	       	 
      end
    	 
    end
    
    
    -- open inventory
    
    if btnp(🅾️) then
		  	 
		  	 inventory.index = 0
		  	 
		  	 ctrl = "inventory"
		  	 
    end
    
    
  end,
  
  drw = function(player)
    
    -- keep player visible in
    --  current screen before
    --  transitioning
    
    local xos = 0
    local yos = 0
    
    if cam.⧗ > 2 then
    -- camera is moving
    
    	 for q in all(cam.q) do
    	 	 
    	 	 if q == "⬅️" then
		    	 	 
		    	 	 xos += 8
		    	 	 
		      elseif q == "➡️" then
		    	 	 
		    	 	 xos -= 8
		    	 	 
		      elseif q == "⬆️" then
		    	 	 
		    	 	 yos += 8
		    	 	 
		      elseif q == "⬇️" then
		    	 	 
		    	 	 yos -= 8
		    	 	 
		      end
    	 	 
      end
    	 
    end
    
    
    -- draw player
    
    spr(player.s, player.x*8+xos, player.y*8+yos, 1, 1, player.flip_x)
    
  end
  
}


-- inventory

inventory = {
  
  index = 0,
  
  drw = function()
    
    local width = 48
    
    local height = max(10, 10 + (#inventory-1)*8)
    
    rectfill(
      40,
      32,
      40 + width,
      32 + height,
      0
    )
    
    rect(
      40,
      32,
      88,
      32 + height,
      7
    )
    
    if #inventory > 0 then
    	 
    	 for i = 1, #inventory do
    	 	 
    	 	 print(
    	 	   inventory[i],
		    	   40 + 3 + 5,
		    	   32 + 3 + (i-1)*8,
		    	   7
		    	 )
		    	 
		    	 spr(
		    	   58, 40 + 3,
		    	   32 + 3 + (inventory.index)*8
		    	 )
    	 	 
      end
    	 
    end
    
  end,
  
  upd = function(self)
    
    if btnp(🅾️) then
    	 
    	 ctrl = "player"
    	 
    end
    
    if btnp(⬆️) then
    	 
    	 inventory.index = (inventory.index-1) % #inventory
    	 
    end
    
    if btnp(⬇️) then
    	 
    	 inventory.index = (inventory.index+1) % #inventory
    	 
    end
    
  end
  
}
-->8
-- scenery and containers



-- scenery

for i = 1,400 do
	 
	 local x
	 local y
	 
	 repeat
	 	 
	 	 x = flr(rnd(128))
	   y = flr(rnd(64))
	 	 
  until x != 8 or y != 8
  
  local s = 48+flr(rnd(8))
  
  for i = 1, flr(rnd(4)) do
  	 
  	 mset(
  	   x + flr(rnd(5)),
  	   y + flr(rnd(5)),
  	   s
  	 )
  	 
  end
  
end


-- containers


for i = 1,100 do
	 
	 local x
	 local y
	 
	 repeat
	 	 
	 	 x = flr(rnd(128))
	   y = flr(rnd(64))
	 	 
  until x != 8 or y != 8
  
  mset(x, y, 56)
  
end


-->8
-- npcs and messages

for i = 1, 100 do
	 
	 local x
	 local y
	 
	 repeat
	 	 
	 	 x = flr(rnd(128))
	   y = flr(rnd(64))
	 	 
  until x != 8 or y != 8
  
  mset(x, y, 32+flr(rnd(4)))
	 
end


messages = {}

function add_message(msg, x, y)
	 
	 add(messages, {
	   
	   x = x,
	   y = y-1,
	   
--	   msg = msg,
	   
	   ♥ = 40,
	   
	   upd = function(self)
	     
	     self.♥ -= 1
	     
	     if self.♥ == 0 then
	     	 
	     	 del(messages, self)
	     	 
      end
	     
	   end,
	   
	   drw = function(self)
	     
	     print(
	       "\^o0ff"..msg,
	       self.x*8 + 4 - #msg*4/2,
	       self.y*8,
	       7
	     )
	     
	   end
	   
	 })
	 
end
__gfx__
0000000011111d111111111d11111111111111111111111100000000000000000000000000000000000000000000000000000000000000000000000000000000
000000001d1ddddd1ddd1111111111d1111111111111111100000000000000000000000000000000000000000000000000000000000000000000000000000000
007007001111ddd11ddd11d111111111111111111111111100000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000d11d111d1dddd1111d111111111111111111111100000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700011111111111d111111111111111111111111111100000000000000000000000000000000000000000000000000000000000000000000000000000000
007007001dd11dd11d11111d11111111111111111111111100000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000011d11dd111111d1111111d11111111111111111100000000000000000000000000000000000000000000000000000000000000000000000000000000
000000001111111111d1111111111111111111111111111100000000000000000000000000000000000000000000000000000000000000000000000000000000
11122211112221111122211100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
111ccc211122221111ccc21100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1112cc2211222221112cc22100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11ccccc11cccccc11cccccc100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1c1ccc1cc1cccc1cc1cccc1c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
111cc131111cc131111cc13100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11133133111331331113313300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11133311111333111113331100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11131311118888111111111111111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11abab3128a88a82111d111111112221000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1bbbbb11180880811dddd1111112efe2000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1b0bbb31812222181d0ddd11112ff2f2000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11bbbb118ee11ee8ddddddd199022fe2000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
13bbb3318811118816dd66dd19992221000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11bbb31b18811881111d11d191911111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
111bbbb1111111111111111111111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
111111111111111111111111111111111111111111111111118e18111111cc111111111115555551700000000000000000000000000000000000000000000000
1111111111555111111b1111112222111194194116d11111118e88e8111cc1111555555152222255770000000000000000000000000000000000000000000000
11115551156665511b1b111b12d22d2111994941166d61118e8e8e88c1ccd11c5444454552222225777000000000000000000000000000000000000000000000
1155565515666dd51b11b11b222d22d1941949941166616d888e888ecdccccdc5444454515222225770000000000000000000000000000000000000000000000
155666d5115566d5113131312d22d221994941946d66d16618e88ee81ccdccc155aa555555aa5555700000000000000000000000000000000000000000000000
55666dd515dd5551b131313122d22222194941946666d66d18e8ee88dccccc115444454554444545000000000000000000000000000000000000000000000000
5dddddd556dd5dd5331313131222222219999994116666d118888881cc11cd115444454554444545000000000000000000000000000000000000000000000000
5dddddd5566d5dd513131313111112211119941111166d1111188111c1111cc15555555555555555000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000000000000000000000000000000000020202100000000000000000000000000101010101010101040800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
