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
import "screenShake"
import "sceneManager"
import "titleScene"
import "gameScene"

-- PlayDate shorthand constants
local pd <const> = playdate
local gfx <const> = pd.graphics

-- Create ScreenShake object
local screenShakeSprite = ScreenShake()
SCENE_MANAGER = SceneManager()

TitleScene()

-- Create a global function for setting the screen shake amount
function SetShakeAmount(amount)
	screenShakeSprite:SetShakeAmount(amount)
end

-- Main game update function
function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
end