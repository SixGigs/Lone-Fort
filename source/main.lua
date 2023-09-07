--[[
	Lua programming standards:
	--------------------------
	Constants ---> ALL_CAPS
	Functions ---> CamelCase
	Variables ---> lower_case
]]--

-- PlayDate Libraries
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

-- Libraries
import "scripts/libraries/screenShake"
import "scripts/libraries/sceneManager"
import "scripts/libraries/AnimatedSprite"

-- Scripts
import "scripts/player"
import "scripts/enemySpawner"
import "scripts/scoreDisplay"
import "scripts/titleScene"
import "scripts/gameScene"
import "scripts/gameOverScene"
import "scripts/gunSmoke"

-- PlayDate shorthand constants
local pd <const> = playdate
local gfx <const> = pd.graphics

SCENE_MANAGER = SceneManager()

TitleScene()

-- Reset game
function ResetGame()
	ResetScore()
	StopSpawner()
	ClearEnemies()
	StartSpawner()
	SCREEN_SHAKE_SPRITE:SetShakeAmount(10)
end

-- Main game update function
function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
end