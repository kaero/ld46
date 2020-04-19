local Sprite = require "sprite"

function makeFullRowOf(framesCount, row)
    return function(grid)
        return grid('1-' .. framesCount, row or 1)
    end
end

function makeSingle(col, row)
    return function(grid)
        return grid(col or 1, row or 1)
    end
end

love.graphics.setDefaultFilter("nearest", "nearest")

local newImage = love.graphics.newImage
local imgChar = newImage("assets/char.png")
local imgFire = newImage("assets/fire.png")
local imgWolf = newImage("assets/wolf.png")
local imgTree = newImage("assets/tree.png")
local imgBranches = {
    newImage("assets/branch_1.png"),
    newImage("assets/branch_2.png"),
    newImage("assets/branch_3.png"),
}
local imgInventory = newImage("assets/inventory.png")
local imgFuelFire = newImage("assets/fuelfire.png")
local imgFuelBar = newImage("assets/fuelbar.png")

return {
    makeCharWalking  = Sprite.maker(imgChar, 32, 32, 16, 27, makeFullRowOf(8), 1/16),
    makeCharStanding = Sprite.maker(imgChar, 32, 32, 16, 27, makeSingle()),
    makeWolfStanding = Sprite.maker(imgWolf, 32, 32, 16, 27, makeSingle()),
    makeWolfWalking  = Sprite.maker(imgWolf, 32, 32, 16, 27, makeSingle()),
    makeFireFull     = Sprite.maker(imgFire, 32, 32, 16, 24, makeFullRowOf(4), 1/10),
    makeTree         = Sprite.maker(imgTree, 64, 64, 32, 52, makeSingle()),
    makeBranch       = function() 
        local rnd = love.math.random(#imgBranches)
        local img = imgBranches[math.ceil(rnd)]
        return Sprite.from(img, 16, 16, 8, 8, makeSingle())
    end,
    makeInventory    = Sprite.maker(imgInventory, 64, 64, 32, 32, makeSingle()),
    makeFuelBar      = Sprite.maker(imgFuelBar, 64, 64, 32, 32, makeSingle()),
    makeFuelFire     = Sprite.maker(imgFuelFire, 16, 16, 8, 8, makeFullRowOf(3), 1/8),

    musicPartA = love.audio.newSource("assets/part_a.mp3", "static"),
    musicPartB = love.audio.newSource("assets/part_b.mp3", "static"),
}