function newFireBall(pX, pY, dX, dY, speed)
  local fireBall = {}
  fireBall.pX = pX
  fireBall.pY = pY
  fireBall.dX = dX
  fireBall.dY = dY
  fireBall.speed = speed or 300
  fireBall.radius = 10
  fireBall.attack = 0

  fireBall.free = false

  fireBall.move = {}
  fireBall.currentMove = 1
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_0.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_1.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_2.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_3.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_4.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_5.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_6.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_7.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_8.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_9.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_10.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_11.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_12.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_13.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_14.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_15.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_16.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_17.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_18.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_19.png'))
  table.insert(fireBall.move, love.graphics.newImage('assets/images/fireBall/img_20.png'))

  local offset = {
    x = fireBall.move[fireBall.currentMove]:getWidth() * .5,
    y = fireBall.move[fireBall.currentMove]:getHeight() * .5
  }

  function fireBall.update(dt)
    fireBall.pX = fireBall.pX + fireBall.dX * fireBall.speed * dt
    fireBall.pY = fireBall.pY + fireBall.dY * fireBall.speed * dt
    fireBall.destroyOutScreen()
  end

  function fireBall.destroyOutScreen()
    if fireBall.pX < 0 or fireBall.pX > SCREEN_SIZE.width or fireBall.pY < 0 or fireBall.pY > SCREEN_SIZE.height then
      fireBall.free = true
    end
  end

  function fireBall.sprite(dt)
    fireBall.currentMove = fireBall.currentMove + 30 * dt
    if fireBall.currentMove > #fireBall.move then
      fireBall.currentMove = 1
    end
  end

  function fireBall.draw()
    local angle = math.atan2(fireBall.dY, fireBall.dX)
    love.graphics.draw(
      fireBall.move[math.floor(fireBall.currentMove)],
      fireBall.pX,
      fireBall.pY,
      angle,
      1,
      1,
      offset.x,
      offset.y
    )
  end

  return fireBall
end
