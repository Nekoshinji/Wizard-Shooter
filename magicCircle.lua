local wizard = require('wizard')
local fireBall = require('fireBall')

local magicCircleImg = love.graphics.newImage('assets/images/Big Circle.png')
local magicCirclePosition = {x = SCREEN_SIZE.width * .5, y = SCREEN_SIZE.height * .5}
local magicCircleAngle = 0
local magicCircleDistance = 50
local offset = {x = magicCircleImg:getWidth() * .5, y = magicCircleImg:getHeight() * .5}

local magicCircle = {}

function magicCircle.update(dt)
  local mouseX,
    mouseY = love.mouse.getPosition()
  local dx = mouseX - wizard.position.x
  local dy = mouseY - wizard.position.y
  magicCircleAngle = math.atan2(dy, dx)
  magicCirclePosition.x = math.cos(magicCircleAngle) * magicCircleDistance + wizard.position.x
  magicCirclePosition.y = math.sin(magicCircleAngle) * magicCircleDistance + wizard.position.y
end

function magicCircle.draw()
  love.graphics.draw(
    magicCircleImg,
    magicCirclePosition.x,
    magicCirclePosition.y,
    magicCircleAngle,
    1,
    1,
    offset.x,
    offset.y
  )
end

function magicCircle.fireBall()
  local dx = math.cos(magicCircleAngle)
  local dy = math.sin(magicCircleAngle)
  local fireB = newFireBall(magicCirclePosition.x, magicCirclePosition.y, dx, dy)
  return fireB
end

return magicCircle
