-- PlayDate shorthand constants
local pd <const> = playdate
local gfx <const> = pd.graphics

-- Create the enemy class
class('Enemy').extends(gfx.sprite)

---Create an in instance of the enemy with the parameters provided
---@param x         integer The X position to spawn the enemy (0+)
---@param y         integer The Y position to spawn the enemy (0 - 240)
---@param moveSpeed integer The distance in pixels to travel each frame
function Enemy:init(x, y, moveSpeed)
	self:setImage(gfx.image.new("images/goblin"))
	self:moveTo(x, y)
	self:add()

	self:setCollideRect(32, 16, 16, 16)

	self.moveSpeed = moveSpeed
end

-- This method runs every frame when the enemy is added to the sprite group
-- It makes the enemy move forward and detects when it reaches the goal
function Enemy:update()
	-- If the game is over then the enemies no longer need to move forward
	if GAMEOVER then
		return
	end

	self:moveBy(-self.moveSpeed, 0)
	if self.x < 116 then
		GAMEOVER = true
		SCENE_MANAGER:switchScene(GameSceneGameOver, "fade", SCORE)
	end
end

function Enemy:collisionResponse()
	return "overlap"
end