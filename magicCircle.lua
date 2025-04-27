local wizard = require('wizard')

local magicCircle = {}
magicCircle.img = love.graphics.newImage('assets/images/Big Circle.png')
magicCircle.position = {x = SCREEN_SIZE.width * .5, y = SCREEN_SIZE.height * .5}
magicCircle.angle = 0
magicCircle.distance = 50
offset = {x = magicCircle.img:getWidth() * .5, y = magicCircle.img:getHeight() * .5}

function magicCircle.update(dt)
    magicCircle.aim()
end

function magicCircle.aim()
    local mouseX,
        mouseY = love.mouse.getPosition()
    local dx = mouseX - wizard.position.x
    local dy = mouseY - wizard.position.y
    magicCircle.angle = math.atan2(dy, dx)
    magicCircle.position.x = math.cos(magicCircle.angle) * magicCircle.distance + wizard.position.x
    magicCircle.position.y = math.sin(magicCircle.angle) * magicCircle.distance + wizard.position.y
end

function magicCircle.draw()
    love.graphics.draw(
        magicCircle.img,
        magicCircle.position.x,
        magicCircle.position.y,
        magicCircle.angle,
        1,
        1,
        offset.x,
        offset.y
    )
end

function magicCircle.fireBall()
    local dx = math.cos(magicCircle.angle)
    local dy = math.sin(magicCircle.angle)
    local fireB = newFireBall(magicCircle.position.x, magicCircle.position.y, dx, dy)
    return fireB
end

return magicCircle
