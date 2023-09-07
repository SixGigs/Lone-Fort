-- PlayDate Constants
local pd <const> = playdate
local gfx <const> = playdate.graphics

-- GunSmoke Class
class('GunSmoke').extends(AnimatedSprite)

-- Initialise the GunSmoke Class
function GunSmoke:init(x, y)
    -- Grab the gun smoke image table and initialise the animated sprite class
    local gunSmokeImageTable = gfx.imagetable.new("images/gunsmoke-table-48-32")
    GunSmoke.super.init(self, gunSmokeImageTable)

    -- Set the animation tiles and speed
    self:addState("playing", 1, 10, {tickStep = 2})
    self:playAnimation()

    self:moveTo(x, y)
    self:setZIndex(1000)

    pd.timer.performAfterDelay(500, function()
        self:remove()
    end)
end

function GunSmoke:update()
    self:updateAnimation()
end