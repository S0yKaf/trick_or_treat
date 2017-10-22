local Camera = require "libs.hump.camera"

local camera = Camera.new()

player = {}

function player:init()
  self.x = 100
  self.y = 100
  self.img = love.graphics.newImage('textures/player.png')
  camera:zoomTo(10)
end

function player:update(dt)
  camera:lookAt(100, 360)
end

function player:draw()
  love.graphics.draw(love.graphics.newImage('textures/player.png'), 100, 360)
end
