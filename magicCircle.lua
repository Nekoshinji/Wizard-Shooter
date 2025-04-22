local wizard = require('wizard')

local magicCircleImg = love.graphics.newImage('assets/images/Big Circle.png')
local magicCirclePosition = {x = 0, y = 0}
local magicCircleAngle = 0
local magicCircleDistance = 50

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
  love.graphics.draw(magicCircleImg, magicCirclePosition.x, magicCirclePosition.y, magicCircleAngle, 1, 1)
end

return magicCircle
