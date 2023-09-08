local pd <const> = playdate
local gfx <const> = pd.graphics

local scoreSprite
local score

-- Load my custom font and set it
local theBoldBoy = gfx.font.new("fonts/boldboy-table-10-10")
gfx.setFont(theBoldBoy)

function CreateScoreDisplay()
	scoreSprite = gfx.sprite.new()
	score = 0
	UpdateDisplay()
	scoreSprite:setCenter(0, 0)
	scoreSprite:moveTo(2, 2)
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