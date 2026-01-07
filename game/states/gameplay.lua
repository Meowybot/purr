--[[
TODO

add video
add audio
add level system
add level editor (not this state)
add smth that takes the first argument passed as the level
add a Smith that switches to game over and results state with
game over level id
results level id, hp, misses, hit notes (if i can even count that)
--]]

--state.vars
--1 = level file name

--states.gameplay

states.gameplay.note = {}
states.gameplay.note.add = function() end
states.ganeplay.notes = {}

local level = require("assets.levels."..state.vars[1])