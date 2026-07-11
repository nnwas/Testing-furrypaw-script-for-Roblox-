local Fluff = {}


function Fluff.Create(
	character,
	config
)

	if not config.FluffEnabled then
		return
	end



	local folder =
		Instance.new("Folder")

	folder.Name =
		"AnkleFluff"

	folder.Parent =
		character




	local parts = {

		"LeftFoot",

		"RightFoot",

		"Left Leg",

		"Right Leg"

	}



	for _,name in ipairs(parts) do


		local foot =
			character:FindFirstChild(
				name
			)


		if foot then


			for i = 1, 8 do


				local fluff =
					Instance.new(
						"Part"
					)


				fluff.Name =
					"FurChunk"


				fluff.Size =
					Vector3.new(
						0.15,
						0.15,
						0.15
					)


				fluff.Shape =
					Enum.PartType.Ball


				fluff.Material =
					Enum.Material.SmoothPlastic


				fluff.Color =
					Color3.fromRGB(
						230,
						230,
						230
					)


				fluff.CanCollide =
					false


				fluff.CanTouch =
					false


				fluff.Massless =
					true


				fluff.Position =
					foot.Position
					+
					Vector3.new(
						math.random(-3,3)/10,
						math.random(0,5)/10,
						math.random(-3,3)/10
					)


				fluff.Parent =
					folder


				local weld =
					Instance.new(
						"WeldConstraint"
					)


				weld.Part0 =
					fluff


				weld.Part1 =
					foot


				weld.Parent =
					fluff


			end

		end

	end


end


return Fluff