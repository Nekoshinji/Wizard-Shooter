-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, 'lldebugger') then
  require('lldebugger').start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

SCREEN_SIZE = {width = 800, height = 600}

local wizard = require('wizard')
local magicCircle = require('magicCircle')

function love.load()
end

function love.update(dt)
  wizard.update(dt)
  magicCircle.update(dt)
end

function love.draw()
  wizard.draw()
  magicCircle.draw()
end

function love.keypressed(key)
end
