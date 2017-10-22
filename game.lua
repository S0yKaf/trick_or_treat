
local sti = require "libs.sti.sti"
local Camera = require "libs.hump.camera"

require "player"

game = {}

function game:init()
  self.width = 400
  self.height = 300
  self.scale_factor = 3
  love.physics.setMeter(16)
  map = sti("textures/tilemap.lua", { "box2d" })
  world = love.physics.newWorld(1, 0)
  map:box2d_init(world)

end

function game:draw()
  -- love.graphics.scale(5, 5)
  draw_world()
  player:draw()
end

function game:update(dt)
  player:update(dt)
  map:update(dt)
end

function draw_world()
  map:draw()
end

function game:enter()
  love.window.setMode(
    50 * 16,
    25 * 16
  )
end
