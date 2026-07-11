local Glow = {}


function Glow.Enable(paws, config)

	if not config.GlowEnabled then
		return
	end


	for _,data in pairs(paws) do

		if data and data.Pad then


			local light =
				Instance.new(
					"PointLight"
				)


			light.Name =
				"PawGlow"


			light.Color =
				data.Pad.Color


			light.Brightness =
				config.GlowStrength


			light.Range =
				6


			light.Parent =
				data.Pad


		end

	end

end



function Glow.SetStrength(
	paws,
	value
)

	for _,data in pairs(paws) do

		if data and data.Pad then

			local light =
				data.Pad:FindFirstChild(
					"PawGlow"
				)


			if light then

				light.Brightness =
					value

			end

		end

	end

end


return Glow