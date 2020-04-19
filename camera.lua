local gamera = require "vendor.gamera"
local editgrid = require "vendor.editgrid"
local const = require "const"
local util = require "util"

local w, h = love.graphics.getDimensions()
local scale = math.max(w / const.view.width, h / const.view.height)
local camera = gamera.new(0, 0, const.view.width, const.view.height)
camera:setScale(math.ceil(scale))

camera.showGrid = false
function camera:switchGrid()
    self.showGrid = not self.showGrid
end

local draw = camera.draw
function camera:draw(fn)
    draw(self, fn)

    if self.showGrid then
        editgrid.draw(camera)
    end
end

return camera