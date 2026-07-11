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




	-- Lock button
	local lockButton =
		Instance.new(
			"TextButton"
		)


	lockButton.Name =
		"LockButton"


	lockButton.Size =
		UDim2.new(
			0,
			35,
			0,
			35
		)


	lockButton.Position =
		UDim2.new(
			1,
			-40,
			0,
			5
		)


	lockButton.Text =
		"🔓"


	lockButton.TextScaled =
		true


	lockButton.BackgroundColor3 =
		Color3.fromRGB(
			100,
			100,
			120
		)


	lockButton.BackgroundTransparency =
		0.3


	lockButton.Parent =
		frame


	local isLocked = false


	lockButton.MouseButton1Click:Connect(
	function()

		isLocked =
			not isLocked

		if isLocked then

			lockButton.Text =
				"🔒"

		else

			lockButton.Text =
				"🔓"

		end

	end)




	local title =
		Instance.new(
			"TextLabel"
		)


	title.Size =
		UDim2.new(
			1,
			-40,
			0,
			40
		)


	title.Position =
		UDim2.new(
			0,
			0,
			0,
			0
		)


	title.Text =
		"🐾 Furry Paw Controls"


	title.TextScaled =
		true


	title.BackgroundTransparency =
		1


	title.Parent =
		frame




	-- Dragging

	local dragging = false
	local dragStart
	local startPos



	title.InputBegan:Connect(
	function(input)

		if not isLocked then

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




	-- Scrollable Container
	local scrollFrame =
		Instance.new(
			"ScrollingFrame"
		)


	scrollFrame.Name =
		"ScrollContainer"


	scrollFrame.Size =
		UDim2.new(
			1,
			0,
			1,
			-45
		)


	scrollFrame.Position =
		UDim2.new(
			0,
			0,
			0,
			45
		)


	scrollFrame.BackgroundTransparency =
		1


	scrollFrame.ScrollBarThickness =
		8


	scrollFrame.CanvasSize =
		UDim2.new(
			0,
			0,
			0,
			0
		)


	scrollFrame.Parent =
		frame


	local y = 0
	local canvasHeight = 0



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


		button.BackgroundColor3 =
			Color3.fromRGB(
				60,
				60,
				80
			)


		button.TextScaled =
			true


		button.Parent =
			scrollFrame


		y += 40

		canvasHeight += 40



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
			name..": "..string.format(
				"%.1f",
				value
			)


		button.BackgroundColor3 =
			Color3.fromRGB(
				60,
				60,
				80
			)


		button.TextScaled =
			true


		button.Parent =
			scrollFrame


		y += 40

		canvasHeight += 40



		button.MouseButton1Click:Connect(
		function()


			value += 0.1


			if value > 1 then

				value = 0

			end



			config[property] =
				value



			button.Text =
				name..": "..string.format(
					"%.1f",
					value
				)



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


	-- Set canvas size for scrolling
	scrollFrame.CanvasSize =
		UDim2.new(
			0,
			0,
			0,
			canvasHeight
		)


end



return Menu