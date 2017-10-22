
require "game"
Gamestate = require "libs.hump.gamestate"

title = {}

function title:init()
  self.width = 400
  self.height = 300
  self.scale_factor = 3

  self.never = 1000000

  self:init_gfx()
  self:init_sfx()
end


function title:init_gfx()
  love.graphics.setDefaultFilter("nearest", "nearest")

  local img = love.graphics.newImage
  self.gfx = {}

  self.gfx.fg = img("gfx/title_fg.png")
  self.gfx.bg = img("gfx/title_bg.png")
  self.gfx.flash = img("gfx/title_flash.png")

  self.gfx.rain = img("gfx/rain.png")
  self.gfx.rain:setWrap("repeat", "repeat")
  self.gfx.rain_quad = love.graphics.newQuad(
    0, 0, 2000, 2000,
    self.gfx.rain:getWidth(), self.gfx.rain:getHeight()
  )

  self.gfx.lightning = {
    img("gfx/title_lightning_01.png"),
    img("gfx/title_lightning_02.png"),
    img("gfx/title_lightning_03.png"),
    img("gfx/title_lightning_04.png"),
  }
end


function title:init_sfx()
  local snd = love.audio.newSource
  self.sfx = {}

  self.sfx.bach = snd("sfx/bach.ogg")

  self.sfx.rain = snd("sfx/rain.ogg")

  self.sfx.thunder = {
    snd("sfx/thunder_01.wav", "static"),
    snd("sfx/thunder_02.wav", "static"),
    snd("sfx/thunder_03.wav", "static"),
    snd("sfx/thunder_04.wav", "static"),
  }
end


function title:enter()
  love.window.setMode(
    self.width * self.scale_factor,
    self.height * self.scale_factor
  )

  self.sfx.bach:setVolume(0.8)
  self.sfx.bach:rewind()
  self.sfx.bach:play()

  self.sfx.rain:setVolume(0.28)
  self.sfx.rain:setLooping(true)
  self.sfx.rain:play()

  self.lightning_timer = 6.66
  self.thunder_timer = self.never
  self.rain_pos = {x = -1000, y = -1000}

  self.current_bg = self.gfx.bg
end


function title:leave()
  self.sfx.bach:pause()
  self.sfx.rain:pause()
end


function title:resume()
  self.sfx.bach:play()
  self.sfx.rain:play()
end


function title:update(dt)
  local rand = love.math.random

  self.lightning_timer = self.lightning_timer - dt
  self.thunder_timer = self.thunder_timer - dt

  if self.lightning_timer < -666.2 then
    self.current_bg = self.gfx.bg
    self.lightning_timer = rand(2, 7)
  end

  if self.current_bg == self.gfx.flash and self.lightning_timer < -666 then
    local i = math.floor(rand(1, 4))
    self.current_bg = self.gfx.lightning[i]
  end

  if self.lightning_timer > -500 and self.lightning_timer < 0 then
    self.current_bg = self.gfx.flash
    self.lightning_timer = rand(-665.94, -665.87)
    self.thunder_timer = rand(0, 0.8)
  end

  if self.thunder_timer < 0 then
    local i = math.floor(rand(1, 4))
    self.sfx.thunder[i]:setVolume(rand(0.3, 0.6))
    self.sfx.thunder[i]:play()
    self.thunder_timer = self.never
  end

  self.rain_pos.x = self.rain_pos.x - dt * 599 * 0.2
  self.rain_pos.y = self.rain_pos.y + dt * 336 * 0.7

  if self.rain_pos.x < -1599 then
    self.rain_pos.x = -1000
  end

  if self.rain_pos.y > 0 then
    self.rain_pos.y = -1000
  end
end


function title:draw()
  local setColor = love.graphics.setColor

  love.graphics.scale(self.scale_factor)

  setColor(255, 255, 255)
  love.graphics.draw(self.current_bg)

  setColor(255, 255, 255, 120)
  love.graphics.draw(
    self.gfx.rain, self.gfx.rain_quad,
    self.rain_pos.x, self.rain_pos.y
  )

  setColor(255, 255, 255)
  love.graphics.draw(self.gfx.fg)
end

function title:keypressed(key)
  GameState.switch(game)
end

return title
