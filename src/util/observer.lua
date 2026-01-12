-- Observer pattern for decoupling

-- "observer" pattern functions

-- subjects may use notify()
--  somewhere in their logic
--  to trigger an event. this
--  event is immediately heard
--  by every observer subscribed
--  to the subject. their
--  response to the event is
--  immediately run according
--  to their on_notify()
--  function.

function notify(subject, event, data)
	
	for observer in all(subject.observers) do
		
		observer:on_notify(subject, event, data)
		
	end
	
end


function subscribe(subject, observer)
	
	if not subject[observer] then
		
		if not subject.observers then
			
			subject.observers = {}
			
		end
		
		add(subject.observers, observer)
		
		subject[observer] = true
		
	end
	
end


function unsubscribe(subject, observer)
	
	if subject[observer] then
		
		del(subject.observers, observer)
		
		subject[observer] = nil
		
	end
	
end


function subscribe_all(subjects, observer)
	
	for s in all(subjects) do
		
		subscribe(s, observer)
		
	end
	
end
