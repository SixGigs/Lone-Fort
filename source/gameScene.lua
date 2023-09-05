local pd <const> = playdate
local gfx <const> = pd.graphics

class('GameScene').extends(gfx.sprite)

function GameScene:init()
	-- Background
	local backgroundImage = gfx.image.new("images/background")
	gfx.sprite.setBackgroundDrawingCallback(function()
		backgroundImage:draw(0, 0)
	end)

	Player(30, 120)
	CreateScoreDisplay()
	StartSpawner()
	SCREEN_SHAKE_SPRITE = ScreenShake()

	self:add()
end