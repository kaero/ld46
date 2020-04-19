local class = require "vendor.30log"
local assets = require "assets"
local const = require "const"
local colors = require "colors"
local util = require "util"

local FuelBar = class "FuelBar"

function FuelBar:init(x, y, fire)
    self.sprFuelFire = assets.makeFuelFire()
    self.sprFuelBar = assets.makeFuelBar()
    self.drawOrder = 10000
    self.overlay = true

    self.pos = { x = x, y = y }
    self.vel = { x = 0, y = 0 }
    self.acc = { x = 0, y = 0 }
    self.posTarget = { x = 0, y = 0 }
    self.velTarget = { x = 0, y = 0 }

    self.fire = fire
end

function FuelBar:getDrawOrder()
    return self.drawOrder
end

function FuelBar:draw(left, top, width, height)
    local fireOffsetX = util.translate(self.fire.fuel, 0, const.fire.fuel, 0, 50) - 24
    self.sprFuelBar:draw(self.pos.x + left, self.pos.y + top)
    self.sprFuelFire:draw(self.pos.x + left + fireOffsetX, self.pos.y + top)
end

return FuelBar