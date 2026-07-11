local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")


local PawPrints = {}


local function CreatePrint(parent)

	local print = Instance.new("Part")

	print.Name = "PawPrint"

	print.Size = Vector3.new(
		0.35,
		0.03,
		0.45
	)

	print.Shape = Enum.PartType.Ball

	print.Material = Enum.Material.SmoothPlastic

	print.Anchored = true

	print.CanCollide = false

	print.CanTouch = false

	print.CanQuery = false

	print.Transparency = 1

	print.Parent = parent


	return print

end



function PawPrints.Start(character, config)


	if not config.PrintsEnabled then
		return
	end



	local root =
		character:WaitForChild(
			"HumanoidRootPart"
		)


	local humanoid =
		character:WaitForChild(
			"Humanoid"
		)



	local folder =
		Instance.new("Folder")

	folder.Name =
		"PawPrintPool"

	folder.Parent =
		workspace



	local pool = {}



	-- Create print pool

	for i = 1, config.PrintPoolSize do

		table.insert(
			pool,
			CreatePrint(folder)
		)

	end



	local index = 1

	local timer = 0



	local function SpawnPrint()


		local print =
			pool[index]


		index += 1


		if index > #pool then

			index = 1

		end



		print.Position =
			root.Position
			+
			Vector3.new(
				math.random(-2,2)/10,
				-2.7,
				0.8
			)


		print.CFrame =
			CFrame.new(
				print.Position
			)
			*
			CFrame.Angles(
				math.rad(90),
				0,
				math.rad(
					math.random(
						-20,
						20
					)
				)
			)



		print.Transparency = 0.25



		local tween =
			TweenService:Create(
				print,
				TweenInfo.new(
					config.PrintLifetime
				),
				{
					Transparency = 1
				}
			)


		tween:Play()


	end




	RunService.Heartbeat:Connect(function(dt)


		if not character.Parent then
			return
		end



		if humanoid.MoveDirection.Magnitude > 0 then


			timer += dt



			if timer > 0.35 then

				timer = 0

				SpawnPrint()

			end


		else

			timer = 0

		end


	end)


end


return PawPrints