-- Import the enemy class so we can spawn them
import "scripts/enemy"

-- PlayDate shorthand constants
local pd <const> = playdate
local gfx <const> = pd.graphics

local spawnTimer

-- Starts the spawner by creating the first spawn timer
function StartSpawner()
	math.randomseed(pd.getSecondsSinceEpoch())
	CreateTimer()
end

-- Sets a timer between half a second to a full second
-- When the timer ends, spawn an enemy and make a new timer
function CreateTimer()
	local spawnTime = math.random(500, 1000)
	spawnTimer = pd.timer.performAfterDelay(spawnTime, function ()
		CreateTimer()
		SpawnEnemy()
	end)
end

-- Chooses a random spawn Y spawn position,
-- Then spawns an enemy off the screen with a move speed
function SpawnEnemy()
	local spawnPosition = math.random(48, 178)
	Enemy(430, spawnPosition, 2)
end

-- If there is a timer, remove it
function StopSpawner()
	if spawnTimer then
		spawnTimer:remove()
	end
end

-- Delete all enemies from the sprite group
-- It uses the enemy class as a filter to find the enemies
function ClearEnemies()
	local allSprites = gfx.sprite.getAllSprites()
	for _, sprite in ipairs(allSprites) do
		if sprite:isa(Enemy) then
			sprite:remove()
		end
	end
end