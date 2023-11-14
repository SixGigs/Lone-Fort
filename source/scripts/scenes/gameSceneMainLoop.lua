-- PlayDate shorthand constants
local pd <const> = playdate
local gfx <const> = pd.graphics

-- Create an array of tags (used to identify collisions)
TAGS = {
	Player = 1,
	Hazard = 2,
	Pickup = 3
}

-- Create the array of Z indexes (how far they are in the foreground)
Z_INDEXES = {
	Player = 100,
	Hazard = 20,
	Pickup = 50
}

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