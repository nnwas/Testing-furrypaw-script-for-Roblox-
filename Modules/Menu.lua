local UserInputService =
	game:GetService(
		"UserInputService"
	)

local Players =
	game:GetService(
		"Players"
	)


local PawStyles =
	require(
		script.Parent.PawStyles
	)


local Menu = {}



function Menu.Create(
	config,
	paws
)


	local player =
		Players.LocalPlayer


	local gui =
		Instance.new(
			"ScreenGui"
		)


	gui.Name =
		"FurryPawMenu"


	gui.ResetOnSpawn =
		false


	gui.Parent =
		player.PlayerGui





	local frame =
		Instance.new(
			"Frame"
		)


	frame.Size =
		UDim2.new(
			0,
			280,
			0,
			420
		)


	frame.Position =
		UDim2.new(
			0.05,
			0,
			0.2,
			0
		)


	frame.BackgroundTransparency =
		0.15


	frame.BackgroundColor3 =
		Color3.fromRGB(
			35,
			35,
			45
		)


	frame.Parent =
		gui





	local title =
		Instance.new(
			"TextLabel"
		)


	title.Size =
		UDim2.new(
			1,
			0,
			0,
			40
		)


	title.Text =
		"🐾 Furry Paw Controls"


	title.TextScaled =
		true


	title.Parent =
		frame





	-- Dragging

	local dragging = false
	local dragStart
	local startPos



	title.InputBegan:Connect(
	function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton1
			or input.UserInputType ==
			Enum.UserInputType.Touch then


			dragging = true

			dragStart =
				input.Position

			startPos =
				frame.Position

		end

	end)



	UserInputService.InputChanged:Connect(
	function(input)

		if dragging then


			local delta =
				input.Position
				-
				dragStart



			frame.Position =
				UDim2.new(
					startPos.X.Scale,
					startPos.X.Offset
					+
					delta.X,

					startPos.Y.Scale,
					startPos.Y.Offset
					+
					delta.Y
				)

		end

	end)



	UserInputService.InputEnded:Connect(
	function(input)

		dragging = false

	end)




	local y = 50



	local function Button(text, callback)


		local button =
			Instance.new(
				"TextButton"
			)


		button.Size =
			UDim2.new(
				1,
				-20,
				0,
				35
			)


		button.Position =
			UDim2.new(
				0,
				10,
				0,
				y
			)


		button.Text =
			text


		button.Parent =
			frame


		y += 40



		button.MouseButton1Click:Connect(
			callback
		)


	end





	-- Styles

	for name,_ in pairs(
		PawStyles.Styles
	) do


		Button(
			"Style: "..name,
			function()

				PawStyles.Apply(
					name,
					paws,
					config
				)

			end
		)

	end





	Button(
		"Toggle 5 Toe Beans",
		function()

			config.FiveToeMode =
				not config.FiveToeMode

			print(
				"5 Toe Mode:",
				config.FiveToeMode
			)

		end
	)





	Button(
		"Glow ON/OFF",
		function()

			config.GlowEnabled =
				not config.GlowEnabled

		end
	)





	Button(
		"Fluff ON/OFF",
		function()

			config.FluffEnabled =
				not config.FluffEnabled

		end
	)




	-- Simple sliders

	local function Slider(name, property)


		local value = 0.5


		local button =
			Instance.new(
				"TextButton"
			)


		button.Size =
			UDim2.new(
				1,
				-20,
				0,
				35
			)


		button.Position =
			UDim2.new(
				0,
				10,
				0,
				y
			)


		button.Text =
			name..": "..value


		button.Parent =
			frame


		y += 40



		button.MouseButton1Click:Connect(
		function()


			value += 0.1


			if value > 1 then

				value = 0

			end



			config[property] =
				value



			button.Text =
				name..": "..value



		end)


	end





	Slider(
		"Squish",
		"SquishAmount"
	)


	Slider(
		"Bounce",
		"BounceAmount"
	)


	Slider(
		"Claw Length",
		"ClawLength"
	)


	Slider(
		"Glow Strength",
		"GlowStrength"
	)


end



return Menu