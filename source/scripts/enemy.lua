local pd <const> = playdate
local gfx <const> = pd.graphics

class('Enemy').extends(gfx.sprite)

function Enemy:init(x, y, moveSpeed)
	self:setImage(gfx.image.new("images/goblin"))
	self:moveTo(x, y)
	self:add()

	self:setCollideRect(32, 16, 16, 32)

	self.moveSpeed = moveSpeed
end

function Enemy:update()
	self:moveBy(-self.moveSpeed, 0)
	if self.x < 116 then
		--ResetGame()
		SCENE_MANAGER:switchScene(GameOverScene)
	end
end

function Enemy:collisionResponse()
	return "overlap"
end