local pd <const> = playdate
local gfx <const> = pd.graphics

class('GameOverScene').extends(gfx.sprite)

function GameOverScene:init()
	self:setImage(gfx.image.new("images/gameover"))
	self:moveTo(200, 120)
	self:add()
end

function GameOverScene:update()
	if pd.buttonJustPressed(pd.kButtonA) then
		SCENE_MANAGER:switchScene(GameScene)
	end
end