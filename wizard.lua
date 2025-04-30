local wizard = {}
wizard.position = {x = SCREEN_SIZE.width * .5, y = SCREEN_SIZE.height * .5}
wizard.speed = 200
wizard.direction = 0
wizard.angle = 0
wizard.health = 100
wizard.attack = math.random(5, 15)
wizard.radius = 20

wizard.move = {}
wizard.currentMove = 1
table.insert(wizard.move, love.graphics.newImage('assets/images/Idle1.png'))
table.insert(wizard.move, love.graphics.newImage('assets/images/Idle2.png'))
table.insert(wizard.move, love.graphics.newImage('assets/images/Idle3.png'))
table.insert(wizard.move, love.graphics.newImage('assets/images/Idle4.png'))
table.insert(wizard.move, love.graphics.newImage('assets/images/Idle5.png'))
table.insert(wizard.move, love.graphics.newImage('assets/images/Idle6.png'))
table.insert(wizard.move, love.graphics.newImage('assets/images/Idle7.png'))
table.insert(wizard.move, love.graphics.newImage('assets/images/Idle8.png'))
table.insert(wizard.move, love.graphics.newImage('assets/images/Idle9.png'))
local offset = {
  x = wizard.move[wizard.currentMove]:getWidth() * .5,
  y = wizard.move[wizard.currentMove]:getHeight() * .5
}

function wizard.update(dt)
  if love.keyboard.isDown('d') then
    wizard.position.x = wizard.position.x + wizard.speed * dt
  elseif love.keyboard.isDown('q') then
    wizard.position.x = wizard.position.x - wizard.speed * dt
  elseif love.keyboard.isDown('s') then
    wizard.position.y = wizard.position.y + wizard.speed * dt
  elseif love.keyboard.isDown('z') then
    wizard.position.y = wizard.position.y - wizard.speed * dt
  end
end

function wizard.limitScreen()
  wizard.position.x = math.max(0, math.min(SCREEN_SIZE.width, wizard.position.x))
  wizard.position.y = math.max(0, math.min(SCREEN_SIZE.height, wizard.position.y))
end

function wizard.damage(bomboAttack)
  wizard.health = wizard.health - bomboAttack
  if wizard.health <= 0 then
    wizard.free = true
    wizard.state = 'dead'
    print('Wizard is dead')
  else
    print('Wizard health: ' .. wizard.health)
  end
end

function wizard.sprite(dt)
  wizard.currentMove = wizard.currentMove + 10 * dt
  if wizard.currentMove > #wizard.move then
    wizard.currentMove = 1
  end
end

function wizard.draw()
  love.graphics.draw(
    wizard.move[math.floor(wizard.currentMove)],
    wizard.position.x,
    wizard.position.y,
    wizard.angle,
    1.2,
    1.2,
    offset.x,
    offset.y
  )
  local lifeDiplay = 'Health Wizard: ' .. wizard.health
  love.graphics.setColor(1, 1, 1)
  love.graphics.printf(lifeDiplay, 0, 0, SCREEN_SIZE.width, 'left')
end

function wizard.getPosition()
  return wizard.position
end
return wizard
