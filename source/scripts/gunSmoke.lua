-- PlayDate shorthand constants
local pd <const> = playdate
local gfx <const> = playdate.graphics

-- Create the player class
class('GunSmoke').extends(AnimatedSprite)

---Create an instance of gun smoke at the X and Y values provided
---@param x integer The X position of where to spawn the gun smoke (0 - 400)
---@param y integer The Y position of where to spawn the gun smoke (0 - 240)
function GunSmoke:init(x, y)
    -- Grab the gun smoke image table and initialise the animated sprite class
    local gunSmokeImageTable = gfx.imagetable.new("images/gunsmoke-table-48-32")
    GunSmoke.super.init(self, gunSmokeImageTable)

    -- Set the animation tiles and speed, "playAnimation" starts the animation
    self:addState("playing", 1, 10, {tickStep = 2})
    self:playAnimation()

    -- Move the sprite to the X and Y values provided, set the Z index too
    self:moveTo(x, y)
    self:setZIndex(1000)

    -- Set a timer, and after half a second delete the instance of itself
    pd.timer.performAfterDelay(500, function()
        -- No need to remove the smoke cloud on timer up if the game is over
        if GAMEOVER then
            return
        end

        self:remove()
    end)
end

-- This method runs every frame when the gun smoke is added to the sprite group
-- It allows the gunsmoke animation to play
function GunSmoke:update()
    -- No need to up date the smoke animation if the game is over
    if GAMEOVER then
        return
    end

    self:updateAnimation()
end