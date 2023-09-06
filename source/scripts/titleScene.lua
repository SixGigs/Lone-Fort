local pd <const> = playdate
local gfx <const> = pd.graphics

class('TitleScene').extends(gfx.sprite)

function TitleScene:init()
	self:setImage(gfx.image.new("images/titlescreen"))
	self:moveTo(200, 120)
	self:add()
end

function TitleScene:update()
	if pd.buttonJustPressed(pd.kButtonA) then
		SCENE_MANAGER:switchScene(GameScene)
	end
end