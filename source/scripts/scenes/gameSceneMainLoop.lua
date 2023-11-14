-- PlayDate shorthand constants
local pd <const> = playdate
local gfx <const> = pd.graphics

-- Create the GameScene class
class('GameSceneMainLoop').extends(gfx.sprite)

-- Create an instance of the game
function GameSceneMainLoop:init()
	-- Background
	local backgroundImage = gfx.image.new("images/background")
	gfx.sprite.setBackgroundDrawingCallback(function()
		backgroundImage:draw(0, 0)
	end)

	-- Make player, score display, enemy spawner, screen shake
	Player(68, 120, "Revolver")
	CreateScoreDisplay(2, 2, 0)
	StartSpawner()
	SCREEN_SHAKE_SPRITE = ScreenShake()

	-- Add to the sprite group
	self:add()
end