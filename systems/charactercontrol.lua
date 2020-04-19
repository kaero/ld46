local class = require "vendor.30log"
local tiny = require "vendor.tiny"
local const = require "const"
local util = require "util"

local CharacterControlSystem = tiny.system(class "CharacterControlSystem")

function CharacterControlSystem:init(character, input)
    self.character = character
    self.input = input
end

function CharacterControlSystem:update(dt)
    vel, acc, velT = self.character.vel, self.character.acc, self.character.velTarget

    xc, yc = self.input:get("move") -- float in [ -1, 1 ]
    xs, ys = util.direction(xc), util.direction(yc) -- discrete { -1, 0, 1 }

    acc.x, acc.y = xc * const.char.acc, yc * const.char.acc
    vel.x, vel.y = math.abs(xs) * vel.x, math.abs(ys) * vel.y
    velT.x, velT.y = xs * const.char.velTarget, ys * const.char.velTarget
end

return CharacterControlSystem