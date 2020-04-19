local class = require "vendor.30log"
local assets = require "assets"
local const = require "const"
local colors = require "colors"

local Inventory = class "Inventory"

function Inventory:init(x, y)
    self.sprite = assets.makeInventory()
    self.drawOrder = 10000
    self.overlay = true

    self.pos = { x = x, y = y }
    self.vel = { x = 0, y = 0 }
    self.acc = { x = 0, y = 0 }
    self.posTarget = { x = 0, y = 0 }
    self.velTarget = { x = 0, y = 0 }

    self.bag = {}
end

function Inventory:getDrawOrder()
    return self.drawOrder
end

function Inventory:add(item)
    if #self.bag == const.inventory.size then
        return false
    end

    item.drawOrder = self.drawOrder + 1
    item.overlay = true
    item.sprite.color = colors.white
    item.pos.x = self.pos.x - 9 + 10 * (#self.bag - 1)
    item.pos.y = self.pos.y 
    item.skipPhys = true
    
    table.insert(self.bag, item)

    return true
end

function Inventory:count()
    return #self.bag
end

function Inventory:disposeFrom(world)
    for _, e in ipairs(self.bag) do
        world:removeEntity(e)
    end
    self.bag = {}
end

function Inventory:draw(left, top, width, height)
    self.sprite:draw(self.pos.x + left, self.pos.y + top)
end

return Inventory