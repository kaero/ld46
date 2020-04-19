local class = require "vendor.30log"
local camera = require "camera"
local util = require "util"
local colors = require "colors"
local const = require "const"
local GameScene = require "scenes.game"

local TitleScene = class("TitleScene")

function TitleScene:init(scenes)
    self.scenes = scenes
    self.cycle = 0
    self.tick = 0
    camera:setWorld(0, 0, const.view.width, const.view.height)
    camera:setPosition(0, 0)
end


function TitleScene:enter()
    local x, y = camera:getPosition()
    self.cam = { x = x, y = y }
    camera:setPosition(0, 0)
end

function TitleScene:leave()
    camera:setPosition(self.cam.x, self.cam.y)
end


function TitleScene:draw()
    local scene = self
    camera:draw(function(left, top, width, height)
        local g = love.graphics;
        g.setColor(colors.menuTextFade)
        g.print("keep fire alive", 10, 10)
        g.setColor(colors.menuText)
        g.print("or get eaten", 40, 24)
        
        local flashGray = util.colorTranslate(scene.cycle, colors.menuTextFade, colors.menuText)
        g.setColor(flashGray)
        g.print("press space to start", 10, 66)
    end)
end

function TitleScene:update(dt)
    self.tick = self.tick + dt
    self.cycle = math.sin(self.tick *3)
end

function TitleScene:keyreleased(key)
    if key == "space" then
        self.scenes:push(GameScene:new(self.scenes))
    elseif key == "escape" then
        love.event.quit()
    end
end

return TitleScene