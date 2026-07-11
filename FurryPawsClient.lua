--// Furry Paws FE Client System
--// Final Connector
--// Delta Executor Compatible

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

local Modules = script:WaitForChild("Modules")

local Config = require(Modules.Config)
local PawBuilder = require(Modules.PawBuilder)
local PawAnimator = require(Modules.PawAnimator)
local PawPrints = require(Modules.PawPrints)
local Menu = require(Modules.Menu)
local Glow = require(Modules.Glow)
local Fluff = require(Modules.Fluff)
local Sounds = require(Modules.Sounds)

local function LoadPaws()
	-- Create paws
	local paws = PawBuilder.Create(Character, Config)
	
	-- Animation
	PawAnimator.Start(Character, paws, Config)
	
	-- Paw prints
	PawPrints.Start(Character, Config)
	
	-- Glow
	Glow.Enable(paws, Config)
	
	-- Fur
	Fluff.Create(Character, Config)
	
	-- Sounds
	Sounds.Start(Character, Config)
	
	-- Menu
	Menu.Create(Config, paws)
	
	print("🐾 Furry Paws FE Loaded Successfully!")
end

LoadPaws()

-- Reload after respawn
Player.CharacterAdded:Connect(function(char)
	task.wait(1)
	Character = char
	LoadPaws()
end)