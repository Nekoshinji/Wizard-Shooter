local wizard = require('wizard')

local powerCircleImg = love.graphics.newImage('assets/images/Big Circle.png')
local fireBallPosition = {x = 0, y = 0}
local fireBallAngle = 0
local fireBallDistance = 50

local fireBall = {}

function fireBall.update(dt)
  local mouseX,
    mouseY = love.mouse.getPosition()
  local dx = mouseX - wizard.position.x
  local dy = mouseY - wizard.position.y

  fireBallAngle = math.atan2(dy, dx)
  fireBallPosition.x = math.cos(fireBallAngle) * fireBallDistance + wizard.position.x
  fireBallPosition.y = math.sin(fireBallAngle) * fireBallDistance + wizard.position.y
end

function fireBall.draw()
  love.graphics.draw(powerCircleImg, fireBallPosition.x, fireBallPosition.y, fireBallAngle, 1, 1)
end

return fireBall
