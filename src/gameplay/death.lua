-- handles death

function death(obj)
	
	if obj.hp <= 0 then
		
		if obj.inventory and #obj.inventory then
			
			burlaps:add(obj.x, obj.y, obj.inventory)
			
		end
		
		del(locations.current.entities, obj)
		
	end
	
end

