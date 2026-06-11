local state = {}

state.load = function() end
state.update = function() end
state.draw = function() end
state.keypressed = function() end
state.keyreleased = function() end
state.mousepressed = function() end
state.mousereleased = function() end

function state.switch(newstate, ...)
end

return state