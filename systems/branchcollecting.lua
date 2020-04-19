local class = require "vendor.30log"
local tiny = require "vendor.tiny"
local const = require "const"
local util = require "util"
local colors = require "colors"

local BranchCollectingSystem = tiny.processingSystem(class "BranchCollectingSystem")

BranchCollectingSystem.filter = tiny.requireAll("branch", "sprite")

function BranchCollectingSystem:init(character, input, inventory)
    self.character = character
    self.input = input
    self.inventory = inventory
end

function BranchCollectingSystem:preProcess()
    self.action = self.input:pressed("action")
end

function BranchCollectingSystem:process(e, dt)
    if e.branch.carry then
        return
    end

    local char = self.character

    if util.distance(e.pos.x, e.pos.y, char.pos.x, char.pos.y) < 10 then
        e.sprite.color = colors.branchHi

        if self.action then
            e.branch.carry = self.inventory:add(e)
            self.action = not e.branch.carry 
        end
    else
        e.sprite.color = colors.white
    end
end

return BranchCollectingSystem