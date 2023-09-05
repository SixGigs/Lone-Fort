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

-- My LUA Files
import "scripts/player"
import "enemySpawner"
import "scoreDisplay"
import "scripts/libraries/screenShake"
import "scripts/libraries/sceneManager"
import "titleScene"
import "gameScene"

-- PlayDate shorthand constants
local pd <const> = playdate
local gfx <const> = pd.graphics

SCENE_MANAGER = SceneManager()

TitleScene()

-- Create a global function for setting the screen shake amount
function SetShakeAmount(amount)
	SCREEN_SHAKE_SPRITE:SetShakeAmount(amount)
end

-- Reset game
function ResetGame()
	ResetScore()
	StopSpawner()
	ClearEnemies()
	StartSpawner()
	SetShakeAmount(10)
end

-- Main game update function
function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
end