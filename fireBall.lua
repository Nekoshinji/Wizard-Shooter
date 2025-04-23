function newFireBall(pX, pY, dX, dY, speed)
  local fireB = {}
  fireB.pX = pX
  fireB.pY = pY
  fireB.dX = dX
  fireB.dY = dY
  fireB.speed = speed or 300

  fireB.free = false

  fireB.move = {}
  fireB.CurrentMove = 1
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_0.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_1.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_2.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_3.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_4.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_5.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_6.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_7.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_8.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_9.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_10.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_11.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_12.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_13.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_14.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_15.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_16.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_17.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_18.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_19.png'))
  table.insert(fireB.move, love.graphics.newImage('assets/images/fireBall/img_20.png'))

  local offset = {x = fireB.move[fireB.CurrentMove]:getWidth() * .5, y = fireB.move[fireB.CurrentMove]:getHeight() * .5}

  function fireB.update(dt)
    fireB.pX = fireB.pX + fireB.dX * fireB.speed * dt
    fireB.pY = fireB.pY + fireB.dY * fireB.speed * dt
  end

  function fireB.sprite(dt)
    fireB.CurrentMove = fireB.CurrentMove + 30 * dt
    if fireB.CurrentMove > 21 then
      fireB.CurrentMove = 1
    end
  end

  function destroyOutScreen()
    if fireB.pX < 0 or fireB.pX > SCREEN_SIZE.width and fireB.pY < 0 or fireB.pY > SCREEN_SIZE.height then
      fireB.free = true
    end
  end

  function fireB.draw()
    local angle = math.atan2(fireB.dY, fireB.dX)
    love.graphics.draw(fireB.move[math.floor(fireB.CurrentMove)], fireB.pX, fireB.pY, angle, 1, 1, offset.x, offset.y)
  end

  return fireB
end
