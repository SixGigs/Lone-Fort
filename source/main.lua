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

function ResetGame()
	ResetScore()
	ClearEnemies()
	StopSpawner()
	StartSpawner()
	SetShakeAmount(10)
end

function SetShakeAmount(amount)
	screenShakeSprite:SetShakeAmount(amount)
end

CreateScoreDisplay()
Background()
Player(30, 120)
StartSpawner()

function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
end