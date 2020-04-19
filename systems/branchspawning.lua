local class = require "vendor.30log"
local tiny = require "vendor.tiny"
local const = require "const"
local Branch = require "entities.branch"

local BranchSpawningSystem = tiny.processingSystem(class "BranchSpawningSystem")

BranchSpawningSystem.filter = tiny.requireAll("tree")

function BranchSpawningSystem:process(e, dt)
    t = e.tree
    t.cooldown = math.max(0, t.cooldown - dt)
    
    if t.cooldown == 0 then
        t.cooldown = const.trees.cooldown

        local branch = Branch:new(e.pos.x, e.pos.y - 32)
        local xrnd = math.ceil(love.math.random(20)) - 10
        branch.vel = { x = xrnd, y = -20 }
        branch.acc = { x = 0, y = 50 }
        branch.posTarget = { x = e.pos.x + xrnd, y = e.pos.y + math.ceil(love.math.random(20)) - 10 }
        branch.skipPhysOnPosTarget = true
        self.world:add(branch)
    end
end

return BranchSpawningSystem