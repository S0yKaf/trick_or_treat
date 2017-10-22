
local sti = require "libs.sti.sti"
local Camera = require "libs.hump.camera"

player = require "player"

game = {}

function game:init()
  self.width = 400
  self.height = 300
  self.scale_factor = 3
  love.physics.setMeter(16)
  map = sti("textures/tilemap.lua", { "box2d" })
  world = love.physics.newWorld(0, 0)
  camera = Camera(10, 5, 5)
  map:box2d_init(world)

end

function game:draw()
  -- love.graphics.scale(5, 5)
  camera:draw(draw_world)
end

function game:update(dt)
  map:update(dt)
end

function draw_world()
  map:draw()
end
