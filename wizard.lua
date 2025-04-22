local wizard = {}
wizard.move = {}
wizard.position = {x = SCREEN_SIZE.width * .5, y = SCREEN_SIZE.height * .5}
wizard.speed = 100
wizard.direction = 0
wizard.angle = 0
wizardCurrentMove = 1
table.insert(wizard.move, love.graphics.newImage('assets/images/Idle1.png'))
table.insert(wizard.move, love.graphics.newImage('assets/images/Idle2.png'))
table.insert(wizard.move, love.graphics.newImage('assets/images/Idle3.png'))
table.insert(wizard.move, love.graphics.newImage('assets/images/Idle4.png'))
table.insert(wizard.move, love.graphics.newImage('assets/images/Idle5.png'))
table.insert(wizard.move, love.graphics.newImage('assets/images/Idle6.png'))
table.insert(wizard.move, love.graphics.newImage('assets/images/Idle7.png'))
table.insert(wizard.move, love.graphics.newImage('assets/images/Idle8.png'))
table.insert(wizard.move, love.graphics.newImage('assets/images/Idle9.png'))
local offset = {x = wizard.move[wizardCurrentMove]:getWidth() * .5, y = wizard.move[wizardCurrentMove]:getHeight() * .5}

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
  -- if not (direction == 0) then
  --   local dx = math.cos(wizard.angle) * wizard.speed * wizard.direction * dt
  --   local dy = math.sin(wizard.angle) * wizard.speed * wizard.direction * dt
  --   wizard.position.x = wizard.position.x + dx
  --   wizard.position.y = wizard.position.y + dy
  -- end

  -- animation wizard
  wizardCurrentMove = wizardCurrentMove + 10 * dt
  if wizardCurrentMove > 9 then
    wizardCurrentMove = 1
  end
end

function wizard.draw()
  love.graphics.draw(
    wizard.move[math.floor(wizardCurrentMove)],
    wizard.position.x,
    wizard.position.y,
    wizard.angle,
    1,
    1,
    offset.x,
    offset.y
  )
end

return wizard
