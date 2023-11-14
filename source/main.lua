--[[
	Lua programming standards:
	--------------------------
	Formatting conventions:
	Indentation ---> Tabs (not 4 spaces)
	
	Naming conventions:
	Globals   ---> ALL_CAPS
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
import "scripts/gunSmoke"

-- Scenes
import "scripts/scenes/gameSceneTitleScreen"
import "scripts/scenes/gameSceneMainLoop"
import "scripts/scenes/gameSceneGameOver"

-- PlayDate shorthand constants
local pd <const> = playdate
local gfx <const> = pd.graphics

-- Create the scene manager & load the title scene
SCENE_MANAGER = SceneManager()
GAMEOVER = false
GameSceneTitleScreen()
pd.drawFPS(2, 20)

-- Reset game
function ResetGame()
	StopSpawner()
	ClearEnemies()
end

-- Main game update function
function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
end