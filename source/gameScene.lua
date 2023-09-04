local pd <const> = playdate
local gfx <const> = pd.graphics

class('GameScene').extends(gfx.sprite)

function GameScene:init()
    Background()
    Player(30, 120)
    CreateScoreDisplay()
    StartSpawner()

    self:add()
end