-- Import the bullet class so we can create instances of bullet
import "bullet"

-- PlayDate shorthand constants
local pd <const> = playdate
local gfx <const> = pd.graphics

-- Create the player class
class('Player').extends(AnimatedSprite)

---Create an instance of the player at the X and Y values provided
---@param x integer The X position of where to spawn the player (0 - 400)
---@param y integer The Y position of where to spawn the player (0 - 240)
function Player:init(x, y, firearm)
	--- TODO: Should the player be called "Conrad"!?
	local playerImageTable = gfx.imagetable.new("images/player-table-64-64")
	Player.super.init(self, playerImageTable)

	-- Set the animation tiles and speed, "playAnimation" starts the animation
	self:addState("stationary", 1, 1)
	self:addState("shootRevolver", 2, 2)
	self:playAnimation()
	self:moveTo(x, y)
	self:add()

	-- States
	self.firearm = firearm
	self.shooting = false

	-- Firearms IF Statement
	if firearm == "Revolver" then
		self.speed = 4
		self.bulletSpeed = 48
		self.chamberingSpeed = 400
	end

	-- Sound Effects
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

	if pd.buttonJustPressed(pd.kButtonA) and self.shooting == false then
		self:ShootGun()
	end

	self:updateAnimation()
end

function Player:ShootGun()
	self.shooting = true

	-- Create the right bullet & smoke for the gun
	if self.firearm == "Revolver" then
		Bullet(self.x + 48, self.y, self.bulletSpeed)
		GunSmoke(self.x + 48, self.y)
		self:changeState("shootRevolver")
	end

	-- Shake the screen
	SCREEN_SHAKE_SPRITE:SetShakeAmount(5)

	-- Play the shooting sound effect
	self.shootSFX:play()

	-- Chamber the next round
	self:ChamberNextRound()
end

function Player:ChamberNextRound()
	pd.timer.performAfterDelay(self.chamberingSpeed, function()
		self:changeState("stationary")
		self.shooting = false
	end)
end