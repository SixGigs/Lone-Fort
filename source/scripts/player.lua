-- Import the bullet class so we can create instances of bullet
import "bullet"

-- PlayDate shorthand constants
local pd <const> = playdate
local gfx <const> = pd.graphics

-- Create the player class
class('Player').extends(AnimatedSprite)

--- Create an instance of the player at the X and Y values provided
--- @param x   integer The X position of where to spawn the player (0 - 400)
--- @param y   integer The Y position of where to spawn the player (0 - 240)
--- @param gun string  The gun the player is holding
function Player:init(x, y, gun)
	-- State Machine
	local playerImageTable = gfx.imagetable.new("images/player-table-64-64")
	Player.super.init(self, playerImageTable)

	-- States
	self:addState("stationary", 1, 1)
	self:addState("stationaryRevolverShoot", 2, 2)
	self:playAnimation()

	-- Sprite Properties
	self:moveTo(x, y)
	self:setZIndex(Z_INDEXES.Player)
	self:setTag(TAGS.Player)
	self:setCollideRect(16, 8, 16, 48)

	-- Globals
	self.gun = gun
	self.shooting = false

	-- Gun IF Statement
	if gun == "Revolver" then
		self.speed = 4
		self.bulletSpeed = 48
		self.chamberingSpeed = 450
		self.gunPowder = 4 -- Used for screenshake on gun fire
	end

	-- Sound Effects
	self.shootSFX = pd.sound.fileplayer.new("sounds/shoot")
end


--- This method runs every frame when the player is added to the sprite group
function Player:update()
	if GAMEOVER then
		return
	end

	self:updateAnimation()
	self:handleMovementAndCollisions()
end


--- This method is called each frame by Player:update()
--- It handles the player moving and shooting
function Player:handleMovementAndCollisions()
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
end


--- This method is called by Player:handleMovementAndCollisions()
--- It manages creating the bullet, shoot cooldown, and sounds
function Player:ShootGun()
	self.shooting = true

	-- Create the right bullet & smoke for the gun
	if self.gun == "Revolver" then
		Bullet(self.x + 48, self.y, self.bulletSpeed)
		GunSmoke(self.x + 48, self.y)
		self:changeState("stationaryRevolverShoot")
	end

	-- Shake the screen
	SCREEN_SHAKE_SPRITE:SetShakeAmount(self.gunPowder)

	-- Play the shooting sound effect
	self.shootSFX:play()

	-- Chamber the next round
	self:ChamberNextRound()
end


--- This method sets a timer until the player can shoot next
function Player:ChamberNextRound()
	pd.timer.performAfterDelay(self.chamberingSpeed, function()
		self:changeState("stationary")
		self.shooting = false
	end)
end