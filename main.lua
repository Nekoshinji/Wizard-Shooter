-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, 'lldebugger') then
    require('lldebugger').start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

SCREEN_SIZE = {width = 800, height = 600}
local newBombo = {}

local wizard = require('wizard')
local magicCircle = require('magicCircle')
local fireBall = require('fireBall')
local bombo = require('bombo')

local fireBalls = {}
fireBalls.sfx = nil

function love.load()
    fireBalls.sfx = love.audio.newSource('assets/sfx/fireball.ogg', 'static')
end

function love.update(dt)
    wizard.update(dt)
    wizard.sprite(dt)
    magicCircle.update(dt)
    bombo.update(dt)

    if bombo.state == 'chase' then
        bombo.shootTimer = bombo.shootTimer + dt
        if bombo.shootTimer >= bombo.shootCooldown then
            local fireB = bombo.fireBall()
            table.insert(fireBalls, fireB)
            bombo.shootTimer = 0
        end
    end

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
    bombo.draw()

    for _, fireBall in ipairs(fireBalls) do
        fireBall.draw()
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then
        local fireB = magicCircle.fireBall()
        table.insert(fireBalls, fireB)
    end

    if button == 1 then
        fireBalls.sfx:stop()
        fireBalls.sfx:play()
    end
end

function love.keypressed(key)
end
