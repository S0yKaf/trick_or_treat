require "game"
require "title"

GameState = require "libs.hump.gamestate"

local state = nil

function love.load()
  GameState.registerEvents()
  GameState.switch(game)
end

-- function love.draw() GameState.draw() end
-- function love.update(dt) GameState.update(dt) end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end
