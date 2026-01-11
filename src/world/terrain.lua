-- Scenery

-- lives in map RAM

-- terrain

terrain = {}

function terrain:init()

	for x = 0, 127 do

		 for y = 0, 63 do
			 
			 local r = ceil(sqrt(rnd(25)))
			 
			 mset(x, y, r)
			 
	  end
		 
	end

end
