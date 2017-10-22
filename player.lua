Camera = require "libs.hump.camera"

player = {}

function love.load()
  player = Camera(10, 5, 2)
end
