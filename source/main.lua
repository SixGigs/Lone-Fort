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
import "enemySpawner"
import "scoreDisplay"
import "screenShake"

-- PlayDate shorthand constants
local PD <const> = playdate
local GFX <const> = PD.graphics

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
Player(30, 120)
StartSpawner()

function PD.update()
    GFX.sprite.update()
    PD.timer.updateTimers()
end