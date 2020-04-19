local class = require "vendor.30log"
local assets = require "assets"
local colors = require "colors"

local Branch = class "Branch"

function Branch:init(x, y)
    self.sprite = assets.makeBranch()

    self.pos = { x = x, y = y }
    self.vel = { x = 0, y = 0 }
    self.acc = { x = 0, y = 0 }
    self.posTarget = { x = nil, y = nil }
    self.velTarget = { x = nil, y = nil }

    self.drawOrder = 0
    self.overlay = false

    self.branch = {
        carry = false,
    }
end

function Branch:getDrawOrder()
    if self.overlay then
        return self.drawOrder
    else
        return self.pos.y
    end
end

function Branch:draw(left, top, width, height)
    x, y = self.pos.x, self.pos.y
    if self.overlay then
        x, y = x + left, y + top
    end
    self.sprite:draw(x, y)
end

return Branch