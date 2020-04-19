local class = require "vendor.30log"
local assets = require "assets"
local colors = require "colors"

local Wolf = class "Wolf"

function Wolf:init(x, y)
    self.sprStanding = assets.makeWolfStanding()
    self.sprWalking = assets.makeWolfWalking()

    self.sprite = self.sprWalking
    self.pos = { x = x, y = y }
    self.vel = { x = 0, y = 0 }
    self.acc = { x = 0, y = 0 }
    self.posTarget = { x = 0, y = 0 }
    self.velTarget = { x = 0, y = 0 }

    self.enemy = true
end

function Wolf:getDrawOrder()
    return self.pos.y
end

function Wolf:draw(left, top, width, height)
    self.sprite:draw(self.pos.x, self.pos.y)
end

return Wolf