local RunService =
	game:GetService(
		"RunService"
	)


local Sounds = {}



function Sounds.Start(
	character,
	config
)

	if not config.SoundsEnabled then
		return
	end



	local humanoid =
		character:WaitForChild(
			"Humanoid"
		)



	local root =
		character:WaitForChild(
			"HumanoidRootPart"
		)



	local sound =
		Instance.new(
			"Sound"
		)


	sound.Name =
		"PawStep"


	-- Replace with your own Roblox audio ID
	sound.SoundId =
		"rbxassetid://0"


	sound.Volume =
		config.StepVolume


	sound.Parent =
		root




	local cooldown = 0



	RunService.Heartbeat:Connect(
	function(dt)


		cooldown -= dt



		if humanoid.MoveDirection.Magnitude > 0
			and cooldown <= 0 then


			cooldown =
				0.4


			sound:Play()


		end


	end)


end



return Sounds