-- Import the bullet class so we can create instances of bullet
import "bullet"

-- PlayDate shorthand constants
local pd <const> = playdate
local gfx <const> = pd.graphics

-- Create the player class
class('Player').extends(gfx.sprite)

---Create an instance of the player at the X and Y values provided
---@param x integer The X position of where to spawn the player (0 - 400)
---@param y integer The Y position of where to spawn the player (0 - 240)
function Player:init(x, y)
	--- TODO: Should the player be called "Conrad"!?
	self:setImage(gfx.image.new("images/player"))
	self:moveTo(x, y)
	self:add()

	self.speed = 3
	self.shootSFX = pd.sound.fileplayer.new("sounds/shoot")
end

-- This method runs every frame when the player is added to the sprite group
-- It allows the player to move up, down, and create bullets with the A button
function Player:update()
	-- If the game is over no need to have the player move or gun fire
	if GAMEOVER then
		return
	end

	if pd.buttonIsPressed(pd.kButtonUp) then
		if self.y > 48 then
			self:moveBy(0, -self.speed)
		end
	elseif pd.buttonIsPressed(pd.kButtonDown) then
		if self.y < 178 then
			self:moveBy(0, self.speed)
		end
	end

	if pd.buttonJustPressed(pd.kButtonA) then
		self.shootSFX:play()
		Bullet(self.x + 48, self.y, 40)
		GunSmoke(self.x + 48, self.y)
		SCREEN_SHAKE_SPRITE:SetShakeAmount(5)
	end
end