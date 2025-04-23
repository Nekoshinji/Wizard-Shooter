-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, 'lldebugger') then
  require('lldebugger').start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

SCREEN_SIZE = {width = 800, height = 600}

local wizard = require('wizard')
local magicCircle = require('magicCircle')
local fireBall = require('fireBall')

local fireBalls = {}

function love.load()
end

function love.update(dt)
  wizard.update(dt)
  wizard.sprite(dt)
  magicCircle.update(dt)

  for _, fireBall in ipairs(fireBalls) do
    fireBall.update(dt)
    fireBall.sprite(dt)
  end

  for index = #fireBalls, 1, -1 do
    if fireBalls[index].free then
      table.remove(fireBalls, index)
    end
  end
end

function love.draw()
  wizard.draw()
  magicCircle.draw()

  for _, fireBall in ipairs(fireBalls) do
    fireBall.draw()
  end
end

function love.mousepressed(x, y, button)
  if button == 1 then
    local fireB = magicCircle.fireBall()
    print()
    table.insert(fireBalls, fireB)
  end

  function love.keypressed(key)
  end
end
