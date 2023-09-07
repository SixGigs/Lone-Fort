import "bullet"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Player').extends(gfx.sprite)

function Player:init(x, y)
	self:setImage(gfx.image.new("images/player"))
	self:moveTo(x, y)
	self:add()

	self.speed = 3
	self.shootSFX = pd.sound.fileplayer.new("sounds/shoot")
end

function Player:update()
	if pd.buttonIsPressed(pd.kButtonUp) then
		if self.y > 0 then
			self:moveBy(0, -self.speed)
		end
	elseif pd.buttonIsPressed(pd.kButtonDown) then
		if self.y < 240 then
			self:moveBy(0, self.speed)
		end
	end

	if pd.buttonJustPressed(pd.kButtonA) then
		self.shootSFX:play()
		Bullet(self.x + 48, self.y, 40) -- Used to be 5
		GunSmoke(self.x + 48, self.y)
		SCREEN_SHAKE_SPRITE:SetShakeAmount(5)
	end
end