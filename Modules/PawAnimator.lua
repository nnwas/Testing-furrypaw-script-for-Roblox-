local RunService = game:GetService("RunService")


local PawAnimator = {}


function PawAnimator.Start(character, paws, config)

	local humanoid =
		character:WaitForChild("Humanoid")


	local animatorData = {}


	local startTime = tick()



	for side,data in pairs(paws) do

		if data then

			animatorData[side] = {

				Paw = data.Paw,

				Beans = data.Beans,

				OriginalSize = {},

			}


			for _,bean in ipairs(data.Beans) do

				animatorData[side]
					.OriginalSize[bean]
					=
					bean.Size

			end

		end

	end



	local connection


	connection =
	RunService.RenderStepped:Connect(function()


		if not character.Parent then

			connection:Disconnect()

			return

		end



		local moving =
			humanoid.MoveDirection.Magnitude > 0



		local time =
			tick()
			-
			startTime



		for _,data in pairs(animatorData) do



			local bounce =
				math.sin(
					time * 5
				)
				*
				config.BounceAmount



			if moving then


				-- Walking squish

				for bean,size in pairs(data.OriginalSize) do


					local squish =
						1
						-
						math.abs(
							math.sin(
								time * 10
							)
						)
						*
						config.SquishAmount



					bean.Size =
						size
						*
						Vector3.new(
							1,
							squish,
							1
						)


				end



				data.Paw.CFrame =
					data.Paw.CFrame
					*
					CFrame.new(
						0,
						bounce * 0.03,
						0
					)



			else


				-- Idle breathing

				local idle =
					math.sin(
						time * 2
					)
					*
					0.02



				data.Paw.CFrame =
					data.Paw.CFrame
					*
					CFrame.new(
						0,
						idle,
						0
					)



			end

		end


	end)


end


return PawAnimator