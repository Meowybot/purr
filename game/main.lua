function love.load()
    print("loading game")
    require("state")
    love.filesystem.mount(love.filesystem.getSourceBaseDirectory() .. "/assets", "assets", true) -- assets are in the source base directory
    print(love.filesystem.getSourceBaseDirectory())
    state.switch("mainmenu", love.system.getOS())
end