local class = require "vendor.30log"
local assets = require "assets"
local colors = require "colors"
local util = require "util"
local const = require "const"

local Darkness = class "Darkness"

function Darkness:init(fire)
    self.fire = fire
end

function Darkness:getDrawOrder()
    return 9000
end

function Darkness:draw(left, top, width, height)
    local alpha = util.translate(self.fire.fuel, 0, const.fire.fuel, 1, 0)
    love.graphics.setColor({ 0, 0, 0, alpha })
    love.graphics.rectangle("fill", left, top, width, height)
end

return Darkness