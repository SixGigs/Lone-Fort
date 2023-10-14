-- PlayDate shorthand constants
local pd <const> = playdate
local gfx <const> = pd.graphics

-- Create the GameOverScene class
class('GameSceneGameOver').extends(gfx.sprite)

--- Load the Gameover Scene
--- @param score integer The final score of the player
function GameSceneGameOver:init(score)
	GAMEOVER = false
	CreateScoreDisplay(140, 116, score)
	self:setImage(gfx.image.new("images/gameover"))
	self:moveTo(200, 120)
	self:add()
end

--- This method runs every frame when the GameOverScene is added to the sprite group
--- It listens for an A button press to take the player back to the game
function GameSceneGameOver:update()
	if pd.buttonJustPressed(pd.kButtonA) then
		SCENE_MANAGER:switchScene(GameSceneMainLoop, "wipe")
	end
end