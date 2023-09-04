import "enemy"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Bullet').extends(gfx.sprite)

function Bullet:init(x, y, speed)
	self:setImage(gfx.image.new("images/bullet"))
	self:setCollideRect(0, 0, self:getSize())
	self.speed = speed
	self:moveTo(x, y)
	self:add()

	self.dieSFX = pd.sound.fileplayer.new("sounds/kill")
end

function Bullet:update()
	local actualX, _, collisions, length = self:moveWithCollisions(self.x + self.speed, self.y)
	if length > 0 then
		for _, collision in pairs(collisions) do
			local collidedObject = collision['other']
			if collidedObject:isa(Enemy) then
				self.dieSFX:play()
				collidedObject:remove()
				IncrementScore()
			end
		end
		self:remove()
	elseif actualX > 400 then
		self:remove()
	end
end