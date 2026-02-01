-- Inventories library

inventories = {}

function inventories:create(...)
	
	local inv = {...}
	
	function inv:add(item)
		add(self, item)
	end
	
	function inv:remove(item)
		del(self, item)
	end
	
	return inv
	
end

