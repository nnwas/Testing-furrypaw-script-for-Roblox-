local PawStyles = {}


PawStyles.Styles = {


	Wolf = {

		PawScale = Vector3.new(
			1.25,
			1,
			1.35
		),

		ToeScale = 1.2,

		ClawLength = 0.5,

		Squish = 0.22,

		PawColor =
			Color3.fromRGB(
				120,
				90,
				70
			),

		PadColor =
			Color3.fromRGB(
				90,
				45,
				40
			)

	},



	Fox = {

		PawScale = Vector3.new(
			1.05,
			0.9,
			1.15
		),

		ToeScale = 0.95,

		ClawLength = 0.35,

		Squish = 0.18,

		PawColor =
			Color3.fromRGB(
				220,
				120,
				40
			),

		PadColor =
			Color3.fromRGB(
				255,
				150,
				160
			)

	},



	Cat = {

		PawScale = Vector3.new(
			1.1,
			0.9,
			1.1
		),

		ToeScale = 1.15,

		ClawLength = 0.15,

		Squish = 0.3,

		PawColor =
			Color3.fromRGB(
				180,
				180,
				190
			),

		PadColor =
			Color3.fromRGB(
				255,
				120,
				160
			)

	},



	Canine = {

		PawScale = Vector3.new(
			1.15,
			1,
			1.25
		),

		ToeScale = 1,

		ClawLength = 0.4,

		Squish = 0.2,

		PawColor =
			Color3.fromRGB(
				160,
				120,
				80
			),

		PadColor =
			Color3.fromRGB(
				100,
				60,
				50
			)

	}

}



function PawStyles.Apply(
	styleName,
	paws,
	config
)


	local style =
		PawStyles.Styles[styleName]


	if not style then
		return
	end



	config.PawStyle =
		styleName


	config.ClawLength =
		style.ClawLength


	config.SquishAmount =
		style.Squish



	config.PawColor =
		style.PawColor


	config.PadColor =
		style.PadColor




	for _,data in pairs(paws) do


		if data then


			if data.Paw then

				data.Paw.Color =
					style.PawColor

				-- Get original size from attribute
				local originalSize =
					data.Paw:GetAttribute(
						"OriginalSize"
					)

				if originalSize then
					data.Paw.Size =
						originalSize
						*
						style.PawScale
				end

			end



			for _,bean in ipairs(data.Beans) do

				bean.Color =
					style.PadColor

				-- Get original size from attribute
				local originalSize =
					bean:GetAttribute(
						"OriginalSize"
					)

				if originalSize then
					bean.Size =
						originalSize
						*
						style.ToeScale
				end

			end


		end

	end


end



return PawStyles