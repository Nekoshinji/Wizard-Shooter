-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, 'lldebugger') then
  require('lldebugger').start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

SCREEN_SIZE = {width = 1024, height = 768}
local background = love.graphics.newImage('assets/images/Purple_Nebula_06-512x512.png')
local wizard = require('wizard')
local magicCircle = require('magicCircle')
local fireBall = require('fireBall')
local bombo = require('bombo')
local currentScene = 'menu'

local bombos = {}
local fireBalls = {}

fireBalls.sfx = nil
local backgroundMusic = nil

function love.load()
  love.window.setMode(SCREEN_SIZE.width, SCREEN_SIZE.height)
  backgroundMusic = love.audio.newSource('assets/sfx/Musique-libre-de-droits-Ultrasyd-Who-Cares.ogg', 'stream')
  backgroundMusic:setLooping(true)
  backgroundMusic:setVolume(0.2)
  backgroundMusic:play()

  fireBalls.sfx = love.audio.newSource('assets/sfx/fireball.ogg', 'static')
  for i = 1, 15 do
    local x,
      y = getRandomPosition()
    local newBombo = bombo()
    newBombo.positionX = x
    newBombo.positionY = y
    table.insert(bombos, newBombo)
  end
end
function getRandomPosition()
  local x = math.random(0, SCREEN_SIZE.width)
  local y = math.random(0, SCREEN_SIZE.height)
  return x, y
end

function love.update(dt)
  if currentScene == 'menu' then
  elseif currentScene == 'game' then
    if wizard.health <= 0 then
      currentScene = 'gameOver'
      backgroundMusic:stop()
      wizard.health = 100
      wizard.position.x = SCREEN_SIZE.width / 2
      wizard.position.y = SCREEN_SIZE.height / 2
    elseif #bombos == 0 then
      currentScene = 'wins'
      backgroundMusic:stop()
      wizard.health = 100
      wizard.position.x = SCREEN_SIZE.width / 2
      wizard.position.y = SCREEN_SIZE.height / 2
    end
  end

  updateGame(dt)
  collision()

  for _, bombo in ipairs(bombos) do
    if bombo.state == 'chase' then
      bombo.shootTimer = bombo.shootTimer + dt
      if bombo.shootTimer >= bombo.shootCooldown then
        local fireB = bombo.fireBall()
        table.insert(fireBalls, fireB)
        bombo.shootTimer = 0
      end
    end
  end

  for index = #fireBalls, 1, -1 do
    if fireBalls[index].free then
      table.remove(fireBalls, index)
      print(index)
    end
  end

  for index = #bombos, 1, -1 do
    if bombos[index].free then
      table.remove(bombos, index)
    end
  end
end

function collision()
  for _, fireBall in ipairs(fireBalls) do
    for _, bombo in ipairs(bombos) do
      if
        fireBall.source ~= 'bombo' and
          checkCollision(bombo.positionX, bombo.positionY, bombo.radius, fireBall.pX, fireBall.pY, fireBall.radius)
       then
        fireBall.free = true
        bombo.damage(wizard.attack, 'wizard')
      end
    end
  end
  for _, fireBall in ipairs(fireBalls) do
    if checkCollision(wizard.position.x, wizard.position.y, wizard.radius, fireBall.pX, fireBall.pY, fireBall.radius) then
      fireBall.free = true
      wizard.damage(bombo().attack)
    end
  end
end

function checkCollision(x1, y1, r1, x2, y2, r2)
  local dx = x1 - x2
  local dy = y1 - y2
  local distance = math.sqrt(dx * dx + dy * dy)
  return distance < (r1 + r2)
end

function updateGame(dt)
  if currentScene == 'menu' then
  elseif currentScene == 'game' then
    wizard.update(dt)
    wizard.sprite(dt)
    wizard.limitScreen()
    magicCircle.update(dt)

    for _, fireBall in ipairs(fireBalls) do
      fireBall.update(dt)
      fireBall.sprite(dt)
    end

    for _, bombo in ipairs(bombos) do
      bombo.update(dt)
    end
  end
end

function love.draw()
  if currentScene == 'menu' then
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf('Press SPACE BAR to Start', 0, SCREEN_SIZE.height / 2, SCREEN_SIZE.width, 'center')
  elseif currentScene == 'game' then
    love.graphics.draw(
      background,
      0,
      0,
      0,
      SCREEN_SIZE.width / background:getWidth(),
      SCREEN_SIZE.height / background:getHeight()
    )
    wizard.draw()
    magicCircle.draw()

    for _, fireBall in ipairs(fireBalls) do
      fireBall.draw()
    end

    for _, bombo in ipairs(bombos) do
      bombo.draw()
    end
  elseif currentScene == 'wins' then
    love.graphics.setColor(0, 1, 0)
    love.graphics.printf('You Win!', 0, SCREEN_SIZE.height / 2 - 20, SCREEN_SIZE.width, 'center')
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf('Press SPACE BAR to Restart', 0, SCREEN_SIZE.height / 2 + 20, SCREEN_SIZE.width, 'center')
  elseif currentScene == 'gameOver' then
    love.graphics.setColor(1, 0, 0)
    love.graphics.printf('Game Over', 0, SCREEN_SIZE.height / 2 - 20, SCREEN_SIZE.width, 'center')
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf('Press SPACE BAR to Restart', 0, SCREEN_SIZE.height / 2 + 20, SCREEN_SIZE.width, 'center')
  end
end

function love.mousepressed(x, y, button)
  if currentScene == 'menu' then
  elseif currentScene == 'game' then
    if button == 1 then
      local fireB = magicCircle.fireBall()
      table.insert(fireBalls, fireB)
    end

    if button == 1 then
      fireBalls.sfx:stop()
      fireBalls.sfx:play()
    end
  end
end

function love.keypressed(key)
  if currentScene == 'menu' and key == 'space' then
    backgroundMusic:play()
    currentScene = 'game'
  elseif currentScene == 'gameOver' and key == 'space' then
    currentScene = 'menu'
    bombos = {}
    fireBalls = {}
    fireBalls.sfx = love.audio.newSource('assets/sfx/fireball.ogg', 'static')
    for i = 1, 15 do
      local x,
        y = getRandomPosition()
      local newBombo = bombo()
      newBombo.positionX = x
      newBombo.positionY = y
      table.insert(bombos, newBombo)
    end
  elseif currentScene == 'wins' and key == 'space' then
    currentScene = 'menu'
    bombos = {}
    fireBalls = {}
    fireBalls.sfx = love.audio.newSource('assets/sfx/fireball.ogg', 'static')
    for i = 1, 15 do
      local x,
        y = getRandomPosition()
      local newBombo = bombo()
      newBombo.positionX = x
      newBombo.positionY = y
      table.insert(bombos, newBombo)
    end
  end
end
