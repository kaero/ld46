local class = require "vendor.30log"
local camera = require "camera"
local const = require "const"
local util = require "util"
local colors = require "colors"

local PauseScene = class("PauseScene")

function PauseScene:init(scenes)
    self.scenes = scenes
    self.cycle = 0
    self.tick = 0
end

function PauseScene:enter()
    local x, y = camera:getPosition()
    self.cam = { x = x, y = y }
    camera:setPosition(0, 0)
end

function PauseScene:leave()
    camera:setPosition(self.cam.x, self.cam.y)
end

function PauseScene:draw()
    local scene = self
    camera:draw(function(left, top, width, height)
        local g = love.graphics;
        g.setColor(colors.menuTextFade)
        g.print("keep fire alive", 10, 10)
        g.setColor(colors.menuText)
        g.print("or get eaten", 40, 24)
        
        local flashGray = util.colorTranslate(scene.cycle, colors.menuTextFade, colors.menuText)
        g.setColor(flashGray)
        g.print("press space to resume", 10, 52)

        local flashRed = util.colorTranslate(scene.cycle, colors.menuTextHiFade, colors.menuTextHi)
        g.setColor(flashRed)
        g.print("press escape to exit", 10, 66)
    end)
end

function PauseScene:update(dt)
    self.tick = self.tick + dt
    self.cycle = math.sin(self.tick *3)
end

function PauseScene:keyreleased(key)
    if key == "space" then
        self.scenes:pop()
    elseif key == "escape" then
        love.event.quit()
    end
end

return PauseScene