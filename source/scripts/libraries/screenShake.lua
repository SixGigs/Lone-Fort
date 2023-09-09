--TODO: At the moment if no screen shake is detected,
-- the display setOffset() runs every frame. Introduce an attribute to
-- stop this happening every frame and only once after a screen shake
-- happens

-- PlayDate shorthand constants
local pd <const> = playdate
local gfx <const> = pd.graphics

-- Create the screen shake class
class('ScreenShake').extends(gfx.sprite)

-- Create an instance of the class and add it to the sprites group
function ScreenShake:init()
	self.shakeAmount = 0
	self:add()
end

---This method sets the amount in pixels to shake the screen by
---@param amount integer The number of pixels to shake the screen by
function ScreenShake:SetShakeAmount(amount)
	self.shakeAmount = amount
end

-- This method runs every frame when the screen shake class is added to the sprite group
-- If a screen shake amount is set, it shakes the screen by that amount,
-- It decreases the shake amount by one every frame until it hits zero,
-- Then ensures that the screen is in the correct place
function ScreenShake:update()
	if self.shakeAmount > 0 then
		local shakeAngle = math.random() * math.pi * 2
		local shakeX = math.floor(math.cos(shakeAngle)) * self.shakeAmount
		local shakeY = math.floor(math.sin(shakeAngle)) * self.shakeAmount
		self.shakeAmount = self.shakeAmount - 1
		pd.display.setOffset(shakeX, shakeY)
	else
		pd.display.setOffset(0, 0)
	end
end