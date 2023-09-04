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
import "player"
import "background"
import "enemySpawner"
import "scoreDisplay"
import "screenShake"

-- PlayDate shorthand constants
local pd <const> = playdate
local gfx <const> = pd.graphics

-- Create ScreenShake object
local screenShakeSprite = ScreenShake()

-- Create the reset get function
function ResetGame()
	ResetScore()
	ClearEnemies()
	StopSpawner()
	StartSpawner()
	SetShakeAmount(10)
end

-- Create a global function for setting the screen shake amount
function SetShakeAmount(amount)
	screenShakeSprite:SetShakeAmount(amount)
end

-- Create objects and run functions to start the game
Background()
Player(30, 120)
CreateScoreDisplay()
StartSpawner()

-- Main game update function
function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
end