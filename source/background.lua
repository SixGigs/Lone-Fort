local pd <const> = playdate
local gfx <const> = pd.graphics

class('Background').extends(gfx.sprite)

function Background:init()
	local backgroundImage = gfx.image.new("images/background")
	self:setImage(backgroundImage)
	self:moveTo(200, 120)
	self:add()
end