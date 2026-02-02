-- Interaction library

function interact(event)
	
	if player.subject and player.subject.on_interact then
		
		player.subject:on_interact(event)
		
	end
	
end

