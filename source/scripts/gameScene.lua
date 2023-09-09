local pd <const> = playdate
local gfx <const> = pd.graphics

class('GameScene').extends(gfx.sprite)

function GameScene:init()
	-- Background
	local backgroundImage = gfx.image.new("images/background")
	gfx.sprite.setBackgroundDrawingCallback(function()
		backgroundImage:draw(0, 0)
	end)

	Player(68, 120)
	CreateScoreDisplay(2, 2, 10)
	StartSpawner()
	SCREEN_SHAKE_SPRITE = ScreenShake()

	self:add()
end