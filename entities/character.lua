local class = require "vendor.30log"
local assets = require "assets"
local colors = require "colors"
local const = require "const"

local Character = class "Character"

function Character:init(x, y)
    self.sprStanding = assets.makeCharStanding()
    self.sprWalking = assets.makeCharWalking()

    self.sprite = self.sprWalking

    self.pos = { x = x, y = y }
    self.vel = { x = 0, y = 0 }
    self.acc = { x = 0, y = 0 }
    self.posTarget = { x = 0, y = 0 }
    self.velTarget = { x = 0, y = 0 }

    self.cameraTarget = true
end

function Character:getDrawOrder()
    return self.pos.y
end

function Character:draw(left, top, width, height)
    self.sprite:draw(self.pos.x, self.pos.y)
end

return Character