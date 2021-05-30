local af = Def.ActorFrame{}

local holdingCtrl = false
local holdingShift = false

local InputHandler = function( event )

	-- if (somehow) there's no event, bail
	if not event then return end

	if event.type == "InputEventType_FirstPress" then

		--Trace(event.DeviceInput.button)

		if event.DeviceInput.button == "DeviceButton_left ctrl" then
			holdingCtrl = true
		elseif event.DeviceInput.button == "DeviceButton_left shift" then
			holdingShift = true
		end

		if holdingCtrl then
			if event.DeviceInput.button == "DeviceButton_r" then
					SCREENMAN:SetNewScreen("ScreenGameplay")
			end
		end

	end

	if event.type == "InputEventType_Release" then
		if event.DeviceInput.button == "DeviceButton_left ctrl" then
			holdingCtrl = false
		elseif event.DeviceInput.button == "DeviceButton_left shift" then
			holdingShift = false
		end
	end

end

af[#af+1] = Def.Actor {
	OnCommand=function(self)
		--FIXME: [when NOT in EventMode > trigger restart > back out with ESC] will go to ScreenSelectMusic with an empty songwheel
		--instead of fixing this right now, let's just require EventMode for this functionality
		if PREFSMAN:GetPreference("EventMode") then
			local screen = SCREENMAN:GetTopScreen()
			screen:AddInputCallback( InputHandler )
		else end
	end
}

return af
