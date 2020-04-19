local class = require "vendor.30log"
local tiny = require "vendor.tiny"
local util = require "util"
local const = require "const"
local colors = require "colors"

local FireSystem = tiny.system(class "FireSystem")

function FireSystem:init(character, input, inventory, fire, fuelbar)
    self.character = character
    self.input = input
    self.inventory = inventory
    self.fire = fire
    self.fuelbar = fuelbar
end

function FireSystem:update(dt)
    local fire = self.fire
    local inventory = self.inventory

    local dfuel = -dt

    local cpos = self.character.pos
    local fpos = self.fire.pos
    local branches = inventory:count()

    if util.distance(cpos.x, cpos.y, fpos.x, fpos.y) < const.fire.disposeDistance 
        and branches > 0
    then
        fire.sprite.color = colors.fireHi

        if self.input:pressed("action") then
            inventory:disposeFrom(self.world)
            dfuel = dfuel + const.fire.fuelInBranch * branches
        end
    else
        fire.sprite.color = colors.white
    end

    fire:changeFuel(dfuel)
end

return FireSystem