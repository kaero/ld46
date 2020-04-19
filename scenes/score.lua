local class = require "vendor.30log"
local camera = require "camera"
local const = require "const"
local util = require "util"
local colors = require "colors"

local ScoreScene = class("ScoreScene")

function ScoreScene:init(scenes, GameScene, score)
    self.scenes = scenes
    self.cycle = 0
    self.tick = 0
    self.score = score
    self.GameScene = GameScene
end

function ScoreScene:enter()
    local x, y = camera:getPosition()
    self.cam = { x = x, y = y }
    camera:setPosition(0, 0)
end

function ScoreScene:leave()
    camera:setPosition(self.cam.x, self.cam.y)
end

function ScoreScene:draw()
    local scene = self
    camera:draw(function(left, top, width, height)
        local g = love.graphics;
        g.setColor(colors.menuTextFade)
        g.print("got eaten", 10, 10)
        g.setColor(colors.menuText)
        g.print("after "..self.score.."s", 40, 24)
        
        local flashGray = util.colorTranslate(scene.cycle, colors.menuTextFade, colors.menuText)
        g.setColor(flashGray)
        g.print("press space to play again", 10, 52)

        local flashRed = util.colorTranslate(scene.cycle, colors.menuTextHiFade, colors.menuTextHi)
        g.setColor(flashRed)
        g.print("press escape to exit", 10, 66)
    end)
end

function ScoreScene:update(dt)
    self.tick = self.tick + dt
    self.cycle = math.sin(self.tick *3)
end

function ScoreScene:keyreleased(key)
    if key == "space" then
        self.scenes:enter(self.GameScene:new(self.scenes))
    elseif key == "escape" then
        love.event.quit()
    end
end

return ScoreScene