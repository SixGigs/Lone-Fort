-- PlayDate shorthand constants
local pd <const> = playdate
local gfx <const> = pd.graphics

local scoreSprite

-- Load my custom font and set it
local theBoldBoy = gfx.font.new("fonts/boldboyblack-table-12-12")
gfx.setFont(theBoldBoy)

-- Creates the score display sprite
---@param x     integer The X position of the score (0 to 400)
---@param y     integer The Y position of the score (0 to 240)
---@param value integer The number to start the score at
function CreateScoreDisplay(x, y, value)
	scoreSprite = gfx.sprite.new()
	SCORE = value
	UpdateDisplay()
	scoreSprite:setCenter(0, 0)
	scoreSprite:moveTo(x, y)
	scoreSprite:setZIndex(10000)
	scoreSprite:add()
end

-- Only used in this file, updates the sprite if the score is changed
function UpdateDisplay()
	local scoreText = "Score: " .. SCORE
	local textWidth, textHeight = gfx.getTextSize(scoreText)
	local scoreImage = gfx.image.new(textWidth, textHeight)
	gfx.pushContext(scoreImage)
	gfx.drawText(scoreText, 0, 0)
	gfx.popContext()
	scoreSprite:setImage(scoreImage)
end

-- Update the current score with the integer passed into the function
---@param increment integer The number to increase the score by
function IncrementScore(increment)
	SCORE = SCORE + increment
	UpdateDisplay()
end

-- Reset the score to zero
function ResetScore()
	SCORE = 0
	UpdateDisplay()
end