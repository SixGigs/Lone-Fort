local pd <const> = playdate
local gfx <const> = pd.graphics

local scoreSprite
local score

function CreateScoreDisplay()
	scoreSprite = gfx.sprite.new()
	score = 0
	UpdateDisplay()
	scoreSprite:setCenter(0, 0)
	scoreSprite:moveTo(320, 4)
	scoreSprite:setZIndex(32767)
	scoreSprite:add()
end

function UpdateDisplay()
	local scoreText = "Score: " .. score
	local textWidth, textHeight = gfx.getTextSize(scoreText)
	local scoreImage = gfx.image.new(textWidth, textHeight)
	gfx.pushContext(scoreImage)
	gfx.drawText(scoreText, 0, 0)
	gfx.popContext()
	scoreSprite:setImage(scoreImage)
end

function IncrementScore()
	score = score + 1
	UpdateDisplay()
end

function ResetScore()
	score = 0
	UpdateDisplay()
end