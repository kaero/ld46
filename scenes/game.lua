local class = require "vendor.30log"
local tiny = require "vendor.tiny"
local camera = require "camera"
local const = require "const"
local util = require "util"
local input = require "input"
local assets = require "assets"
local PauseScene = require "scenes.pause"
local ScoreScene = require "scenes.score"
local Character = require "entities.character"
local Background = require "entities.background"
local Fire = require "entities.fire"
local Tree = require "entities.tree"
local Wolf = require "entities.wolf"
local Inventory = require "entities.inventory"
local FuelBar = require "entities.fuelbar"
local Darkness = require "entities.darkness"
local DrawingSystem = require "systems.drawing"
local SpriteSystem = require "systems.sprite"
local CharactedControlSystem = require "systems.charactercontrol"
local PhysicsSystem = require "systems.physics" 
local CameraSystem = require "systems.camera" 
local BranchSpawningSystem = require "systems.branchspawning"
local BranchCollectingSystem = require "systems.branchcollecting"
local FireSystem = require "systems.fire"

local GameScene = class("GameScene")

function GameScene:init(scenes)
    local worldWidth = const.world.width
    local worldHeight = const.world.height
    local center = {
        x = worldWidth / 2,
        y = worldHeight / 2,
    }
    camera:setWorld(0, 0, worldWidth, worldHeight)
    camera:setPosition(center.x, center.y)

    self.scenes = scenes
    self.time = 0
    self.state = { eaten = false }

    self.music = assets.musicPartA
    self.music:setLooping(true)
    self.music:stop()

    local character = Character:new(center.x + 20, center.y)
    local inventory = Inventory:new(const.view.width - 32, 12)
    local fire = Fire:new(center.x, center.y, self.state)
    local fuelbar = FuelBar:new(30, 12, fire)
    
    self.drawingSystem = DrawingSystem:new()
    self.world = tiny.world(
        self.drawingSystem,
        SpriteSystem:new(),
        CharactedControlSystem:new(character, input),
        CameraSystem:new(camera, character),
        BranchSpawningSystem:new(),
        PhysicsSystem:new(),
        BranchCollectingSystem:new(character, input, inventory),
        FireSystem:new(character, input, inventory, fire, fuelbar),
        Background:new(),
        Darkness:new(fire),
        character,
        inventory,
        fire,
        fuelbar
    )

    util.generate(self.world, Tree, const.trees.count, const.trees.distance, const.trees.centerDistance)
    util.generate(self.world, Wolf, const.wolfs.count, const.wolfs.distance, const.wolfs.centerDistance)
end

function GameScene:enter()
    self.music:play()
end

function GameScene:leave()
    self.music:pause()
end

function GameScene:draw()
    camera:draw(function(left, top, width, height)
        self.drawingSystem:draw(left, top, width, height)
    end)
end

function GameScene:update(dt)
    input:update()
    self.time = self.time + dt
    self.world:update(dt)
    if self.state.eaten then
        self.scenes:enter(ScoreScene:new(self.scenes, GameScene, math.ceil(self.time)))
    end
end

function GameScene:keyreleased(key)
    if key == "escape" then
        self.scenes:push(PauseScene:new(self.scenes))
    end
end

return GameScene