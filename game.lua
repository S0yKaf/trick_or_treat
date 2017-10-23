
local sti = require "libs.sti.sti"
local Camera = require "libs.hump.camera"

local player = require "player"

game = {}

function game:init()
  love.graphics.setDefaultFilter("nearest", "nearest")
  self.width = 400
  self.height = 300
  self.scale_factor = 3
  love.physics.setMeter(16)
  map = sti("textures/tilemap.lua", { "box2d" })
  world = love.physics.newWorld(1, 0)
  map:box2d_init(world)
  player:init()
end

function game:update(dt)
  player:update(dt)
  map:update(dt)
end

function game:draw()
  local w, h = love.graphics.getWidth(), love.graphics.getHeight()
  local cam = player.camera

  map:draw(-cam.x + w / cam.scale / 2, -cam.y + h / cam.scale / 2, cam.scale)

  cam:attach()
  player:draw()
  cam:detach()
end

function game:enter()
  love.window.setMode(
    50 * 16,
    25 * 16
  )
end
