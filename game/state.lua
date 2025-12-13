print("loading state file")

state = {}
states = {} --states lol

state.path = "states."
state.current = "SplashScreen"
state.vars = {}

function state.emptylove()
    print("emptying love2d callbacks")
    love.draw = function() end
    love.quit = function() end
    love.update = function() end
    love.keypressed = function() end
    love.keyreleased = function() end
    love.mousepressed = function() end
    love.mousereleased = function() end
    print("callbacks emptied successfully")
end

function state.switch(towhat, ...)
    print("switching to " .. towhat)
    print(...)
    state.vars = {...}
    state.emptylove()
    states[state.current] = nil
    package.loaded[state.path .. state.current] = false

    states[towhat] = {}
    require(state.path .. towhat)
    state.current = towhat

    print("successfully switched to " .. towhat)
end

function state.clear(clall, index)
    print("clearing state variables")
    if clall then
        state.vars = {}
    else
        state.vars[index] = nil
    end
    print("state variables cleared")
end

print("state file loaded")