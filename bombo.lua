local wizard = require('wizard')
local fireBall = require('fireBall')

-- -- Function to calculate the distance between two points

local bombo = {}
bombo.img = love.graphics.newImage('assets/images/enemy/Bombo/bomb1b.png')
bombo.positionX = 400
bombo.positionY = 0
bombo.direction = 0
bombo.angle = math.random(0, 2 * math.pi)
bombo.angleAim = 0
bombo.positionAim = {x = SCREEN_SIZE.width * .5, y = SCREEN_SIZE.height * .5}
bombo.speed = 50
bombo.patrolSpeed = bombo.speed * .5
bombo.target = nil
bombo.patrolTimer = math.random(1, 4)
bombo.distance = 50
bombo.visionRange = 200
bombo.shootRange = 100
bombo.health = 70
bombo.damage = 10
bombo.shootTimer = 0
bombo.shootCooldown = math.random(1, 2)

bombo.free = false
bombo.state = 'patrol'

local offset = {x = bombo.img:getWidth() * .5, y = bombo.img:getHeight() * .5}

function distance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

function bombo.update(dt)
    if bombo.state == 'patrol' then
        bombo.patrol(dt)
        if distance(bombo.positionX, bombo.positionY, wizard.position.x, wizard.position.y) < bombo.visionRange then
            bombo.state = 'chase'
        end
    elseif bombo.state == 'chase' then
        bombo.chase(dt)
        if distance(bombo.positionX, bombo.positionY, wizard.position.x, wizard.position.y) > bombo.visionRange then
            bombo.state = 'patrol'
        end
    end

    bombo.aim()
    bombo.limitScreen()
end

function bombo.limitScreen()
    bombo.positionX = math.max(0, math.min(SCREEN_SIZE.width, bombo.positionX))
    bombo.positionY = math.max(0, math.min(SCREEN_SIZE.height, bombo.positionY))
end

function bombo.move(dt)
    local dx = wizard.position.x - bombo.positionX
    local dy = wizard.position.y - bombo.positionY
    bombo.positionX = bombo.positionX + math.cos(bombo.angle) * bombo.speed * dt
    bombo.positionY = bombo.positionY + math.sin(bombo.angle) * bombo.speed * dt
end

function bombo.patrol(dt)
    bombo.patrolTimer = bombo.patrolTimer - dt
    if bombo.patrolTimer <= 0 then
        bombo.angle = math.random(0, 2 * math.pi)
        bombo.patrolTimer = math.random(1, 2)
    end
    bombo.move(dt, bombo.patrolSpeed)
end

function bombo.aim()
    if wizard and wizard.position then
        local dx = wizard.position.x - bombo.positionX
        local dy = wizard.position.y - bombo.positionY
        bombo.angleAim = math.atan2(dy, dx)
        bombo.positionAim.x = math.cos(bombo.angleAim) * bombo.distance + bombo.positionX
        bombo.positionAim.y = math.sin(bombo.angleAim) * bombo.distance + bombo.positionY
    end
end

function bombo.chase(dt)
    if wizard and wizard.position then
        local dx = wizard.position.x - bombo.positionX
        local dy = wizard.position.y - bombo.positionY
        bombo.angle = math.atan2(dy, dx)
        bombo.move(dt)
    end
end

function bombo.fireBall()
    local dx = math.cos(bombo.angleAim)
    local dy = math.sin(bombo.angleAim)
    local fireB = newFireBall(bombo.positionAim.x, bombo.positionAim.y, dx, dy)
    return fireB
end

function bombo.draw()
    love.graphics.draw(bombo.img, bombo.positionX, bombo.positionY, 0, .5, .5, offset.x, offset.y)
    love.graphics.circle('line', bombo.positionX, bombo.positionY, bombo.distance)
    love.graphics.circle('fill', bombo.positionAim.x, bombo.positionAim.y, 10)
end

return bombo
