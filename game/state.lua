local state = {}

state.vars = {}

state.current = "ejdbjsdjebueuene73u3bf"

state.loadscreen = function(name, msg)
  if name and msg then
    love.graphics.print(name .. msg)
  elseif name and (not msg) then
    love.graphics.print(name .. " is loading")
  elseif (not name) and msg then
    love.graphics.print(msg)
  else
    love.graphics.print("state loading...")
  end
end

function state.setloadscreen(func)
  if type(func) == "function" then
    state.loadscreen = func
  else
    state.loadscreen = function(name, msg)
      if name and msg then
        love.graphics.print(name .. msg)
      elseif name and (not msg) then
        love.graphics.print(name .. " is loading")
      elseif (not name) and msg then
        love.graphics.print(msg)
      else
        love.graphics.print("state loading...")
      end
    end
  end
end

state.cb = {}

state.cb.load = function() end
state.cb.update = function() end
state.cb.draw = function() end
state.cb.keypressed = function() end
state.cb.keyreleased = function() end
state.cb.mousepressed = function() end
state.cb.mousereleased = function() end

function state.switch(newstate, ...)
  love.draw = function()
    state.loadscreen(newstate)
  end
  state.vars = {...}
  package.loaded[state.current] = nil
  state.cb = {}
  local new = require(newstate)
  if type(new) == "table" then
    for i, v in new do
      if type(v) == "function" then
        state.cb[i] = v
      end
    end
  else
    error("not state")
  end
  local cb = state.cb
  if cb.load then
    cb.load()
  end
  love.update = cb.update or function(dt)
  end
  love.draw = cb.draw or function() end
  love.keypressed = cb.keypressed or function() end
  love.keyreleased = cb.keyreleased or function() end
  --[[ continue the other ones later
  --]]
end

function state.getvars(i)
  if i then
    return state.vars[i]
  else
    return state.vars or {}
  end
end

function state.clearvars(i)
  if i then
    state.vars[i] = nil
  else
    state.vars = {}
  end
end

return state