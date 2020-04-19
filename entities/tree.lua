local class = require "vendor.30log"
local assets = require "assets"
local colors = require "colors"
local const = require "const"

local Tree = class "Tree"

function Tree:init(x, y)
    self.sprite = assets.makeTree()
    self.pos = { x = x, y = y }
    self.vel = { x = 0, y = 0 }
    self.tree = {
        cooldown = love.math.random(const.trees.cooldown - 1) + 1,
    }
end

function Tree:getDrawOrder()
    return self.pos.y
end

function Tree:draw(left, top, width, height)
    self.sprite:draw(self.pos.x, self.pos.y)
end

return Tree