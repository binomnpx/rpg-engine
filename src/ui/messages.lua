-- Transient messages and floating text.

messages = {}

function messages:add(message, x, y)
	
	add(messages, {
		
		x = x,
		y = y-1,
		
		message = message,
		
		life = 40
		
	})
	
end


function messages:update()
	
	for m in all(messages) do
		
		m.life -= 1
		
		if m.life == 0 then
			
			del(messages, m)
			
		end
		
	end
	
end

function messages:draw()
	
	for m in all(messages) do
		
		print(
		"\^o0ff"..m.message,
		m.x*8 + 4 - #m.message*4/2,
		m.y*8 + 1,
		7
		)
		
	end
	
end
