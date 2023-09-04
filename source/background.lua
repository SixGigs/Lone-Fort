local pd <const> = playdate
local gfx <const> = pd.graphics

class('Background').extends(gfx.sprite)

function Background:init()
	self:setImage(gfx.image.new("images/background"))
	self:moveTo(200, 120)
	self:add()
end