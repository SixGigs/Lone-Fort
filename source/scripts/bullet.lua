-- Import the enemy to manage collisions
import "enemy"

-- PlayDate shorthand constants
local pd <const> = playdate
local gfx <const> = pd.graphics

-- Create the bullet class
class('Bullet').extends(gfx.sprite)

---Creates an instance of the bullet at the position & speed given
---@param x     integer The X position of the bullet (0 - 400)
---@param y     integer The Y position of the bullet (0 - 240)
---@param speed integer The speed the bullet travels at
function Bullet:init(x, y, speed)
	self:setImage(gfx.image.new("images/bullet"))
	self:setCollideRect(0, 0, self:getSize())
	self.speed = speed
	self:moveTo(x, y)
	self:add()

	self.dieSFX = pd.sound.fileplayer.new("sounds/kill")
end

-- This method runs every frame when bullet is added to the sprite group,
-- It moves the bullet, removes the bullet, and handles collisions
function Bullet:update()
	-- No need to move the bullet or check for collisions if the game is over
	if GAMEOVER then
		return
	end

	local actualX, _, collisions, length = self:moveWithCollisions(self.x + self.speed, self.y)
	if length > 0 then
		for _, collision in pairs(collisions) do
			local collidedObject = collision['other']
			if collidedObject:isa(Enemy) then
				self.dieSFX:play()
				collidedObject:remove()
				IncrementScore(1)
			end
		end
		self:remove()
	elseif actualX > 400 then
		self:remove()
	end
end