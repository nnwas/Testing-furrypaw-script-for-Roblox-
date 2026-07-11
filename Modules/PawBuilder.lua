local PawBuilder = {}


local function CreatePart(name, size, color, parent)

	local part = Instance.new("Part")

	part.Name = name
	part.Size = size
	part.Color = color

	part.Material = Enum.Material.SmoothPlastic

	part.CanCollide = false
	part.CanTouch = false
	part.CanQuery = false

	part.Massless = true

	part.Shape = Enum.PartType.Ball

	part.Parent = parent

	return part
end



local function Weld(part, target)

	local weld = Instance.new("WeldConstraint")

	weld.Part0 = part
	weld.Part1 = target

	weld.Parent = part

end



local function CreateClaw(parent, position, config)

	local claw = CreatePart(
		"Claw",
		Vector3.new(
			0.08,
			0.18,
			config.ClawLength
		),
		config.ClawColor,
		parent
	)


	claw.Shape = Enum.PartType.Cylinder

	claw.CFrame =
		CFrame.new(position)
		*
		CFrame.Angles(
			math.rad(90),
			0,
			0
		)


	return claw

end



function PawBuilder.Create(character, config)


	local pawFolder = Instance.new("Folder")

	pawFolder.Name = "FurryPaws"

	pawFolder.Parent = character



	local feet = {}


	-- Find feet
	local leftFoot =
		character:FindFirstChild(
			"LeftFoot"
		)
		or character:FindFirstChild(
			"Left Leg"
		)


	local rightFoot =
		character:FindFirstChild(
			"RightFoot"
		)
		or character:FindFirstChild(
			"Right Leg"
		)



	local function BuildFoot(
		foot,
		side
	)

		if not foot then
			return
		end


		local paw = CreatePart(
			side.."PawBase",
			Vector3.new(
				1.2,
				0.45,
				1.5
			),
			config.PawColor,
			pawFolder
		)

		-- Store original paw size
		paw:SetAttribute("OriginalSize", paw.Size)

		paw.CFrame =
			foot.CFrame
			*
			CFrame.new(
				0,
				-0.35,
				-0.2
			)


		Weld(
			paw,
			foot
		)



		local beans = {}


		local beanPositions = {

			Vector3.new(
				-0.35,
				0.05,
				-0.65
			),

			Vector3.new(
				-0.12,
				0.05,
				-0.72
			),

			Vector3.new(
				0.12,
				0.05,
				-0.72
			),

			Vector3.new(
				0.35,
				0.05,
				-0.65
			),

		}



		if config.FiveToeMode then

			table.insert(
				beanPositions,
				Vector3.new(
					0,
					0.05,
					-0.82
				)
			)

		end



		for index,pos in ipairs(beanPositions) do


			local bean =
				CreatePart(
					"ToeBean_"..index,
					Vector3.new(
						0.28,
						0.18,
						0.28
					),
					config.PadColor,
					pawFolder
				)

			-- Store original bean size
			bean:SetAttribute("OriginalSize", bean.Size)

			bean.CFrame =
				paw.CFrame
				*
				CFrame.new(
					pos
				)


			Weld(
				bean,
				paw
			)


			table.insert(
				beans,
				bean
			)



			local claw =
				CreateClaw(
					pawFolder,
					bean.Position
					+
					Vector3.new(
						0,
						-0.12,
						-0.12
					),
					config
				)


			Weld(
				claw,
				bean
			)


		end



		-- Main paw pad

		local pad =
			CreatePart(
				"MainPad",
				Vector3.new(
					0.5,
					0.15,
					0.6
				),
				config.PadColor,
				pawFolder
			)

		-- Store original pad size
		pad:SetAttribute("OriginalSize", pad.Size)

		pad.CFrame =
			paw.CFrame
			*
			CFrame.new(
				0,
				-0.2,
				0.35
			)


		Weld(
			pad,
			paw
		)



		return {

			Paw = paw,

			Beans = beans,

			Pad = pad

		}

	end



	feet.Left =
		BuildFoot(
			leftFoot,
			"Left"
		)


	feet.Right =
		BuildFoot(
			rightFoot,
			"Right"
		)



	return feet

end



return PawBuilder