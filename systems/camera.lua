local class = require "vendor.30log"
local tiny = require "vendor.tiny"

local CameraSystem = tiny.system(class "CameraSystem")

function CameraSystem:init(camera, target)
    self.camera = camera
    self.target = target
end

function CameraSystem:update(dt)
    local pos = self.target.pos
    self.camera:setPosition(pos.x, pos.y)
end

return CameraSystem