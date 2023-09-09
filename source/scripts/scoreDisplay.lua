local pd <const> = playdate
local gfx <const> = pd.graphics

local scoreSprite

-- Load my custom font and set it
local theBoldBoy = gfx.font.new("fonts/boldboy-table-10-10")
gfx.setFont(theBoldBoy)

function CreateScoreDisplay(x, y, value)
	scoreSprite = gfx.sprite.new()
	SCORE = value
	UpdateDisplay()
	scoreSprite:setCenter(0, 0)
	scoreSprite:moveTo(x, y)
	scoreSprite:setZIndex(32767)
	scoreSprite:add()
end

function UpdateDisplay()
	local scoreText = "Score: " .. SCORE
	local textWidth, textHeight = gfx.getTextSize(scoreText)
	local scoreImage = gfx.image.new(textWidth, textHeight)
	gfx.pushContext(scoreImage)
	gfx.drawText(scoreText, 0, 0)
	gfx.popContext()
	scoreSprite:setImage(scoreImage)
end

function IncrementScore()
	SCORE = SCORE + 1
	UpdateDisplay()
end

function ResetScore()
	SCORE = 0
	UpdateDisplay()
end