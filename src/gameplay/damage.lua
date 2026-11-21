-- handles damage

function damage(obj, effect)
	
	obj.hp -= effect.power
	
	death(obj)
	
end

