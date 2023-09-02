import "enemy"

local pd <const> = playdate
local gfx <const> = pd.graphics

local spawnTimer

function StartSpawner()
    math.randomseed(pd.getSecondsSinceEpoch())
    createTimer()
end

function createTimer()
    local spawnTime = math.random(500, 1000)
    spawnTimer = pd.timer.performAfterDelay(spawnTime, function ()
        createTimer()
        spawnEnemy()
    end)
end

function spawnEnemy()
    local spawnPosition = math.random(10, 230)
    Enemy(430, spawnPosition, 1)
end

function StopSpawner()
    if spawnTimer then
        spawnTimer:remove()
    end
end

function ClearEnemies()
    local allSprites = gfx.sprite.getAllSprites()
    for index, sprite in ipairs(allSprites) do
        if sprite:isa(Enemy) then
            sprite:remove()
        end
    end
end