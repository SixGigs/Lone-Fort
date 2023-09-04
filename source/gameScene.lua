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

	self:add()
end

function GameScene:ResetGame()
	ResetScore()
	StopSpawner()
	ClearEnemies()
	StartSpawner()
	SetShakeAmount(10)
end