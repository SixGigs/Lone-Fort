import "scripts/enemy"

local pd <const> = playdate
local gfx <const> = pd.graphics

local spawnTimer

function StartSpawner()
	math.randomseed(pd.getSecondsSinceEpoch())
	CreateTimer()
end

function CreateTimer()
	local spawnTime = math.random(500, 1000)
	spawnTimer = pd.timer.performAfterDelay(spawnTime, function ()
		CreateTimer()
		SpawnEnemy()
	end)
end

function SpawnEnemy()
	local spawnPosition = math.random(32, 208)
	Enemy(430, spawnPosition, 1)
end

function StopSpawner()
	if spawnTimer then
		spawnTimer:remove()
	end
end

function ClearEnemies()
	local allSprites = gfx.sprite.getAllSprites()
	for _, sprite in ipairs(allSprites) do
		if sprite:isa(Enemy) then
			sprite:remove()
		end
	end
end