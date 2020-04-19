local class = require "vendor.30log"
local tiny = require "vendor.tiny"
local util = require "util"
local const = require "const"

local PhysicsSystem = tiny.processingSystem(class "PhysicsSystem")

PhysicsSystem.filter = tiny.requireAll("pos", "vel", "acc", "posTarget", "velTarget")

function apply(cur, N, tgt)
    if (tgt == nil) then -- no target - no cry
        return cur + N
    end

    local T = tgt - cur
    
    if N == 0 or T == 0 then -- change is 0 or destination reached
        return cur
    end
    
    local n = math.abs(N)
    local t = math.abs(T)
    local dN = N / n
    local dT = T / t
   
    if (dT == dN) then -- choose minimal if same direction
        return cur + dN * math.min(n, t)
    else
        return cur + N
    end
end

local nan = 0/0

function PhysicsSystem:process(e, dt)
    if e.skipPhys then
        return
    end

    local pos, vel, acc, posT, velT = e.pos, e.vel, e.acc, e.posTarget, e.velTarget

    pos.x, pos.y = apply(pos.x, vel.x * dt, posT.x), apply(pos.y, vel.y * dt, posT.y)
    vel.x, vel.y = apply(vel.x, acc.x * dt, velT.x), apply(vel.y, acc.y * dt, velT.y)

    if e.tracePhys then
        print(
            string.format(
                "px=%.2f py=%.2f / ptx=%.2f pty=%.2f / vx=%.2f vy=%.2f / vtx=%.2f vty=%.2f / ax=%.2f ay=%.2f",
                pos.x, pos.y,
                posT.x or nan, posT.y or nan,
                vel.x, vel.y,
                velT.x or nan, velT.y or nan,
                acc.x, acc.y
            )
        )
    end

    if e.skipPhysOnPosTarget then
        e.skipPhys = (posT.x == nil or posT.x == pos.x) and (posT.y == nil or posT.y == pos.y)
    end

    pos.x = util.clamp(pos.x, 5, const.world.width - 5)
    pos.y = util.clamp(pos.y, 5, const.world.height - 5)
end

return PhysicsSystem