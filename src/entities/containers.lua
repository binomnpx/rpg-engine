-- Chests, etc.

-- containers

containers = {}

function containers:init()

local indices = shuffle(128*64)

for i = 1,100 do
	 
  local x = indices[i] % 128
  local y = flr(indices[i] / 128)
  
  add(containers, {
    
    x = x,
    y = y,
    
    s = 56,
    
    invoke = function(self)
      
      if self.s == 56 then
      	 
      	 self.s = 57
      	 
      	 local item = rnd({apple, orange, banana})
    	 	 
    	 	 add(player.inventory, item)
    	 	 
    	 	 messages:add(item.name, self.x, self.y)
      	 
      end
      
    end
  })
  
end

end



function containers:draw()

		local il = max(0, flr(cam.x/8)-1)
		local ir = min(127, flr(cam.x/8)+16)
		
		local jl = max(0, flr(cam.y/8)-1)
		local jr = min(63, flr(cam.y/8)+16)
		
		for s in all(containers) do
		  
		if s.x >= il and s.x <= ir and
		   s.y >= jl and s.y <= jr
		then
		  palt(0, false)
		  spr(s.s, s.x*8, s.y*8)
		  palt(0, true)
		end
		  
		end
		
		
end

