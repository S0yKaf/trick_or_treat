local Camera = require "libs.hump.camera"

local player = {}

function player:init()
  self.x = 100
  self.y = 359
  self.img = love.graphics.newImage('textures/player.png')
  self.camera = Camera.new(self.x, self.y, 3)
end

function player:update(dt)
  self.camera:lookAt(self.x, self.y)
end

function player:draw()
  love.graphics.draw(self.img, self.x, self.y)
end

return player
