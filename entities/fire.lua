local class = require "vendor.30log"
local assets = require "assets"
local colors = require "colors"
local util = require "util"
local const = require "const"

local Fire = class "Fire"

function Fire:init(x, y, state)
    self.sprite = assets.makeFireFull()
    self.pos = { x = x, y = y }

    self.fuel = const.fire.fuel
    self.gamestate = state
end

function Fire:changeFuel(dfuel)
    if self.fuel > 0 then
        self.fuel = util.clamp(self.fuel + dfuel, 0, const.fire.fuel)
    else
        self.gamestate.eaten = true
    end
    return self.fuel
end

function Fire:getDrawOrder()
    return self.pos.y
end

function Fire:draw(left, top, width, height)
    self.sprite:draw(self.pos.x, self.pos.y)
end

return Fire