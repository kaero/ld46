local class = require "vendor.30log"
local colors = require "colors"

local Background = class "Background"

function Background:getDrawOrder()
    return -1
end

function Background:draw(left, top, width, height)
    local g = love.graphics
    g.setColor(colors.grass)
    g.rectangle("fill", left, top, width, height)
end

return Background