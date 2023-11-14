-- Import the enemy class so we can spawn them
import "scripts/enemy"

-- PlayDate shorthand constants
local pd <const> = playdate
local gfx <const> = pd.graphics

local spawnTimer
local spawnTimeMin = 500
local spawnTimeMax = 1000
local speedIncreaseMin = 2
local speedIncreaseMax = 4

-- Starts the spawner by creating the first spawn timer
function StartSpawner()
	math.randomseed(pd.getSecondsSinceEpoch())
	CreateTimer()
end

-- Sets a timer between half a second to a full second
-- When the timer ends, spawn an enemy and make a new timer
function CreateTimer()
	local spawnTime = math.random(spawnTimeMin, spawnTimeMax)
	spawnTimer = pd.timer.performAfterDelay(spawnTime, function ()
		local spawnSpeedIncrease = math.random(speedIncreaseMin, speedIncreaseMax)
		spawnTimeMin = spawnTimeMin - spawnSpeedIncrease
		spawnSpeedIncrease = spawnSpeedIncrease * 2
		spawnTimeMax = spawnTimeMax - spawnSpeedIncrease

		if spawnTimeMin < 5 then
			spawnTimeMin = 5
		end

		if spawnTimeMax < 10 then
			spawnTimeMax = 10
		end

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

	spawnTimeMin = 500
	spawnTimeMax = 1000
	speedIncreaseMin = 2
	speedIncreaseMax = 4
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