--// Furry Paws FE Client System
--// Part 1: Loader
--// Local visual effects only

local Players = game:GetService("Players")

local Player = Players.LocalPlayer

repeat
	task.wait()
until Player.Character

local Character = Player.Character or Player.CharacterAdded:Wait()

local Root = Character:WaitForChild("HumanoidRootPart")

-- Folder for all client paw objects
local PawFolder = Instance.new("Folder")
PawFolder.Name = "ClientFurryPaws"
PawFolder.Parent = Character


-- Load modules
local Modules = script:WaitForChild("Modules")

local Config = require(Modules.Config)
local PawBuilder = require(Modules.PawBuilder)
local PawAnimator = require(Modules.PawAnimator)
local PawPrints = require(Modules.PawPrints)
local Menu = require(Modules.Menu)


-- Create paws
local Paws = PawBuilder.Create(Character, Config)


-- Start animation system
PawAnimator.Start(
	Character,
	Paws,
	Config
)


-- Start paw prints
PawPrints.Start(
	Character,
	Config
)


-- Open menu
Menu.Create(
	Config,
	Paws
)


print("🐾 Furry Paw System Loaded")